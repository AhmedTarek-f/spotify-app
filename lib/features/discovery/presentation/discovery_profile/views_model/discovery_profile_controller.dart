import 'package:get/get.dart';
import 'package:spotify/features/discovery/data/repository/discovery_repository.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class DiscoveryProfileController extends GetxController {
  static DiscoveryProfileController get instance => Get.find();
  final _discoveryRepository = DiscoveryRepository.instance;
  final RxBool isUserPublicSongsLoading = false.obs;
  RxList<SongModel> publicSongsList = <SongModel>[].obs;
  final String userId = Get.arguments["userId"];

  @override
  void onInit() {
    super.onInit();
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
}