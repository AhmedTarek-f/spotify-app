import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class ShowSongLyrics extends StatelessWidget {
  const ShowSongLyrics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SongDetailsController.instance;
    return AnimatedContainer(
      height: MediaQuery.sizeOf(context).height*0.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black45.withOpacity(0.7)
      ),
      duration: const Duration(milliseconds: 600),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
              controller.currentSong.lyrics,
              style: SpotifyFonts.appStylesMedium16.copyWith(color: Colors.white,wordSpacing: 3,height: 1.8),overflow: TextOverflow.visible),
        ),
      ),
    );
  }
}