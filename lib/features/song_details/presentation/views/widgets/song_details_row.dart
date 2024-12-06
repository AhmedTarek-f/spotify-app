import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/add_or_remove_from_fav_button.dart';

class SongDetailsRow extends StatelessWidget {
  const SongDetailsRow({
    super.key, this.playlistDetailsController, this.offlineSongsController, this.favoritesController
  });
  final PlaylistDetailsController? playlistDetailsController;
  final OfflineSongsController? offlineSongsController;
  final FavoritesController? favoritesController;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(()=> Text(
              playlistDetailsController!= null?
              playlistDetailsController!.currentSong.value.songTitle:
              offlineSongsController != null?
              offlineSongsController!.currentSong.value.songTitle:
              favoritesController!.currentSong.value.songTitle,

              style: SpotifyFonts.appStylesBold20,
              ),
            ),
            const SizedBox(height: 8,),
            Obx(()=> Text(
              playlistDetailsController!= null?
              playlistDetailsController!.currentSong.value.songAuthor:
              offlineSongsController != null?
              offlineSongsController!.currentSong.value.songAuthor:
              favoritesController!.currentSong.value.songAuthor,

              style: SpotifyFonts.appStylesRegular20.copyWith(color:isDarkMode? const Color(0xffBABABA): const Color(0xff404040) ),
              ),
            )
          ],
        ),
        if(playlistDetailsController!= null ? playlistDetailsController!.isOfflineMode == false :offlineSongsController!=null? false :favoritesController!.isOfflineMode == false)
          playlistDetailsController!= null?
          AddOrRemoveFromFavButton(playlistDetailsController: playlistDetailsController,):
          AddOrRemoveFromFavButton(favoritesController: favoritesController,)

      ],
    );
  }
}
