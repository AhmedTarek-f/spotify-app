import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_play_icon.dart';
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
        SvgPicture.asset(SpotifyImages.repeatIcon,colorFilter: ColorFilter.mode(isDarkMode?const Color(0xff6D6D6D) :const Color(0xff7E7E7E), BlendMode.srcIn),),
        const SizedBox(width: 29,),
        SvgPicture.asset(SpotifyImages.previousIcon,colorFilter: ColorFilter.mode(isDarkMode?const Color(0xffA7A7A7) :const Color(0xff363636), BlendMode.srcIn),),
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
        SvgPicture.asset(SpotifyImages.nextIcon,colorFilter: ColorFilter.mode(isDarkMode?const Color(0xffA7A7A7) :const Color(0xff363636), BlendMode.srcIn),),
        const SizedBox(width: 29,),
        SvgPicture.asset(SpotifyImages.shuffleIcon,colorFilter: ColorFilter.mode(isDarkMode?const Color(0xff6D6D6D) :const Color(0xff7E7E7E), BlendMode.srcIn),),
      ],
    );
  }
}
