import 'package:get/get.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';
import 'package:spotify/features/song_details/data/repository/song_details_repository.dart';

class SongDetailsController extends GetxController {
  static SongDetailsController get instance => Get.find();
  RxBool isFavorite = false.obs;
  RxBool isFavoritePublic = false.obs;
  RxBool isShowingLyrics = false.obs;
  List<SongModel> playlistSongs = Get.arguments["playlistSongs"];
  final _songDetailsRepository = Get.isRegistered<SongDetailsRepository>()? SongDetailsRepository.instance :Get.put(SongDetailsRepository());
  final _favoritesController = Get.isRegistered<FavoritesController>()? FavoritesController.instance :Get.put(FavoritesController());
  final _profileController = Get.isRegistered<ProfileController>()? ProfileController.instance : Get.put(ProfileController());
  final bool isOfflineMode = Get.arguments["isOffline"] ?? false;
  SongModel  currentSong = Get.arguments["songDetails"];

  @override
  void onInit() async{

    super.onInit();
    if( isOfflineMode == false) fetchIfFavoriteSongs(songId: currentSong.songId);
    if( isOfflineMode == false) fetchIfPublicFavoriteSongs(songId: currentSong.songId);
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