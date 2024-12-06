import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';
import 'package:spotify/features/song_details/data/repository/song_details_repository.dart';

class SingleSongDetailsController extends GetxController {
  static SingleSongDetailsController get instance => Get.find();
  RxBool isFavorite = false.obs;
  RxBool isFavoritePublic = false.obs;
  RxBool isPlaying = false.obs;
  RxBool isShowingLyrics = false.obs;
  final _songDetailsRepository = Get.isRegistered<SongDetailsRepository>()? SongDetailsRepository.instance :Get.put(SongDetailsRepository());
  final _favoritesController = Get.isRegistered<FavoritesController>()? FavoritesController.instance :Get.put(FavoritesController());
  final _profileController = Get.isRegistered<ProfileController>()? ProfileController.instance : Get.put(ProfileController());
  SongModel currentSong = Get.arguments["songDetails"];
  Rx<AudioPlayer> player = getIt.get<AudioPlayer>().obs;
  RxBool isRepeating = false.obs;
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;


  @override
  void onInit() async{

    super.onInit();
    fetchIfFavoriteSongs(songId: currentSong.songId);
    fetchIfPublicFavoriteSongs(songId: currentSong.songId);
    fetchSingleSong();
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

  Future<void> toggleRepeat() async{
    isRepeating.value = !isRepeating.value;
    if(isRepeating.value)  await player.value.setLoopMode(LoopMode.one);
    if(!isRepeating.value)  await player.value.setLoopMode(LoopMode.off);
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

  Future<void> fetchSingleSong() async {
    final playlist = ConcatenatingAudioSource(
      // Start loading next item just before reaching it
      useLazyPreparation: true,
      // Customise the shuffle algorithm
      shuffleOrder: DefaultShuffleOrder(),
      // Specify the playlist items
      children: [
        AudioSource.uri(Uri.parse(currentSong.songUrl))
      ],
    );
    // Load and play the playlist
    await player.value.setAudioSource(playlist, initialIndex: 0, initialPosition: Duration.zero);
    player.value.positionStream.listen((p) {
      position.value = p;
    });
    player.value.durationStream.listen((d) {
      if(d != null){
        duration.value = d;
      }
    });
    player.value.playerStateStream.listen((state) async {
      if (state.processingState == ProcessingState.completed) {
        isPlaying.value=false;
        await player.value.pause();
        await player.value.seek(const Duration(seconds:0));
      }
    });

    isPlaying.value = true;
    await player.value.play();
  }


  @override
  void onClose(){
    player.value.stop();
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