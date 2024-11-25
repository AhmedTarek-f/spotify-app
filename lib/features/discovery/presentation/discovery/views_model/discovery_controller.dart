import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/data/repository/discovery_repository.dart';

class DiscoveryController extends GetxController {
  static DiscoveryController get instance => Get.find();
  final RxBool isFollowingLoading = false.obs;
  final RxBool isUnfollowingLoading = false.obs;
  final _discoveryRepository = Get.put(DiscoveryRepository());
  late final TextEditingController searchField;
  RxList<UserModel> registeredUsers = <UserModel>[].obs;
  RxList<UserModel> usersSearchList = <UserModel>[].obs;
  RxList<String> allFollowingList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchField = TextEditingController();
    followingIds();
    fetchAllRegisteredUsers();
  }

  Future<void> fetchAllRegisteredUsers() async{
    try{
      final allRegisteredUsers = await _discoveryRepository.fetchAllRegisteredUsers();
      registeredUsers.assignAll(allRegisteredUsers);
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> followUser({required String userId}) async {
    try{
      isFollowingLoading.value = true;
      usersSearchList.firstWhere((user) => user.id == userId).followers = await _discoveryRepository.followUser(userId: userId);
      allFollowingList.add(userId);
      isFollowingLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> unfollowUser({required String userId}) async {
    try{
      isUnfollowingLoading.value = true;
      usersSearchList.firstWhere((user) => user.id == userId).followers = await _discoveryRepository.unfollowUser(userId: userId);
      allFollowingList.removeWhere((id)=> id == userId);
      isUnfollowingLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> followingIds() async {
    try{
      final allFollowingIds = await _discoveryRepository.followingIds();
      allFollowingList.assignAll(allFollowingIds);
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  void searchForAUser({required String userName}){
    searchField.text = userName;
    if(registeredUsers.isNotEmpty){
      for(int i=0 ; i<registeredUsers.length;i++){
        if(registeredUsers[i].userName.toLowerCase().contains(userName.toLowerCase())){
          usersSearchList.add(registeredUsers[i]);
        }
      }
    }
  }

  bool checkFollowingOrNot({required String userId}) {
    return allFollowingList.contains(userId);
  }

  @override
  void onClose() {
    searchField.dispose();
    super.onClose();
  }
}