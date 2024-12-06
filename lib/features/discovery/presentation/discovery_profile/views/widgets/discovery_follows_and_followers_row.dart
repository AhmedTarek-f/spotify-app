import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views_model/discovery_profile_controller.dart';

class DiscoveryFollowsAndFollowersRow extends StatelessWidget {
  const DiscoveryFollowsAndFollowersRow({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = DiscoveryProfileController.instance;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
       Column(
            children: [
              Obx(
                    ()=>controller.isLoading.value?
                const ShimmerEffect(width: 20, height: 12):
                Text(
                  (controller.followingFollowersData.value.following).toString(),
                  style: SpotifyFonts.appStylesBold20,
                ),
              ),
              const Text("Following",style: SpotifyFonts.appStylesRegular14)
            ],
          ),

        SizedBox(width: MediaQuery.sizeOf(context).width*0.3153,),
         Column(
            children: [
              Obx(
                    ()=>controller.isLoading.value?
                const ShimmerEffect(width: 20, height: 12):
                Text(
                  (controller.followingFollowersData.value.followers).toString(),
                  style: SpotifyFonts.appStylesBold20,
                ),
              ),
              const Text("Followers",style: SpotifyFonts.appStylesRegular14)
            ],
          ),

      ],
    );
  }
}
