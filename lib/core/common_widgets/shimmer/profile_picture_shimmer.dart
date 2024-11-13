import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';

class ProfilePictureShimmer extends StatelessWidget {
  const ProfilePictureShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 46.5,
      child: ClipOval(
        child: ShimmerEffect(width: 92, height: 92,radius: 92,),
      ),
    );
  }
}