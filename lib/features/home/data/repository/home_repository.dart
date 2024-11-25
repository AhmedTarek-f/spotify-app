import 'package:get/get.dart';
import 'package:spotify/features/home/data/data_sources/remote_data_sources/home_remote_data.dart';
import 'package:spotify/features/home/data/models/new_album_model.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class HomeRepository extends GetxController {
  static HomeRepository get instance => Get.find();
  final _homeRemoteData = Get.put(HomeRemoteData());

  Future<List<SongsCollectionModel>> fetchAllPlaylists() async{
    try{
     return await _homeRemoteData.fetchAllPlaylists();
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> addToRecentlyPlayedPlaylists({required SongsCollectionModel playlist}) async {
    try{
      return await _homeRemoteData.addToRecentlyPlayedPlaylists(playlist: playlist);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<List<NewAlbumModel>> fetchAllNewAlbums() async{
    try{
      return await _homeRemoteData.fetchAllNewAlbums();
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> addToYourCreatedPlaylists({required SongsCollectionModel playlist}) async {
    try{
      return await _homeRemoteData.addToYourCreatedPlaylists(playlist: playlist);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<List<SongsCollectionModel>> fetchRecentlyPlayedPlaylists() async{
    try{
      return await _homeRemoteData.fetchRecentlyPlayedPlaylists();
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<List<SongsCollectionModel>> fetchYourCreatedPlaylists() async {
    try {
      return await _homeRemoteData.fetchYourCreatedPlaylists();
    }
    catch (e) {
      throw e.toString();
    }
  }

  Future<List<SongModel>> fetchSongs() async {
    try{
      return await _homeRemoteData.fetchSongs();
    }
    catch (e) {
      throw e.toString();
    }
  }

}