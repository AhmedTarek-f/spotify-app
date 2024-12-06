import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class PlaylistsSearchController extends GetxController
{
  static PlaylistsSearchController get instance => Get.find();

  late final TextEditingController playlistsSearchField;
  final _homeController = HomeController.instance;
  RxList<SongsCollectionModel> allPlaylists = <SongsCollectionModel>[].obs;
  RxList<SongsCollectionModel> playlistsSearchList = <SongsCollectionModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    playlistsSearchField = TextEditingController();
    assignAllPlaylists();
  }


  void assignAllPlaylists(){
    allPlaylists.assignAll(_homeController.songsPlaylists);
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




  @override
  void onClose() {
    playlistsSearchField.dispose();
    super.onClose();
  }
}