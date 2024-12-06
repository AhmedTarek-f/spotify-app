import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/single_song_add_or_remove_from_fav_button.dart';
import 'package:spotify/features/single_song_details/presentation/views_model/single_song_details_controller.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/add_or_remove_from_fav_button.dart';

class SingleSongDetailsRow extends StatelessWidget {
  const SingleSongDetailsRow({super.key,});
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = SingleSongDetailsController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text(
             controller.currentSong.songTitle,
              style: SpotifyFonts.appStylesBold20,
              ),
            const SizedBox(height: 8,),
           Text(
              controller.currentSong.songAuthor,
              style: SpotifyFonts.appStylesRegular20.copyWith(color:isDarkMode? const Color(0xffBABABA): const Color(0xff404040) ),
              ),
          ],
        ),
        const SingleSongAddOrRemoveFromFavButton(),
      ],
    );
  }
}
