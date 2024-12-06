import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_play_icon.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/single_song_details/presentation/views_model/single_song_details_controller.dart';

class SingleSongControllerRow extends StatelessWidget {
  const SingleSongControllerRow({super.key,});


  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = SingleSongDetailsController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async => await controller.toggleRepeat(),
          child: Obx(
            () => SvgPicture.asset(
              SpotifyImages.repeatIcon,
              colorFilter: ColorFilter.mode(
                (controller.isRepeating.value)
                    ? SpotifyColors.primaryColor
                    : (isDarkMode
                        ? const Color(0xff6D6D6D)
                        : const Color(0xff7E7E7E)),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 29,
        ),
        Padding(
          padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.12),
          child: SongsPlayIcon(
            onPressed: () async => await controller.handlePlayAndPause(),
            icon: Obx(
              () => Icon(
                controller.isPlaying.value ?
                Icons.pause :
                Icons.play_arrow,
                size: 28,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
