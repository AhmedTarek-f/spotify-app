import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_colors.dart';

class SongsPlayIcon extends StatelessWidget implements PreferredSizeWidget{
  const SongsPlayIcon({super.key,});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
          color: SpotifyColors.primaryColor,
          shape: BoxShape.circle
      ),
      child: IconButton(
        onPressed: (){},
        icon:  Icon(
          Icons.play_arrow,
          size: 28,
          color: isDarkMode?Colors.white:Colors.black,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}