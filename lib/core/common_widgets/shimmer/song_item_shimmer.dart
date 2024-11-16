import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:spotify/core/constants/spotify_images.dart';

class SongItemShimmer extends StatelessWidget {
  const SongItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        ShimmerEffect(
          width: MediaQuery.sizeOf(context).width*0.1487,
          height: MediaQuery.sizeOf(context).height*0.06635,
          radius: 14,
        ),
        const SizedBox(width: 20,),
        const Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(width: 110, height: 12),
              SizedBox(height: 8,),
              ShimmerEffect(width: 70, height: 8),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              const Expanded(child: ShimmerEffect(width: 80, height: 12)),
              Expanded(child: SvgPicture.asset(SpotifyImages.threeDotsHorizontallyIcon)),
            ],
          ),
        )
      ],
    );
  }
}
