import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/show_single_song_lyrics.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/single_song_controller_row.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/single_song_details_row.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/single_song_duration_slider.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/single_song_image_container.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/single_song_open_lyrics.dart';
import 'package:spotify/features/single_song_details/presentation/views_model/single_song_details_controller.dart';

class SingleSongDetailsViewBody extends StatelessWidget {
  const SingleSongDetailsViewBody({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = SingleSongDetailsController.instance;
    final String currentSongLyrics = controller.currentSong.lyrics;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.06923),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 22,),
                  SingleSongImageContainer(),
                  SizedBox(height: 17,),
                  SingleSongDetailsRow(),
                  SizedBox(height: 32,),
                  SingleSongDurationSlider(),
                  SizedBox(
                    height: 42,
                  ),
                ],
              ),
              if (currentSongLyrics.isNotEmpty && currentSongLyrics.trim() != "")
                Obx(
                  () => controller.isShowingLyrics.value
                      ? const ShowSingleSongLyrics()
                      : const SizedBox.shrink(),
                ),
            ],
          ),
          const SingleSongControllerRow(),
          const Expanded(child: SizedBox()),
          if (currentSongLyrics.isNotEmpty && currentSongLyrics.trim() != "")
            const SingleSongOpenLyrics(),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
