import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';

class OpenLyrics extends StatelessWidget {
  const OpenLyrics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(

      children: [
        Center(child: SvgPicture.asset(SpotifyImages.arrowUp,colorFilter: ColorFilter.mode(isDarkMode?const Color(0xff8C8989) :const Color(0xff414141), BlendMode.srcIn),)),
        const SizedBox(height: 4,),
        const Center(child: Text("Lyrics",style: SpotifyFonts.appStylesMedium14,))
      ],
    );
  }
}
