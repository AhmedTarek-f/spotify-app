import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_colors.dart';

class NavigationUpperPart extends StatelessWidget {
  const NavigationUpperPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23,
      height: 4,
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