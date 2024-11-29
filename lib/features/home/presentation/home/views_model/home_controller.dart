import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotify/core/common_widgets/rounded_container_image.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/home/data/models/new_album_model.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/data/repository/home_repository.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final _homeRepo = Get.put(HomeRepository());
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository.instance;
  late final RxBool isDarkMode;
  final _deviceStorage = getIt.get<GetStorage>();
  final RxBool isLoading = false.obs;
  final RxBool isRecentlyPlayedPlaylistsLoading = false.obs;
  final RxBool isYourCreatedPlaylistsLoading = false.obs;
  final RxBool isNewAlbumsLoading = false.obs;
  final RxBool isPickingImageLoading = false.obs;
  final RxBool isCreatingPlaylist = false.obs;
  final RxBool isFollowingListLoading = true.obs;
  final RxBool isFollowersListLoading = true.obs;
  RxList<SongsCollectionModel> songsPlaylists = <SongsCollectionModel>[].obs;
  final Rx<SongsCollectionModel> discoveryPlaylist = SongsCollectionModel.empty().obs;
  final Rx<SongsCollectionModel> releaseRadarPlaylist = SongsCollectionModel.empty().obs;
  RxList<SongsCollectionModel> recentlyPlayedPlaylists = <SongsCollectionModel>[].obs;
  RxList<SongsCollectionModel> yourCreatedPlaylists = <SongsCollectionModel>[].obs;
  RxList<UserModel> followingList = <UserModel>[].obs;
  RxList<UserModel> followersList = <UserModel>[].obs;
  RxList<NewAlbumModel> newAlbums = <NewAlbumModel>[].obs;
  late final TextEditingController playlistTitleField;
  final ImagePicker picker = getIt.get<ImagePicker>();
  Rx<XFile?>  pickedFile = XFile("").obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllNewAlbums();
    getRecentlyPlayedPlaylists();
    getYourCreatedPlaylists();
    getAllPlaylists();
    final bool isDarkOrLight = _deviceStorage.read("isDarkTheme")!=null?_deviceStorage.read("isDarkTheme"):false;
    isDarkMode = isDarkOrLight.obs;
    playlistTitleField = TextEditingController();
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
  Future<void> toggleThemeMode()async{
    await changeThemeMode();
  }

  Future<void> openImagePicker(BuildContext context) async {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    await Get.bottomSheet(
      Container(
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
                    pickedFile.value = await picker.pickImage(source: ImageSource.gallery);
                    isPickingImageLoading.value = false;
                    Get.back();
                  },
                ),
                RoundedContainerImage(
                  image: SpotifyImages.cameraIcon,
                  onTap: () async{
                    isPickingImageLoading.value = true;
                    pickedFile.value = await picker.pickImage(source: ImageSource.camera);
                    isPickingImageLoading.value = false;
                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: isDarkMode? Colors.grey[800]!: Colors.black,
    );
  }

  Future<void> createPlaylists() async{
    try{
      final playlistId = "${FirebaseAuth.instance.currentUser?.uid}";
      if(playlistTitleField.text.isEmpty || playlistTitleField.text.trim() == ""){
        Loaders.warningSnackBar(title: "Note!",message: "Playlist title is required, it can't be empty.");
        return;
      }
      else if(yourCreatedPlaylists.any((list) => list.collectionTitle == playlistTitleField.text)){
        Loaders.warningSnackBar(title: "Note!",message: "You have a playlist with the same title, change the playlist title to continue.");
        return;
      }
      else if(pickedFile.value == null || pickedFile.value?.path == ""  || pickedFile.value?.path.trim() == ""){
        Loaders.warningSnackBar(title: "Note!",message: "Playlist image is required, it can't be empty.");
        return;
      }
      else{
        Get.back();
        isCreatingPlaylist.value=true;
        final String collectionImgUrl = await _homeRepo.uploadPlaylistImage(image: pickedFile.value!);
        final playlist = SongsCollectionModel(
            id: playlistId,
            collectionImg: collectionImgUrl,
            collectionTitle: playlistTitleField.text,
          createdBy: FirebaseAuth.instance.currentUser?.displayName ?? "",
        );
        await _homeRepo.createPlaylists(playlist: playlist);
        yourCreatedPlaylists.add(playlist);
        playlistTitleField.clear();
        pickedFile.value = XFile("");
        isCreatingPlaylist.value = false;
        Loaders.successSnackBar(title: "Note", message: "Your playlist has been created successfully.");
      }

    }
    catch (e) {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> fetchFollowingList() async{
    try{
      isFollowingListLoading.value = true;
      final allFollowing = await _homeRepo.fetchFollowingList();
      followingList.assignAll(allFollowing);
      isFollowingListLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  Future<void> fetchFollowersList() async{
    try{
      isFollowersListLoading.value = true;
      final allFollowers = await _homeRepo.fetchFollowersList();
      followersList.assignAll(allFollowers);
      isFollowersListLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  Future<void> changeThemeMode() async{
    if(Get.isDarkMode && isDarkMode.value)
    {
      await _deviceStorage.write("isDarkTheme", false);
      isDarkMode.value = false;
      ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
    }
    else {
      await _deviceStorage.write("isDarkTheme", true);
      isDarkMode.value = true;
      ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
    }
  }

  Future<void> logout() async {
    try{
      await _authenticationRepository.logout();
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }



  @override
  void onClose() {
    playlistTitleField.dispose();
    super.onClose();
  }
}