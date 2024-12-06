import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/data/repository/home_repository.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class SongsSearchController extends GetxController
{
  static SongsSearchController get instance => Get.find();

  late final TextEditingController songsSearchField;
  late final TextEditingController playlistsSearchField;
  final _homeRepo = HomeRepository.instance;
  final _homeController = HomeController.instance;
  final RxBool isSongsLoading = false.obs;
  final RxBool isAddingSongLoading = false.obs;
  RxList<SongModel> allSongsList = <SongModel>[].obs;
  RxList<SongModel> songsSearchList = <SongModel>[].obs;
  RxList<SongsCollectionModel> allPlaylists = <SongsCollectionModel>[].obs;
  RxList<SongsCollectionModel> playlistsSearchList = <SongsCollectionModel>[].obs;
  final RxInt activeSelectedSong = 0.obs;


  @override
  void onInit() {
    super.onInit();
    songsSearchField = TextEditingController();
    playlistsSearchField = TextEditingController();
    fetchSongs();
    assignAllPlaylists();
  }

  Future<void> fetchSongs() async {
    try{
      isSongsLoading.value = true;
      final allSongs = await _homeRepo.fetchSongs();
      allSongsList.assignAll(allSongs);
      isSongsLoading.value = false;
    }
    catch (e) {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  void assignAllPlaylists(){
    allPlaylists.assignAll(_homeController.songsPlaylists);
  }

  void searchForASong({required String songName}){
    songsSearchField.text = songName;
    if(allSongsList.isNotEmpty){
      for(int i=0 ; i<allSongsList.length;i++){
        if(allSongsList[i].songTitle.toLowerCase().contains(songsSearchField.text.toLowerCase())){
          songsSearchList.add(allSongsList[i]);
        }
      }
    }
  }

  void searchForAPlaylist({required String playlistName}){
    playlistsSearchField.text = playlistName;
    if(allPlaylists.isNotEmpty){
      for(int i=0 ; i<allPlaylists.length;i++){
        if(allPlaylists[i].collectionTitle.toLowerCase().contains(playlistsSearchField.text.toLowerCase())){
          playlistsSearchList.add(allPlaylists[i]);
        }
      }
    }
  }

  Future<void> addSongToCreatedPlaylists({required SongModel song,}) async{
    try{
      final SongsCollectionModel targetedPlaylist = allCreatedPlaylists().elementAt(activeSelectedSong.value);
      if((targetedPlaylist.listOfSongsIds?.any((songIds) => songIds==song.songId))?? false){
        Loaders.warningSnackBar(title: "Note!", message: "You have already added ${song.songTitle} before to ${targetedPlaylist.collectionTitle} playlist.");
        return;
      }
      else{
        if(Get.isRegistered<PlaylistDetailsController>()){
         if(PlaylistDetailsController.instance.playlist.collectionTitle == targetedPlaylist.collectionTitle && PlaylistDetailsController.instance.playlist.collectionImg == targetedPlaylist.collectionImg)  PlaylistDetailsController.instance.playlistSongs.add(song);
        }
        final String playlistId = "${targetedPlaylist.collectionTitle}_${targetedPlaylist.id}";
        if(_homeController.yourCreatedPlaylists.firstWhere((playlist) => (playlist.collectionTitle == targetedPlaylist.collectionTitle) && (playlist.collectionImg == targetedPlaylist.collectionImg)).listOfSongsIds == null) _homeController.yourCreatedPlaylists.firstWhere((playlist) => (playlist.collectionTitle == targetedPlaylist.collectionTitle) && (playlist.collectionImg == targetedPlaylist.collectionImg)).listOfSongsIds = [];
        _homeController.yourCreatedPlaylists.firstWhere((playlist) => (playlist.collectionTitle == targetedPlaylist.collectionTitle) && (playlist.collectionImg == targetedPlaylist.collectionImg)).listOfSongsIds?.add(song.songId);
        final listOfSongs = _homeController.yourCreatedPlaylists.firstWhere((playlist) => (playlist.collectionTitle == targetedPlaylist.collectionTitle) && (playlist.collectionImg == targetedPlaylist.collectionImg)).listOfSongsIds!;
        isAddingSongLoading.value = true;
        if(_homeController.recentlyPlayedPlaylists.any((playlist) => (playlist.collectionTitle == targetedPlaylist.collectionTitle) && (playlist.collectionImg == targetedPlaylist.collectionImg))){
          _homeController.recentlyPlayedPlaylists.firstWhere((playlist) => (playlist.collectionTitle == targetedPlaylist.collectionTitle) && (playlist.collectionImg == targetedPlaylist.collectionImg)).listOfSongsIds = [];
          _homeController.recentlyPlayedPlaylists.firstWhere((playlist) => (playlist.collectionTitle == targetedPlaylist.collectionTitle) && (playlist.collectionImg == targetedPlaylist.collectionImg)).listOfSongsIds?.assignAll(_homeController.yourCreatedPlaylists.firstWhere((playlist) => (playlist.collectionTitle == targetedPlaylist.collectionTitle) && (playlist.collectionImg == targetedPlaylist.collectionImg)).listOfSongsIds!);
          await _homeRepo.addSongToRecentlyAndCreatedPlaylists(listOfSongs: listOfSongs, playlistId: playlistId);
        }
        else{
          await _homeRepo.addSongToCreatedPlaylists(listOfSongs:listOfSongs,playlistId: playlistId);
        }
        isAddingSongLoading.value = false;
        Get.back();
        Loaders.successSnackBar(title: "Note!", message: "${song.songTitle} has been add successfully to ${targetedPlaylist.collectionTitle} playlist.");
      }
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  List<SongsCollectionModel> allCreatedPlaylists(){
    return _homeController.yourCreatedPlaylists;
  }


  @override
  void onClose() {
    songsSearchField.dispose();
    playlistsSearchField.dispose();
    super.onClose();
  }
}