import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/song_details/data/repository/song_details_repository.dart';

class SongDetailsController extends GetxController {
  static SongDetailsController get instance => Get.find();
  RxBool isFavorite = false.obs;
  RxBool isFavoritePublic = false.obs;
  RxBool isPlaying = false.obs;
  Rx<AudioPlayer> player = AudioPlayer().obs;
  final SongModel songDetails = Get.arguments["songDetails"];
  final _songDetailsRepository = Get.put(SongDetailsRepository());
  final _favoritesController = Get.put(FavoritesController());
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    fetchIfFavoriteSongs(songId: songDetails.songId);
    fetchIfPublicFavoriteSongs(songId: songDetails.songId);
    fetchSong(songUrl: songDetails.songUrl);
  }

  String formatDuration(Duration d){
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}";
  }

  void handlePlayAndPause(){
    if(player.value.playing){
      isPlaying.value=false;
      player.value.pause();
    }
    else{
      isPlaying.value = true;
      player.value.play();
    }
  }

  void handleSeek(double value){
    player.value.seek(Duration(seconds: value.toInt()));
  }

  Future<void> fetchSong({required String songUrl}) async {
    await player.value.setUrl(songUrl);
    player.value.positionStream.listen((p){position.value=p;});
    player.value.durationStream.listen((d){duration.value=d!;});
    player.value.playerStateStream.listen((state){
      if(state.processingState == ProcessingState.completed){
        position.value = Duration.zero;
        player.value.pause();
        player.value.seek(position.value);
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
    _favoritesController.favoriteSongsList.add(songDetails);
    await addToYourFavoriteSongs(songId: songId);
  }
  Future<void> removeFromFavorite({required String songId}) async {
    isFavorite.value = false;
    _favoritesController.favoriteSongsList.removeWhere((song)=> song.songId == songId);
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
}