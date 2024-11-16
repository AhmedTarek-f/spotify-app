import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/views_model/home_controller.dart';
import 'package:spotify/features/playlist_details/data/repository/playlist_details_repository.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class PlaylistDetailsController extends GetxController {
  static PlaylistDetailsController get instance => Get.find();
  final PlaylistDetailsRepository _playlistDetailsRepository = Get.put(PlaylistDetailsRepository());
  final homeController = HomeController.instance;
  SongsCollectionModel playlist = Get.arguments["playlist"];
  RxBool isSongsLoading = false.obs;
  RxList<SongModel> playlistSongs = <SongModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    if(playlist.id!="001" && playlist.id!="002" && (!homeController.recentlyPlayedPlaylists.any((item)=>item.id == playlist.id))) homeController.addToRecentlyPlayedPlaylists(playlist: playlist);
    fetchPlaylistSongs(playlistId: playlist.id);
  }

  Future<void> fetchPlaylistSongs({required String playlistId}) async {
    try{
      isSongsLoading.value = true;
      final allSongs = await _playlistDetailsRepository.fetchPlaylistSongs(playlistId: playlistId);
      playlistSongs.assignAll(allSongs);
      isSongsLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  }