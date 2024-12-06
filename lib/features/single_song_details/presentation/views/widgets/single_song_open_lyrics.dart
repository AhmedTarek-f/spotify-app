import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/single_song_details/presentation/views_model/single_song_details_controller.dart';

class SingleSongOpenLyrics extends StatelessWidget {
  const SingleSongOpenLyrics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = SingleSongDetailsController.instance;
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
