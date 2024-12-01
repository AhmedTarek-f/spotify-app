import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class FollowsAndFollowersRow extends StatelessWidget {
  const FollowsAndFollowersRow({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = ProfileController.instance;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
            ()=> Column(
            children: [
              profileController.isLoading.value?
              const ShimmerEffect(width: 20, height: 12):Text((profileController.userData.value.following??0).toString(),style: SpotifyFonts.appStylesBold20),
              const Text("Following",style: SpotifyFonts.appStylesRegular14)
            ],
          ),
        ),
        SizedBox(width: MediaQuery.sizeOf(context).width*0.3153,),
        Obx(
            ()=> Column(
            children: [
              profileController.isLoading.value?
              const ShimmerEffect(width: 20, height: 12):Text((profileController.userData.value.followers??0).toString(),style: SpotifyFonts.appStylesBold20),
              const Text("Followers",style: SpotifyFonts.appStylesRegular14)
            ],
          ),
        )
      ],
    );
  }
}
