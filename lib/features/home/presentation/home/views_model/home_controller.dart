import 'package:get/get.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/home/data/models/new_album_model.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/data/repository/home_repository.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final _homeRepo = Get.put(HomeRepository());
  final RxBool isLoading = false.obs;
  final RxBool isRecentlyPlayedPlaylistsLoading = false.obs;
  final RxBool isYourCreatedPlaylistsLoading = false.obs;
  final RxBool isNewAlbumsLoading = false.obs;
  RxList<SongsCollectionModel> songsPlaylists = <SongsCollectionModel>[].obs;
  final Rx<SongsCollectionModel> discoveryPlaylist = SongsCollectionModel
      .empty()
      .obs;
  final Rx<SongsCollectionModel> releaseRadarPlaylist = SongsCollectionModel
      .empty()
      .obs;
  RxList<SongsCollectionModel> recentlyPlayedPlaylists = <SongsCollectionModel>[].obs;
  RxList<SongsCollectionModel> yourCreatedPlaylists = <SongsCollectionModel>[].obs;
  RxList<NewAlbumModel> newAlbums = <NewAlbumModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchAllNewAlbums();
    getRecentlyPlayedPlaylists();
    getYourCreatedPlaylists();
    getAllPlaylists();
  }

  Future<void> getAllPlaylists() async {
    try {
      isLoading.value = true;
      songsPlaylists.value = await _homeRepo.fetchAllPlaylists();
      isLoading.value = false;
      discoveryPlaylist.value =
          songsPlaylists.firstWhere((playlist) => playlist.id == "001",
              orElse: SongsCollectionModel.empty);
      releaseRadarPlaylist.value =
          songsPlaylists.firstWhere((playlist) => playlist.id == "002",
              orElse: SongsCollectionModel.empty);
      songsPlaylists.remove(
          songsPlaylists.firstWhere((playlist) => playlist.id == "001"));
      songsPlaylists.remove(
          songsPlaylists.firstWhere((playlist) => playlist.id == "002"));
    }
    catch (e) {
      Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  Future<void> getRecentlyPlayedPlaylists() async {
    try {
      isRecentlyPlayedPlaylistsLoading.value = true;
       final playlists= await _homeRepo.fetchRecentlyPlayedPlaylists();
       final reversedPlaylist = playlists.reversed;
       recentlyPlayedPlaylists.assignAll(reversedPlaylist);
      isRecentlyPlayedPlaylistsLoading.value = false;
    }
    catch (e) {
      Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  Future<void> getYourCreatedPlaylists() async {
    try {
      isYourCreatedPlaylistsLoading.value = true;
      final playlists = await _homeRepo.fetchYourCreatedPlaylists();
      final reversedPlaylist = playlists.reversed;
      yourCreatedPlaylists.assignAll(reversedPlaylist);
      isYourCreatedPlaylistsLoading.value = false;
    }
    catch (e) {
      Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  Future<void> addToRecentlyPlayedPlaylists({required SongsCollectionModel playlist}) async {
    try {
      await _homeRepo.addToRecentlyPlayedPlaylists(playlist: playlist);
      recentlyPlayedPlaylists.insert(0,playlist);
    }
    catch (e) {
      Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  Future<void> fetchAllNewAlbums() async{
    try{
      isNewAlbumsLoading.value = true;
      final allNewAlbums = await _homeRepo.fetchAllNewAlbums();
      newAlbums.assignAll(allNewAlbums);
      isNewAlbumsLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}