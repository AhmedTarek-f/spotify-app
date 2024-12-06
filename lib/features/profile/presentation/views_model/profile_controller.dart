
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotify/core/common_widgets/rounded_container_image.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/data/models/following_followers_model.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/profile/data/repository/profile_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final ProfileRepository _profileRepository = Get.put(ProfileRepository());
  final homeController = HomeController.instance;
  final RxBool isPickingImageLoading = false.obs;
  final RxBool isUploadingImage = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isFollowingFollowersLoading = false.obs;
  Rx<UserModel> userData = UserModel.empty().obs;
  RxList<SongModel> publicSongsList = <SongModel>[].obs;
  final RxBool isPublicSongsLoading = false.obs;
  final ImagePicker picker = getIt.get<ImagePicker>();
  Rx<FollowingFollowersModel> followingFollowersData  = FollowingFollowersModel.empty().obs;


  @override
  void onInit() {
    super.onInit();
    getUserData();
    fetchAllPublicSongs();
  }

  Future<void> getUserData() async{
    try{
      isLoading.value = true;
      userData.value = await _profileRepository.fetchUserDetails();
      isLoading.value=false;
    }
    catch(e) {
      isLoading.value=false;
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> getFollowingFollowersData() async{
    try{
      isFollowingFollowersLoading.value = true;
      followingFollowersData.value = await _profileRepository.getFollowingFollowersData();
      userData.value.following = followingFollowersData.value.following;
      userData.value.followers = followingFollowersData.value.followers;
      isFollowingFollowersLoading.value=false;
    }
    catch(e) {
      isFollowingFollowersLoading.value=false;
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> openImagePicker(BuildContext context) async {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    await Get.bottomSheet(
      AbsorbPointer(
        absorbing: isUploadingImage.value,
        child: Container(
          height: 150,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: isDarkMode ? SpotifyColors.darkerGrey : Colors.white,
            borderRadius: const BorderRadius.only(topLeft:Radius.circular(18) ,topRight: Radius.circular(18)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedContainerImage(
                    image: SpotifyImages.galleryIcon,
                    onTap: ()async{
                      isPickingImageLoading.value = true;
                      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                      isPickingImageLoading.value = false;
                      Get.back();
                      if (pickedFile != null) {
                        isUploadingImage.value = true;
                       final String newImageUrl = await _profileRepository.uploadProfileImage(image: pickedFile);
                       await _profileRepository.updateProfilePicture(newProfilePic: newImageUrl);
                        isUploadingImage.value = false;
                       userData.value.profileImg = newImageUrl;
                       Loaders.successSnackBar(title: "Profile", message: "Your profile picture has been updated successfully.");
                      }
                    },
                  ),
                  RoundedContainerImage(
                    image: SpotifyImages.cameraIcon,
                    onTap: () async{
                      isPickingImageLoading.value = true;
                      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
                      isPickingImageLoading.value = false;
                      Get.back();
                      if (pickedFile != null) {
                        isUploadingImage.value=true;
                        final String newImageUrl = await _profileRepository.uploadProfileImage(image: pickedFile);
                        await _profileRepository.updateProfilePicture(newProfilePic: newImageUrl);
                        isUploadingImage.value=false;
                        userData.value.profileImg = newImageUrl;
                        Loaders.successSnackBar(title: "Profile", message: "Your profile picture has been updated successfully.");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: isDarkMode? Colors.grey[800]!: Colors.black,
      isDismissible: !isUploadingImage.value,
    );
  }

  Future<void> fetchAllPublicSongs() async {
    try{
      isPublicSongsLoading.value = true;
      final allPublicSongs = await _profileRepository.fetchAllPublicSongs();
      if(allPublicSongs.isNotEmpty){
        publicSongsList.assignAll(allPublicSongs);
      }
      isPublicSongsLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> fetchFollowingList() async {
    await homeController.fetchFollowingList();
  }
  Future<void> fetchFollowersList() async {
    await homeController.fetchFollowersList();
  }

  Future<void> deleteFromYourPublicFavoriteSongs({required String songId}) async {
    try{
      await _profileRepository.deleteFromYourPublicFavoriteSongs(songId: songId);
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

}