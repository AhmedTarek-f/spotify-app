import 'package:flutter/material.dart';
import 'package:spotify/features/discovery/presentation/discovery/views/widgets/following_user_details.dart';
import 'package:spotify/features/discovery/presentation/discovery/views_model/discovery_controller.dart';

class FollowingUsersList extends StatelessWidget {
  const FollowingUsersList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DiscoveryController.instance;
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => FollowingUserDetails(userData: controller.listOfUserPublicPlaylists.elementAt(index),),
        separatorBuilder: (_, __) => const SizedBox(height: 16,),
        itemCount: controller.listOfUserPublicPlaylists.length
    );
  }
}
