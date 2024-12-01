import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/animation_loader_widget.dart';
import 'package:spotify/features/discovery/presentation/discovery/views/widgets/discovery_search_field.dart';
import 'package:spotify/features/discovery/presentation/discovery/views/widgets/discovery_users_list.dart';
import 'package:spotify/features/discovery/presentation/discovery/views/widgets/following_users_list.dart';
import 'package:spotify/features/discovery/presentation/discovery/views_model/discovery_controller.dart';

class DiscoveryViewBody extends StatelessWidget {
  const DiscoveryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DiscoveryController.instance;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.04179),
      child: Column(
        children: [
          const SizedBox(height: 12,),
          const DiscoverySearchField(),
          const SizedBox(height: 12,),
          Obx(
            ()=> controller.usersSearchList.isEmpty?
            (controller.listOfUserPublicPlaylists.isEmpty?
            const Expanded(child: Center(child: AnimationLoaderWidget(text: "No Followers yet! follow some users so you can see their public playlists", animation: SpotifyImages.emptySearchAnimation))):
            const Expanded(child: FollowingUsersList())
            ):
            const Expanded(child: DiscoveryUsersList()),
          ),
        ],
      ),
    );
  }
}