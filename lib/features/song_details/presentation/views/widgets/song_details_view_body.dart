import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/open_lyrics.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/show_song_lyrics.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_controller_row.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_details_row.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_duration_slider.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_image_container.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class SongDetailsViewBody extends StatelessWidget {
  const SongDetailsViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = SongDetailsController.instance;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.06923),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 22,),
                  SongImageContainer(),
                  SizedBox(height: 17,),
                  SongDetailsRow(),
                  SizedBox(height: 32,),
                  SongDurationSlider(),
                  SizedBox(height: 42,),
                ],
              ),
             Obx(()=> controller.isShowingLyrics.value?const ShowSongLyrics():const SizedBox.shrink()),
            ],
          ),

            const SongControllersRow(),
            const Expanded(child: SizedBox()),
            const OpenLyrics(),
            const SizedBox(height: 12,),
          ],
        ),
    );
  }
}

