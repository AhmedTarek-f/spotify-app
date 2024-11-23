import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class OpenLyrics extends StatelessWidget {
  const OpenLyrics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = SongDetailsController.instance;
    return GestureDetector(
      onTap: (){
        controller.toggleShowLyrics();
      },
      child: Obx(
        ()=> Column(
          children: [
           if(!controller.isShowingLyrics.value) Center(child: SvgPicture.asset(SpotifyImages.arrowUp,colorFilter: ColorFilter.mode(isDarkMode?const Color(0xff8C8989) :const Color(0xff414141), BlendMode.srcIn),)),
           if(!controller.isShowingLyrics.value) const SizedBox(height: 4,),
            const Center(child: Text("Lyrics",style: SpotifyFonts.appStylesMedium14,)),
            if(controller.isShowingLyrics.value) const SizedBox(height: 4,),
            if(controller.isShowingLyrics.value) Center(child: Transform.rotate(angle:pi, child: SvgPicture.asset(SpotifyImages.arrowUp,colorFilter: ColorFilter.mode(isDarkMode?const Color(0xff8C8989) :const Color(0xff414141), BlendMode.srcIn),))),
          ],
        ),
      ),
    );
  }
}
