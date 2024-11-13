import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/splash/presentation/views_model/splash_controller.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Column(
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height*0.4,),
        Center(child: SvgPicture.asset(SpotifyImages.spotifyLogoSVG)),
      ],
    );
  }
}
