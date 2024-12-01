import 'package:get/get.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/data/data_sources/remote_data_sources/discovery_remote_data.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class DiscoveryRepository extends GetxController {
  static DiscoveryRepository get instance => Get.find();
  final _discoveryRemoteData = Get.put(DiscoveryRemoteData());

  Future<List<UserModel>> fetchAllRegisteredUsers() async{
    try{
      return await _discoveryRemoteData.fetchAllRegisteredUsers();
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<List<SongModel>> fetchUserPublicSongs({required String userId}) async{
    try{
      return await _discoveryRemoteData.fetchUserPublicSongs(userId: userId);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> followUser({required String userId}) async {
    try{
       await _discoveryRemoteData.followUser(userId: userId);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> unfollowUser({required String userId}) async {
    try{
       await _discoveryRemoteData.unfollowUser(userId: userId);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<List<String>> followingIds() async {
    try{
      return await _discoveryRemoteData.followingIds();
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<List<SongsCollectionModel>> fetchPublicPlaylistsForUser({required String userId}) async{
    try{
      return await _discoveryRemoteData.fetchPublicPlaylistsForUser(userId: userId);
    }
    catch (e)
    {
      throw e.toString();
    }
  }


}