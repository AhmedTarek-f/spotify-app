import 'package:get/get.dart';
import 'package:spotify/features/song_details/data/data_sources/remote_data_source/song_details_remote_data.dart';

class SongDetailsRepository extends GetxController {
  static SongDetailsRepository get instance => Get.find();
  final _songDetailsRemoteData = Get.put(SongDetailsRemoteData());

  Future<void> addToYourFavoriteSongs({required String songId}) async {
    try{
      await _songDetailsRemoteData.addToYourFavoriteSongs(songId: songId);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> deleteFromYourFavoriteSongs({required String songId}) async {
    try{
      await _songDetailsRemoteData.deleteFromYourFavoriteSongs(songId: songId);
    }

    catch (e)
    {
      throw e.toString();
    }
  }

  Future<bool> fetchIfFavoriteSongs({required String songId}) async {
    try{
      return await _songDetailsRemoteData.fetchIfFavoriteSongs(songId: songId);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> addToYourPublicFavoriteSongs({required String songId}) async {
    try{
      await _songDetailsRemoteData.addToYourPublicFavoriteSongs(songId: songId);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> deleteFromYourPublicFavoriteSongs({required String songId}) async {
    try{
      await _songDetailsRemoteData.deleteFromYourPublicFavoriteSongs(songId: songId);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<bool> fetchIfPublicFavoriteSongs({required String songId}) async {
    try{
      return await _songDetailsRemoteData.fetchIfPublicFavoriteSongs(songId: songId);

    }
    catch (e)
    {
      throw e.toString();
    }
  }
}