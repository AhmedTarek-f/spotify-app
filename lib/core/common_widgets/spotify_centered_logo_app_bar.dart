import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/spotify_images.dart';

class SpotifyCenteredLogoAppBar extends StatelessWidget implements PreferredSizeWidget{
  const SpotifyCenteredLogoAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset(SpotifyImages.spotifyLogoSVG,height: MediaQuery.sizeOf(context).height*0.03909,),
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}