import 'package:get/get.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/discovery/data/repository/discovery_repository.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/data/models/following_followers_model.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/data/repository/discovery_profile_repository.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class DiscoveryProfileController extends GetxController {
  static DiscoveryProfileController get instance => Get.find();
  final _discoveryRepository = Get.isRegistered<DiscoveryRepository>()? DiscoveryRepository.instance : Get.put(DiscoveryRepository());
  final RxBool isUserPublicSongsLoading = false.obs;
  final RxBool isLoading = false.obs;
  final _discoveryProfileRepo = Get.put(DiscoveryProfileRepository());
  final Rx<FollowingFollowersModel> followingFollowersData  = FollowingFollowersModel.empty().obs;
  RxList<SongModel> publicSongsList = <SongModel>[].obs;
  final String userId = Get.arguments["userId"];

  @override
  void onInit() {
    super.onInit();
    getFollowingFollowersData(userId: userId);
    fetchUserPublicSongs(userId: userId);
  }

  Future<void> fetchUserPublicSongs({required String userId}) async{
    try{
      isUserPublicSongsLoading.value = true;
      final publicSongs= await _discoveryRepository.fetchUserPublicSongs(userId: userId);
      publicSongsList.assignAll(publicSongs);
      isUserPublicSongsLoading.value = false;
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> getFollowingFollowersData({required String userId}) async{
    try{
      isLoading.value = true;
      followingFollowersData.value = await _discoveryProfileRepo.getFollowingFollowersData(userId: userId);
      isLoading.value=false;
    }
    catch(e) {
      isLoading.value=false;
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }
}