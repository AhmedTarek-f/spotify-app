import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';

class DiscoveryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DiscoveryAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text("Discovery",style: SpotifyFonts.appStylesBold17,),
      centerTitle: true,
      backgroundColor: isDarkMode ? const Color(0xff2C2B2B): Colors.white,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
