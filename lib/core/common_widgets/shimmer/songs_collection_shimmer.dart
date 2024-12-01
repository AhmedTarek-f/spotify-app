import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';

class SongsCollectionShimmer extends StatelessWidget {
  const SongsCollectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: ShimmerEffect(
            width: MediaQuery.sizeOf(context).width*0.3989,
            height: MediaQuery.sizeOf(context).height*0.1899,
            radius: 30,
          ),
        ),
    
        const Padding(
          padding: EdgeInsets.only(left: 12,top: 4),
          child: ShimmerEffect(width: 120, height: 12),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12,top: 4),
          child: ShimmerEffect(width: 70, height: 12),
        ),
      ],
    );
  }
}