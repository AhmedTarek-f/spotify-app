import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key, this.googleOnPressed});
  final Function()? googleOnPressed;
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
      ],
    );
  }
}