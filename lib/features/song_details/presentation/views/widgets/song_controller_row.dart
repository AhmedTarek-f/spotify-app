import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_play_icon.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class SongControllersRow extends StatelessWidget {
  const SongControllersRow({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = SongDetailsController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => controller.toggleRepeat(),
          child: Obx(
            ()=> SvgPicture.asset(
              SpotifyImages.repeatIcon,
              colorFilter: ColorFilter.mode(
              controller.isRepeating.value? SpotifyColors.primaryColor:(isDarkMode?
                const Color(0xff6D6D6D):
                const Color(0xff7E7E7E)),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(width: 29,),
        GestureDetector(
          onTap: ()async=> await controller.playPreviousSong(),
          child: SvgPicture.asset(
            SpotifyImages.previousIcon,
            colorFilter: ColorFilter.mode(
              isDarkMode ? const Color(0xffA7A7A7) : const Color(0xff363636),
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 17,),
        SongsPlayIcon(
          onPressed: controller.handlePlayAndPause,
          icon: Obx(
                ()=> Icon(
              controller.isPlaying.value? Icons.pause :Icons.play_arrow,
              size: 28,
              color: isDarkMode?Colors.white:Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 17,),
        GestureDetector(
          onTap:() async => await controller.playNextSong(),
            child: SvgPicture.asset(
              SpotifyImages.nextIcon,
              colorFilter: ColorFilter.mode(isDarkMode?const Color(0xffA7A7A7) :const Color(0xff363636), BlendMode.srcIn),
            ),
        ),
        const SizedBox(width: 29,),
        GestureDetector(
          onTap: (){
            controller.toggleShuffle();
          },
            child: Obx(
                ()=> SvgPicture.asset(SpotifyImages.shuffleIcon,colorFilter: ColorFilter.mode(
                  controller.isShuffling.value? SpotifyColors.primaryColor:(isDarkMode?const Color(0xff6D6D6D) :const Color(0xff7E7E7E)), BlendMode.srcIn
              ),
              ),
            ),
        ),
      ],
    );
  }
}
