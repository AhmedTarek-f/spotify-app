import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_colors.dart';

class SongsPlayIcon extends StatelessWidget implements PreferredSizeWidget{
  const SongsPlayIcon({super.key, this.onPressed, required this.icon,});
  final void Function()? onPressed;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
          color: SpotifyColors.primaryColor,
          shape: BoxShape.circle
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}