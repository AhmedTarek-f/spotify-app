import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class SongDurationSlider extends StatelessWidget {
  const SongDurationSlider({
    super.key, this.playlistDetailsController, this.offlineSongsController, this.favoritesController, this.profileController,
  });
  final PlaylistDetailsController? playlistDetailsController;
  final OfflineSongsController? offlineSongsController;
  final FavoritesController? favoritesController;
  final ProfileController? profileController;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return  Column(
      children: [
        Obx(
              ()=> Slider(
              min: 0.0,
              max: playlistDetailsController!=null?
              playlistDetailsController!.duration.value.inSeconds.toDouble():
              offlineSongsController != null?
              offlineSongsController!.duration.value.inSeconds.toDouble():
              favoritesController != null?
              favoritesController!.duration.value.inSeconds.toDouble():
              profileController!.duration.value.inSeconds.toDouble(),

              value: playlistDetailsController!=null?
              playlistDetailsController!.position.value.inSeconds.toDouble():
              offlineSongsController != null?
              offlineSongsController!.position.value.inSeconds.toDouble():
              favoritesController != null?
              favoritesController!.position.value.inSeconds.toDouble():
              profileController!.position.value.inSeconds.toDouble(),

              inactiveColor: isDarkMode? const Color(0xff888888) : const Color(0xff000000),
              activeColor: isDarkMode? const Color(0xffB7B7B7) : const Color(0xff434343),

              onChanged: playlistDetailsController!=null?
              playlistDetailsController!.handleSeek:
              offlineSongsController != null?
              offlineSongsController!.handleSeek:
              favoritesController != null?
              favoritesController!.handleSeek:
              profileController!.handleSeek
          ),
        ),
        Obx(
              ()=> Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  playlistDetailsController!=null?
                  playlistDetailsController!.formatDuration(playlistDetailsController!.position.value):
                  offlineSongsController != null?
                  offlineSongsController!.formatDuration(offlineSongsController!.position.value):
                  favoritesController != null?
                  favoritesController!.formatDuration(favoritesController!.position.value):
                  profileController!.formatDuration(profileController!.position.value)
              ),
              Text(
                  playlistDetailsController!=null?
                  playlistDetailsController!.formatDuration(playlistDetailsController!.duration.value):
                  offlineSongsController != null?
                  offlineSongsController!.formatDuration(offlineSongsController!.duration.value):
                  favoritesController != null?
                  favoritesController!.formatDuration(favoritesController!.duration.value):
                  profileController!.formatDuration(profileController!.duration.value),
              )
            ],
          ),
        ),
      ],
    );
  }
}
