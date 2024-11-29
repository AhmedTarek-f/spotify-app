import 'package:get/get.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/playlist_details/data/data_sources/remote_data_sources/playlist_details_remote_data.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class PlaylistDetailsRepository extends GetxController{
  static PlaylistDetailsRepository get instance => Get.find();
  final PlaylistDetailsRemoteData _playlistDetailsRemoteData = Get.put(PlaylistDetailsRemoteData());

  Future<List<SongModel>> fetchPlaylistSongs({required List<String>? listOfSongs}) async {
    try{
      return await _playlistDetailsRemoteData.fetchPlaylistSongs(listOfSongs: listOfSongs);
    }
    catch (e)
    {
      throw e.toString();
    }
  }
  Future<void> deleteCreatedPlaylist({required SongsCollectionModel playlist}) async {
    try{
      await _playlistDetailsRemoteData.deleteCreatedPlaylist(playlist: playlist);
    }
    catch (e)
    {
      throw e.toString();
    }
  }
  Future<void> UpdateRecentlyPlayedTime({required SongsCollectionModel playlist}) async {
    try{
      await _playlistDetailsRemoteData.UpdateRecentlyPlayedTime(playlist: playlist);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> deleteSongFromCreatedPlaylist({required SongsCollectionModel playlist,required List<String> listOfSongs}) async {
    try{
      await _playlistDetailsRemoteData.deleteSongFromCreatedPlaylist(playlist: playlist,listOfSongs: listOfSongs);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> addCreatedPlaylistToPublic({required SongsCollectionModel playlist}) async {
    try{
     await _playlistDetailsRemoteData.addCreatedPlaylistToPublic(playlist: playlist);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> deleteCreatedPlaylistFromPublic({required SongsCollectionModel playlist}) async {
    try{
      await _playlistDetailsRemoteData.deleteCreatedPlaylistFromPublic(playlist: playlist);
    }
    catch (e)
    {
      throw e.toString();
    }
  }
  Future<bool> isCreatedPlaylistAtPublic({required SongsCollectionModel playlist}) async {
    try{
      return await _playlistDetailsRemoteData.isCreatedPlaylistAtPublic(playlist: playlist);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

}