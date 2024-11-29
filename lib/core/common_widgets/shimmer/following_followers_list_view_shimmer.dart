import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/shimmer/following_followers_item_shimmer.dart';

class FollowingFollowersListViewShimmer extends StatelessWidget {
  const FollowingFollowersListViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.sizeOf(context).width*0.7,
      height: MediaQuery.sizeOf(context).height*0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) => const FollowingFollowersItemShimmer(),
            separatorBuilder: (_, __) => const SizedBox(height: 12,),
            itemCount: 8
        ),
      ),
    );
  }
}
