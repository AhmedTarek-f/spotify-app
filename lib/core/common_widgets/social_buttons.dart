import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key, this.googleOnPressed, this.appleOnPressed});
  final Function()? googleOnPressed;
  final Function()? appleOnPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: googleOnPressed,
          splashColor: SpotifyColors.primaryColor.withOpacity(0.4),
          highlightColor: SpotifyColors.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          child: SvgPicture.asset(SpotifyImages.googleIcon),
        ),
        const SizedBox(width: 58.28,),
        InkWell(
          onTap: appleOnPressed,
          splashColor: SpotifyColors.primaryColor.withOpacity(0.4),
          highlightColor: SpotifyColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(100),
          child: SvgPicture.asset(SpotifyImages.appleIcon),
        ),
      ],
    );
  }
}