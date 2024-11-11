import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_colors.dart';

class NavigationUpperPart extends StatelessWidget {
  const NavigationUpperPart({
    super.key, this.width = 23, this.height=4,
  });
  final double? width,height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: SpotifyColors.primaryColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12)
        ),
      ),

    );
  }
}