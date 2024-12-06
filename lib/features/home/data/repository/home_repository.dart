import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/home/data/data_sources/remote_data_sources/home_remote_data.dart';
import 'package:spotify/features/home/data/models/new_album_model.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class HomeRepository extends GetxController {
  static HomeRepository get instance => Get.find();
  final _homeRemoteData = Get.put(HomeRemoteData());
  final SupabaseClient supaBase = Supabase.instance.client;

  Future<UserModel> fetchUserDetails() async {
    try{
      return await _homeRemoteData.fetchUserDetails();
    }
    catch (e){
      throw e.toString();
    }
  }

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

  Future<void> createPlaylists({required SongsCollectionModel playlist}) async{
    try{
      await _homeRemoteData.createPlaylists(playlist: playlist);
    }
    catch (e) {
      throw e.toString();
    }
  }

  Future<String> uploadPlaylistImage({required XFile image}) async {
    try{
      final String uniqueId = const Uuid().v4(); // Generate a unique identifier
      final String path = "${uniqueId}_${basename(image.path)}";
      final File imageFile = File(image.path);
      await supaBase.storage.from("images/created_playlists").upload(path,imageFile);
      return await supaBase.storage.from("images/created_playlists").getPublicUrl(path);
    }
    catch(e){
      throw e.toString();
    }
  }

  Future<void> addSongToCreatedPlaylists({required List<String>? listOfSongs, required SongsCollectionModel playlist}) async{
    try{
      await _homeRemoteData.addSongToCreatedPlaylists(listOfSongs:listOfSongs,playlist: playlist);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> addSongToRecentlyAndCreatedPlaylists({required List<String>? listOfSongs, required SongsCollectionModel playlist}) async{
    try{
      await _homeRemoteData.addSongToRecentlyAndCreatedPlaylists(listOfSongs:listOfSongs,playlist: playlist);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<List<UserModel>> fetchFollowingList() async{
    try{
      return await _homeRemoteData.fetchFollowingList();
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<List<UserModel>> fetchFollowersList() async{
    try{
      return await _homeRemoteData.fetchFollowersList();
    }
    catch (e)
    {
      throw e.toString();
    }
  }

}