
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/playlist_details/data/repository/playlist_details_repository.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class PlaylistDetailsController extends GetxController {
  static PlaylistDetailsController get instance => Get.find();
  final PlaylistDetailsRepository _playlistDetailsRepository = Get.put(PlaylistDetailsRepository());
  final homeController = HomeController.instance;
  SongsCollectionModel playlist = Get.arguments["playlist"];
  RxBool isSongsLoading = false.obs;
  RxBool isPlaying = false.obs;
  RxBool isDeletingPlaylist = false.obs;
  RxBool isDeletingSongLoading = false.obs;
  RxList<SongModel> playlistSongs = <SongModel>[].obs;
  String deletedSongName = "";


  @override
  void onInit() {
    super.onInit();
    addToRecentlyPlayedPlaylists(playlist: playlist);
    UpdateRecentlyPlayedTime(playlist: playlist);
    fetchPlaylistSongs(listOfSongs: playlist.listOfSongsIds);
  }

  void movingPlaylistToTop() {
    if (homeController.recentlyPlayedPlaylists.any((playlistItem) => playlistItem.collectionTitle == playlist.collectionTitle && playlistItem.collectionImg == playlist.collectionImg)) {
      homeController.recentlyPlayedPlaylists.removeWhere((playlistItem) => playlistItem.collectionTitle == playlist.collectionTitle && playlistItem.collectionImg == playlist.collectionImg);
      homeController.recentlyPlayedPlaylists.insert(0, playlist);
    }
  }

  Future<void> addToRecentlyPlayedPlaylists({required SongsCollectionModel playlist}) async{
    if(homeController.recentlyPlayedPlaylists.any((playlistItem)=> (playlistItem.id == playlist.id) && (playlistItem.collectionTitle == playlist.collectionTitle))){
      return;
    }
    else{
      if(playlist.id!="001" && playlist.id!="002") await homeController.addToRecentlyPlayedPlaylists(playlist: playlist);
    }
  }

  Future<void> fetchPlaylistSongs({required List<String>? listOfSongs}) async {
    try{
      isSongsLoading.value = true;
      final allSongs = await _playlistDetailsRepository.fetchPlaylistSongs(listOfSongs: listOfSongs);
      if(allSongs.isNotEmpty){
        playlistSongs.assignAll(allSongs);
      }
      isSongsLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> UpdateRecentlyPlayedTime({required SongsCollectionModel playlist}) async {
    try{
      await _playlistDetailsRepository.UpdateRecentlyPlayedTime(playlist: playlist);
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> deleteCreatedPlaylist({required SongsCollectionModel playlist}) async {
    try{
      isDeletingPlaylist.value = true;
      await _playlistDetailsRepository.deleteCreatedPlaylist(playlist: playlist);
      homeController.yourCreatedPlaylists.removeWhere((list) => list.collectionTitle == playlist.collectionTitle && list.collectionImg == playlist.collectionImg);
      homeController.recentlyPlayedPlaylists.removeWhere((list) => list.collectionTitle == playlist.collectionTitle && list.collectionImg == playlist.collectionImg);
      isDeletingPlaylist.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> deleteSongFromCreatedPlaylist({required SongModel song}) async {
    try{
      deletedSongName = song.songTitle;
      final listOfSongsIds = playlistSongs.map((song) => song.songId).toList();
      listOfSongsIds.removeWhere((songItem) => songItem == song.songId);
      isDeletingSongLoading.value = true;
      await _playlistDetailsRepository.deleteSongFromCreatedPlaylist(playlist: playlist,listOfSongs: listOfSongsIds);
      playlistSongs.removeWhere((songItem) => songItem.songId == song.songId);
      homeController.yourCreatedPlaylists.firstWhere((playlistItem) => playlistItem.collectionTitle == playlist.collectionTitle && playlistItem.collectionImg == playlist.collectionImg).listOfSongsIds = listOfSongsIds;
      homeController.recentlyPlayedPlaylists.firstWhere((playlistItem) => playlistItem.collectionTitle == playlist.collectionTitle && playlistItem.collectionImg == playlist.collectionImg).listOfSongsIds = listOfSongsIds;
      isDeletingSongLoading.value = false;
      deletedSongName = "";
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  bool checkPlaylistCreator() {
    return ("${playlist.collectionTitle}_${playlist.id}" == "${playlist.collectionTitle}_${FirebaseAuth.instance.currentUser?.uid}");
  }

  @override
  void onClose() {
    movingPlaylistToTop();
    super.onClose();
  }
}