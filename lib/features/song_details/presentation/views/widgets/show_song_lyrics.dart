import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class ShowSongLyrics extends StatelessWidget {
  const ShowSongLyrics({
    super.key, this.playlistDetailsController, this.offlineSongsController, this.favoritesController, this.profileController,
  });
  final PlaylistDetailsController? playlistDetailsController;
  final OfflineSongsController? offlineSongsController;
  final FavoritesController? favoritesController;
  final ProfileController? profileController;
  @override
  Widget build(BuildContext context) {
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
          child: Obx(
              ()=> Text(
                  playlistDetailsController != null?
                  playlistDetailsController!.currentSong.value.lyrics:
                  offlineSongsController != null?
                  offlineSongsController!.currentSong.value.lyrics:
                  favoritesController!=null?
                  favoritesController!.currentSong.value.lyrics:
                  profileController!.currentSong.value.lyrics,
                style: SpotifyFonts.appStylesMedium16.copyWith(color: Colors.white,wordSpacing: 3,height: 1.8),overflow: TextOverflow.visible),
          ),
        ),
      ),
    );
  }
}