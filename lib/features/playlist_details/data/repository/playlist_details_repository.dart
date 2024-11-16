import 'package:get/get.dart';
import 'package:spotify/features/playlist_details/data/data_sources/remote_data_sources/playlist_details_remote_data.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class PlaylistDetailsRepository extends GetxController{
  static PlaylistDetailsRepository get instance => Get.find();
  final PlaylistDetailsRemoteData _playlistDetailsRemoteData = Get.put(PlaylistDetailsRemoteData());

  Future<List<SongModel>> fetchPlaylistSongs({required String playlistId}) async {
    try{
      return await _playlistDetailsRemoteData.fetchPlaylistSongs(playlistId: playlistId);
    }
    catch (e)
    {
      throw e.toString();
    }
  }
}