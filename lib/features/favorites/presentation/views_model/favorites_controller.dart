import 'package:get/get.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/favorites/data/repository/favorites_repository.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class FavoritesController extends GetxController{
  static FavoritesController get instance => Get.find();
  final _favoritesRepository = Get.put(FavoritesRepository());
  RxList<SongModel> favoriteSongsList = <SongModel>[].obs;
  final RxBool isFavoriteSongsLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    fetchAllFavoriteSongs();
  }

  Future<void> fetchAllFavoriteSongs() async {
    try{
      isFavoriteSongsLoading.value = true;
      final allFavoriteSongs = await _favoritesRepository.fetchAllFavoriteSongs();
      favoriteSongsList.assignAll(allFavoriteSongs);
      isFavoriteSongsLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> deleteFromYourFavoriteSongs({required String songId}) async {
    try{
      await _favoritesRepository.deleteFromYourFavoriteSongs(songId: songId);
    }

    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }
}