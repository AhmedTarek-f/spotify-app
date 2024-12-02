import 'dart:math';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
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
  final _favoritesController = Get.isRegistered<FavoritesController>()? FavoritesController.instance :Get.put(FavoritesController());
  final _profileController = Get.isRegistered<ProfileController>()? ProfileController.instance : Get.put(ProfileController());
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;
  int index = Get.arguments["index"];

  RxInt currentSongIndex = 0.obs;

  SongModel get currentSong => playlistSongs[currentSongIndex.value];

  @override
  void onInit() async{
    final bool? isOfflineMode = Get.arguments["isOffline"];
    super.onInit();
    currentSongIndex.value = index;
    if( isOfflineMode == false) fetchIfFavoriteSongs(songId: currentSong.songId);
    if( isOfflineMode == false) fetchIfPublicFavoriteSongs(songId: currentSong.songId);
    await fetchAllSongsOneByOne(songIndex: currentSongIndex.value);
  }
  Future<void> toggleRepeat() async{
    isRepeating.value = !isRepeating.value;
    if(isRepeating.value)  await player.value.setLoopMode(LoopMode.one);
    if(!isRepeating.value)  await player.value.setLoopMode(LoopMode.off);
  }
  Future<void> toggleShuffle() async{
    isShuffling.value = !isShuffling.value;
    if(isShuffling.value) await player.value.setShuffleModeEnabled(true);
    if(!isShuffling.value) await player.value.setShuffleModeEnabled(false);
  }
  void toggleShowLyrics(){
    isShowingLyrics.value = !isShowingLyrics.value;
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

  Future<void> fetchAllSongsOneByOne({required int songIndex}) async {

    final bool? isOfflineMode = Get.arguments["isOffline"];
    currentSongIndex.value = songIndex;
    final playlist = ConcatenatingAudioSource(
      // Start loading next item just before reaching it
      useLazyPreparation: true,
      // Customise the shuffle algorithm
      shuffleOrder: DefaultShuffleOrder(),
      // Specify the playlist items
      children: playlistSongs.map((song) => isOfflineMode!?AudioSource.file(song.songUrl) :AudioSource.uri(Uri.parse(song.songUrl))).toList(),
    );
    // Load and play the playlist
    await player.value.setAudioSource(playlist, initialIndex: songIndex, initialPosition: Duration.zero);
    player.value.positionStream.listen((p) {
      position.value = p;
    });
    player.value.durationStream.listen((d) {
      duration.value = d!;
    });
    currentSongIndex.value = player.value.currentIndex!;
    isPlaying.value = true;
    if(isOfflineMode == false) if(Get.isRegistered<PlaylistDetailsController>()) PlaylistDetailsController.instance.isPlaying.value = true;
    await player.value.play();
    // await player.value.seek(Duration.zero, index: 2);    // Skip to the start of track3.mp3
    // await player.value.setLoopMode(LoopMode.all);        // Set playlist to loop (off|all|one)
    // await player.value.setShuffleModeEnabled(true);      // Shuffle playlist order (true|false)

  }

  Future<void> playPreviousSong() async {
    if(player.value.currentIndex!>0){
      final bool? isOfflineMode = Get.arguments["isOffline"];
      await player.value.seekToPrevious();
      currentSongIndex.value = player.value.currentIndex ??0;
      if( isOfflineMode == false) await fetchIfFavoriteSongs(songId: currentSong.songId);
      if( isOfflineMode == false) await fetchIfPublicFavoriteSongs(songId: currentSong.songId);
    }
    else{
      Loaders.warningSnackBar(title: "Alert!",message: "No previous songs are available.");
    }
  }

  Future<void> playNextSong() async {
    if(player.value.currentIndex! < playlistSongs.length-1){
      final bool? isOfflineMode = Get.arguments["isOffline"];
      await player.value.seekToNext();
      currentSongIndex.value = player.value.currentIndex ??0;
      if( isOfflineMode == false) await fetchIfFavoriteSongs(songId: currentSong.songId);
      if( isOfflineMode == false) await fetchIfPublicFavoriteSongs(songId: currentSong.songId);
    }
    else{
      Loaders.warningSnackBar(title: "Alert!",message: "You have already reached the last song in this playlist");
    }
  }

  @override
  void onClose() {
    currentSongIndex.value=0;
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