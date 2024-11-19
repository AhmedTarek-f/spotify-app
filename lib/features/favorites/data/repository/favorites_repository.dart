import 'package:get/get.dart';
import 'package:spotify/features/favorites/data/data_sources/remote_data_source/favorites_remote_data.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class FavoritesRepository extends GetxController{
  static FavoritesRepository get instance => Get.find();
  final _favoritesRemoteData = Get.put(FavoritesRemoteData());

  Future<List<SongModel>> fetchAllFavoriteSongs() async {
    try{
     return await _favoritesRemoteData.fetchAllFavoriteSongs();
    }
    catch (e)
    {
      throw e.toString();
    }
  }
  Future<void> deleteFromYourFavoriteSongs({required String songId}) async {
    try{
      await _favoritesRemoteData.deleteFromYourFavoriteSongs(songId: songId);
    }

    catch (e)
    {
      throw e.toString();
    }
  }
}