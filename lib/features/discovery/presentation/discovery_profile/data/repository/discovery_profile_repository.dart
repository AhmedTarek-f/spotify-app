import 'package:get/get.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/data/data_sources/remote_data/discovery_profile_remote_data.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/data/models/following_followers_model.dart';

class DiscoveryProfileRepository extends GetxController {
  static DiscoveryProfileRepository get instance => Get.find();
  final _discoveryProfileRemoteData = Get.put(DiscoveryProfileRemoteData());

  Future<FollowingFollowersModel> getFollowingFollowersData({required String userId}) async{
    try{
      return await _discoveryProfileRemoteData.getFollowingFollowersData(userId: userId);
    }

    catch (e)
    {
      throw e.toString();
    }
  }
}