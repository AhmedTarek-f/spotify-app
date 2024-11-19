import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';

class NewAlbumShimmer extends StatelessWidget {
  const NewAlbumShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.05688,top: 14),
      width: MediaQuery.sizeOf(context).width*0.8564,
      height: MediaQuery.sizeOf(context).height*0.1398,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: SpotifyColors.primaryColor,
      ),
      child: Stack(
          clipBehavior: Clip.none,
          children:[
            Positioned(
              bottom: 0,
              right: MediaQuery.sizeOf(context).width*0.12731,
              child: ShimmerEffect(width: MediaQuery.sizeOf(context).width*0.2546, height: MediaQuery.sizeOf(context).height*0.1634,radius: 60,),
            ),
            Positioned(
              top: 0,
              right: 0,
              child:  Image.asset(SpotifyImages.homeAlbumSlashes),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width*0.4038,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerEffect(width: 70, height: 12),
                  SizedBox(height: 12,),
                  ShimmerEffect(width: 120, height: 22),
                  SizedBox(height: 12,),
                  ShimmerEffect(width: 80, height: 16),
                ],
              ),
            ),
          ]
      ),
    );
  }
}