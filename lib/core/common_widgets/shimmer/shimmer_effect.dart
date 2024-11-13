import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify/core/constants/spotify_colors.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color
  });
  final double width,height,radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDarkMode?Colors.grey[850]!:Colors.grey[300]!,
      highlightColor: isDarkMode?Colors.grey[700]!:Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color ?? (isDarkMode? SpotifyColors.darkerGrey: Colors.white60),
        ),

      ),

    );
  }
}