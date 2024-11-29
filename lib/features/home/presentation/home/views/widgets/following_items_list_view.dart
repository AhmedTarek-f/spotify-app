import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/following_followers_list_view_shimmer.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/following_followers_item.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class FollowingItemsListView extends StatelessWidget {
  const FollowingItemsListView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return  Obx(
          ()=> controller.isFollowingListLoading.value?
      const FollowingFollowersListViewShimmer() : (
          controller.followingList.isEmpty?
          const Text("Your following list is still empty.",style: SpotifyFonts.appStylesMedium17,):
          SizedBox(
            width: MediaQuery.sizeOf(context).width*0.7,
            height: MediaQuery.sizeOf(context).height*0.2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:16.0),
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) => FollowingFollowersItem(userData: controller.followingList.elementAt(index)),
                  separatorBuilder: (_, __) => const SizedBox(height: 12,),
                  itemCount: controller.followingList.length
              ),
            ),
          )
      ),
    );
  }
}
