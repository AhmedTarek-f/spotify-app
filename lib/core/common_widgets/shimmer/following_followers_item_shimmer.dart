import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';

class FollowingFollowersItemShimmer extends StatelessWidget {
  const FollowingFollowersItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ShimmerEffect(width: 50.5, height: 50.5,radius: 50.5,),
        SizedBox(width: 8,),
        ShimmerEffect(width: 120, height: 12,),
      ],
    );;
  }
}
