import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/data/model/user_details_with_created_playlists_model.dart';
import 'package:spotify/features/discovery/data/repository/discovery_repository.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class DiscoveryController extends GetxController {
  static DiscoveryController get instance => Get.find();
  final RxBool isFollowingLoading = false.obs;
  final RxBool isUnfollowingLoading = false.obs;
  final _discoveryRepository = Get.put(DiscoveryRepository());
  late final TextEditingController searchField;
  RxList<UserModel> registeredUsers = <UserModel>[].obs;
  RxList<UserModel> usersSearchList = <UserModel>[].obs;
  RxList<String> allFollowingList = <String>[].obs;
  final RxBool isListOfUserPublicPlaylistsLoading = false.obs;
  final RxBool isRegisteredUsersLoading = false.obs;
  RxList<UserDetailsWithCreatedPlaylistsModel> listOfUserPublicPlaylists = <UserDetailsWithCreatedPlaylistsModel>[].obs;
  String followingAndUnfollowingUserId = "";

  @override
  void onInit() async{
    super.onInit();
    searchField = TextEditingController();
    await followingIds();
    await fetchAllRegisteredUsers();
    addingFollowingUsers();
  }

  Future<void> fetchAllRegisteredUsers() async{
    try{
      isRegisteredUsersLoading.value = true;
      final allRegisteredUsers = await _discoveryRepository.fetchAllRegisteredUsers();
      registeredUsers.assignAll(allRegisteredUsers);
      isRegisteredUsersLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> followUser({required String userId}) async {
    try{
      followingAndUnfollowingUserId = userId;
      isFollowingLoading.value = true;
      await _discoveryRepository.followUser(userId: userId);
      allFollowingList.add(userId);
      await addingFollowingUsers();
      if(Get.isRegistered<ProfileController>()) ProfileController.instance.getFollowingFollowersData();
      isFollowingLoading.value = false;
      followingAndUnfollowingUserId = "";
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> unfollowUser({required String userId}) async {
    try{
      followingAndUnfollowingUserId = userId;
      isUnfollowingLoading.value = true;
      await _discoveryRepository.unfollowUser(userId: userId);
      allFollowingList.removeWhere((id)=> id == userId);
      listOfUserPublicPlaylists.removeWhere((user)=>user.id == userId);
      if(Get.isRegistered<ProfileController>()) ProfileController.instance.getFollowingFollowersData();
      isUnfollowingLoading.value = false;
      followingAndUnfollowingUserId= "";
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> addingFollowingUsers() async{
    listOfUserPublicPlaylists.clear();
    for(String userId in allFollowingList){
      for(UserModel user in registeredUsers){
        if(userId == user.id){
          listOfUserPublicPlaylists.add(UserDetailsWithCreatedPlaylistsModel(
            id: user.id,
            userName: user.userName,
            profileImg: user.profileImg,
            publicCreatedPlaylists: [],
          )
          );
        }
      }
    }
    for(String userId in allFollowingList){
     isListOfUserPublicPlaylistsLoading.value = true;
     await fetchPublicPlaylistsForAFollowingUser(userId: userId);
     isListOfUserPublicPlaylistsLoading.value = false;
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


  Future<void> fetchPublicPlaylistsForAFollowingUser({required String userId}) async{
    try{
      final PublicPlaylists = await _discoveryRepository.fetchPublicPlaylistsForUser(userId: userId);
      listOfUserPublicPlaylists.firstWhere((user) => user.id == userId)..publicCreatedPlaylists=PublicPlaylists;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
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