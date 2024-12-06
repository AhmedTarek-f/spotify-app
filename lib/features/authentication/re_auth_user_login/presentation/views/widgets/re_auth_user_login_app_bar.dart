import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/back_arrow.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';

class ReAuthUserLoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReAuthUserLoginAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: BackArrow(),
      ),
      leadingWidth: 45,
      title: const Text("Re-Authenticate User",style: SpotifyFonts.appStylesBold17,),
      backgroundColor: isDarkMode ? const Color(0xff2C2B2B): Colors.white,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
