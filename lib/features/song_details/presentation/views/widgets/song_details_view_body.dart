import 'package:flutter/material.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/open_lyrics.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_controller_row.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_details_row.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_duration_slider.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_image_container.dart';

class SongDetailsViewBody extends StatelessWidget {
  const SongDetailsViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.06923),
      child:const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(height: 22,),
          SongImageContainer(),
            SizedBox(height: 17,),
            SongDetailsRow(),
            SizedBox(height: 32,),
            SongDurationSlider(),
            SizedBox(height: 42,),
            SongControllersRow(),
            Expanded(child: SizedBox()),
            OpenLyrics(),
            SizedBox(height: 12,),
          ],
        ),
    );
  }
}