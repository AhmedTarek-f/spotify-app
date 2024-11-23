import 'dart:math';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';
import 'package:spotify/features/song_details/data/repository/song_details_repository.dart';

class SongDetailsController extends GetxController {
  static SongDetailsController get instance => Get.find();
  RxBool isFavorite = false.obs;
  RxBool isFavoritePublic = false.obs;
  RxBool isPlaying = false.obs;
  RxBool isRepeating = false.obs;
  RxBool isShuffling = false.obs;
  RxBool isShowingLyrics = false.obs;
  Rx<AudioPlayer> player = getIt.get<AudioPlayer>().obs;
  List<SongModel> playlistSongs = Get.arguments["playlistSongs"];
  final _songDetailsRepository = Get.put(SongDetailsRepository());
  final _favoritesController = Get.put(FavoritesController());
  final _profileController = Get.put(ProfileController());
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;
  final int index = Get.arguments["index"];
  RxInt currentSongIndex = 0.obs;

  SongModel get currentSong => playlistSongs[currentSongIndex.value];

  @override
  void onInit() {
    super.onInit();
    currentSongIndex.value = index;
    fetchIfFavoriteSongs(songId: currentSong.songId);
    fetchIfPublicFavoriteSongs(songId: currentSong.songId);
    fetchSong(songUrl: currentSong.songUrl);
  }
  void toggleRepeat() {
    isRepeating.value = !isRepeating.value;
  }
  void toggleShuffle(){
    isShuffling.value = !isShuffling.value;
  }
  void toggleShowLyrics(){
    isShowingLyrics.value = !isShowingLyrics.value;
  }

  String formatDuration(Duration d){
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}";
  }

  Future<void> handlePlayAndPause() async{
    if(player.value.playing){
      isPlaying.value=false;
      await player.value.pause();
    }
    else{
      isPlaying.value = true;
      await player.value.play();
    }
  }

  void handleSeek(double value){
    player.value.seek(Duration(seconds: value.toInt()));
  }

  Future<void> fetchSong({required String songUrl}) async {
    await player.value.setUrl(songUrl);

    // Listen to position and duration streams
    player.value.positionStream.listen((p) {
      position.value = p;
    });
    player.value.durationStream.listen((d) {
      duration.value = d!;
    });

    // Listen to player state stream for handling song completion
    player.value.playerStateStream.listen((state) async {
      if (state.processingState == ProcessingState.completed) {
        // Check if repeating is enabled
        if (isRepeating.value) {
          player.value.seek(Duration.zero);
          await player.value.play();
        }
        else if(isShuffling.value){
            playlistSongs.shuffle(Random());

            currentSongIndex.value = 0;

            isPlaying.value = false;
            await  player.value.setUrl(currentSong.songUrl);
            await fetchIfFavoriteSongs(songId: currentSong.songId);
            await fetchIfPublicFavoriteSongs(songId: currentSong.songId);
            await player.value.play();
            isPlaying.value = true;
        }
        else {
          // Move to the next song or loop back to the first song
          if (currentSongIndex.value < (playlistSongs.length - 1)) {
            currentSongIndex.value++;
            await  player.value.setUrl(currentSong.songUrl);
            await player.value.play();
            isPlaying.value = true;
            await fetchIfFavoriteSongs(songId: currentSong.songId);
            await fetchIfPublicFavoriteSongs(songId: currentSong.songId);
          } else {
            // Loop back to the first song
            if(currentSongIndex.value != 0)
              {
                currentSongIndex.value = 0;
                await  player.value.setUrl(currentSong.songUrl);
                await player.value.pause();
                isPlaying.value = false;
                await fetchIfFavoriteSongs(songId: currentSong.songId);
                await fetchIfPublicFavoriteSongs(songId: currentSong.songId);
              }
            else {
              player.value.seek(Duration.zero);
              await player.value.pause();
              isPlaying.value = false;
            }
          }

        }
      }
    });
  }

  Future<void> addToYourFavoriteSongs({required String songId}) async {
    try{
      await _songDetailsRepository.addToYourFavoriteSongs(songId: songId);
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> deleteFromYourFavoriteSongs({required String songId}) async {
    try{
      await _songDetailsRepository.deleteFromYourFavoriteSongs(songId: songId);
    }

    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> fetchIfFavoriteSongs({required String songId}) async {
    try{
      isFavorite.value = await _songDetailsRepository.fetchIfFavoriteSongs(songId: songId);
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> addToFavorite({required String songId}) async {
    isFavorite.value = true;
    await addToYourFavoriteSongs(songId: songId);
  }
  Future<void> removeFromFavorite({required String songId}) async {
    isFavorite.value = false;
    await deleteFromYourFavoriteSongs(songId: songId);
  }

  Future<void> addOrRemoveFavoriteSong({required String songId}) async {
    if(isFavorite.value){
      await removeFromFavorite(songId: songId);
    }
    else{
      await addToFavorite(songId: songId);
    }
  }

  Future<void> addToYourPublicFavoriteSongs({required String songId}) async {
    try{
      await _songDetailsRepository.addToYourPublicFavoriteSongs(songId: songId);
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> deleteFromYourPublicFavoriteSongs({required String songId}) async {
    try{
      await _songDetailsRepository.deleteFromYourPublicFavoriteSongs(songId: songId);
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> fetchIfPublicFavoriteSongs({required String songId}) async {
    try{
      isFavoritePublic.value= await _songDetailsRepository.fetchIfPublicFavoriteSongs(songId: songId);
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }
  Future<void> addToFavoritePublicSongs() async{
    isFavoritePublic.value=true;
    await addToYourPublicFavoriteSongs(songId: currentSong.songId);
  }

  Future<void> removeFromFavoritePublicSongs() async{
    isFavoritePublic.value=false;
    await deleteFromYourPublicFavoriteSongs(songId:currentSong.songId);
  }

  Future<void> playPreviousSong() async {
    if (currentSongIndex.value > 0) {
      currentSongIndex.value--;
      isPlaying.value = false;
      await  player.value.setUrl(currentSong.songUrl);
      await fetchIfFavoriteSongs(songId: currentSong.songId);
      await fetchIfPublicFavoriteSongs(songId: currentSong.songId);
      await player.value.play();
      isPlaying.value = true;
    }
    else{
      Loaders.warningSnackBar(title: "Alert!",message: "No previous songs are available.");
    }
  }

  Future<void> playNextSong() async {
    if (currentSongIndex.value < (playlistSongs.length-1)) {
        currentSongIndex.value++;
        isPlaying.value = false;
        await  player.value.setUrl(currentSong.songUrl);
        await fetchIfFavoriteSongs(songId: currentSong.songId);
        await fetchIfPublicFavoriteSongs(songId: currentSong.songId);
        await player.value.play();
        isPlaying.value = true;
    }
    else{
      Loaders.warningSnackBar(title: "Alert!",message: "You have already reached the last song in this playlist");

    }
  }

  @override
  void onClose() {
    if(isFavorite.value == false && _favoritesController.favoriteSongsList.any((song)=>song.songId == currentSong.songId)){
      _favoritesController.favoriteSongsList.removeWhere((song)=> song.songId == currentSong.songId);
    }
    if(isFavorite.value == true && !_favoritesController.favoriteSongsList.any((song)=>song.songId == currentSong.songId)){
      _favoritesController.favoriteSongsList.add(currentSong);
    }
    if(isFavoritePublic.value == false && _profileController.publicSongsList.any((song)=>song.songId == currentSong.songId)){
      _profileController.publicSongsList.removeWhere((song) => song.songId == currentSong.songId);
    }
    if(isFavoritePublic.value == true && !_profileController.publicSongsList.any((song)=>song.songId == currentSong.songId)){
      _profileController.publicSongsList.add(currentSong);
    }
    super.onClose();
  }
}