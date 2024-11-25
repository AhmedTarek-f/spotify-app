import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/home/data/repository/home_repository.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class HomeSearchController extends GetxController
{
  static HomeSearchController get instance => Get.find();

  late final TextEditingController searchField;
  final _homeRepo = HomeRepository.instance;
  final RxBool isSongsLoading = false.obs;
  RxList<SongModel> allSongsList = <SongModel>[].obs;
  RxList<SongModel> songsSearchList = <SongModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchField = TextEditingController();
    fetchSongs();
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

  void searchForASong({required String songName}){
    searchField.text = songName;
    if(allSongsList.isNotEmpty){
      for(int i=0 ; i<allSongsList.length;i++){
        if(allSongsList[i].songTitle.toLowerCase().contains(searchField.text.toLowerCase())){
          songsSearchList.add(allSongsList[i]);
        }
      }
    }
  }

  @override
  void onClose() {
    searchField.dispose();
    super.onClose();
  }
}