import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/open_lyrics.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/show_song_lyrics.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_controller_row.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_details_row.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_duration_slider.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_image_container.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class SongDetailsViewBody extends StatelessWidget {
  const SongDetailsViewBody(
      {super.key,
      required this.playlistDetailsController,
      required this.offlineSongsController,
      required this.favoritesController
      });

  final PlaylistDetailsController? playlistDetailsController;
  final OfflineSongsController? offlineSongsController;
  final FavoritesController? favoritesController;

  @override
  Widget build(BuildContext context) {
    final controller = SongDetailsController.instance;
    final currentSongLyrics = playlistDetailsController != null
        ? playlistDetailsController!.currentSong.value.lyrics
        : offlineSongsController != null
            ? offlineSongsController!.currentSong.value.lyrics
            : favoritesController!.currentSong.value.lyrics;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.06923),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 22,
                  ),
                  playlistDetailsController != null
                      ? SongImageContainer(
                          playlistDetailsController: playlistDetailsController,
                        )
                      : offlineSongsController != null
                          ? SongImageContainer(
                              offlineSongsController: offlineSongsController)
                          : SongImageContainer(
                                  favoritesController: favoritesController,
                                ),
                  const SizedBox(
                    height: 17,
                  ),
                  playlistDetailsController != null
                      ? SongDetailsRow(
                          playlistDetailsController: playlistDetailsController,
                        )
                      : offlineSongsController != null
                          ? SongDetailsRow(
                              offlineSongsController: offlineSongsController,
                            )
                          : SongDetailsRow(
                                  favoritesController: favoritesController,
                                ),
                  const SizedBox(
                    height: 32,
                  ),
                  playlistDetailsController != null
                      ? SongDurationSlider(
                          playlistDetailsController: playlistDetailsController,
                        )
                      : offlineSongsController != null
                          ? SongDurationSlider(
                              offlineSongsController: offlineSongsController,
                            )
                          :SongDurationSlider(
                                  favoritesController: favoritesController,
                                ),
                  const SizedBox(
                    height: 42,
                  ),
                ],
              ),
              if (currentSongLyrics.isNotEmpty &&
                  currentSongLyrics.trim() != "")
                Obx(
                  () => controller.isShowingLyrics.value
                      ? (playlistDetailsController != null
                          ? ShowSongLyrics(
                              playlistDetailsController:
                                  playlistDetailsController,
                            )
                          : offlineSongsController != null
                              ? ShowSongLyrics(
                                  offlineSongsController:
                                      offlineSongsController)
                              :ShowSongLyrics(
                                      favoritesController: favoritesController,
                                    ))
                      : const SizedBox.shrink(),
                ),
            ],
          ),
          playlistDetailsController != null
              ? SongControllersRow(
                  playlistDetailsController: playlistDetailsController)
              : offlineSongsController != null
                  ? SongControllersRow(
                      offlineSongsController: offlineSongsController)
                  : SongControllersRow(
                          favoritesController: favoritesController,
                        ),
          const Expanded(child: SizedBox()),
          if (currentSongLyrics.isNotEmpty && currentSongLyrics.trim() != "")
            const OpenLyrics(),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
