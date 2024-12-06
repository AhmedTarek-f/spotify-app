import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_play_icon.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class SongControllersRow extends StatelessWidget {
  const SongControllersRow({
    super.key,
    this.playlistDetailsController,
    this.offlineSongsController,
    this.favoritesController,
  });

  final PlaylistDetailsController? playlistDetailsController;
  final OfflineSongsController? offlineSongsController;
  final FavoritesController? favoritesController;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async => playlistDetailsController != null
              ? await playlistDetailsController!.toggleRepeat()
              : offlineSongsController != null
                  ? await offlineSongsController!.toggleRepeat()
                  : await favoritesController!.toggleRepeat(),
          child: Obx(
            () => SvgPicture.asset(
              SpotifyImages.repeatIcon,
              colorFilter: ColorFilter.mode(
                (playlistDetailsController != null
                        ? playlistDetailsController!.isRepeating.value
                        : offlineSongsController != null
                            ? offlineSongsController!.isRepeating.value
                            : favoritesController!.isRepeating.value)
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
        GestureDetector(
          onTap: () async => playlistDetailsController != null
              ? await playlistDetailsController!.playPreviousSong()
              : offlineSongsController != null
                  ? await offlineSongsController!.playPreviousSong()
                  : await favoritesController!.playPreviousSong(),
          child: SvgPicture.asset(
            SpotifyImages.previousIcon,
            colorFilter: ColorFilter.mode(
              isDarkMode ? const Color(0xffA7A7A7) : const Color(0xff363636),
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(
          width: 17,
        ),
        SongsPlayIcon(
          onPressed: () async => playlistDetailsController != null
              ? await playlistDetailsController!.handlePlayAndPause()
              : offlineSongsController != null
                  ? await offlineSongsController!.handlePlayAndPause()
                  : await favoritesController!.handlePlayAndPause(),
          icon: Obx(
            () => Icon(
              (playlistDetailsController != null
                      ? playlistDetailsController!.isPlaying.value
                      : offlineSongsController != null
                          ? offlineSongsController!.isPlaying.value
                          : favoritesController!.isPlaying.value)
                  ? Icons.pause
                  : Icons.play_arrow,
              size: 28,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        const SizedBox(
          width: 17,
        ),
        GestureDetector(
          onTap: () async => playlistDetailsController != null
              ? await playlistDetailsController!.playNextSong()
              : offlineSongsController != null
                  ? await offlineSongsController!.playNextSong()
                  : await favoritesController!.playNextSong(),
          child: SvgPicture.asset(
            SpotifyImages.nextIcon,
            colorFilter: ColorFilter.mode(
                isDarkMode ? const Color(0xffA7A7A7) : const Color(0xff363636),
                BlendMode.srcIn),
          ),
        ),
        const SizedBox(
          width: 29,
        ),
        GestureDetector(
          onTap: () async {
            playlistDetailsController != null
                ? await playlistDetailsController!.toggleShuffle()
                : offlineSongsController != null
                    ? await offlineSongsController!.toggleShuffle()
                    : await favoritesController!.toggleShuffle();
          },
          child: Obx(
            () => SvgPicture.asset(
              SpotifyImages.shuffleIcon,
              colorFilter: ColorFilter.mode(
                  (playlistDetailsController != null
                          ? playlistDetailsController!.isShuffling.value
                          : offlineSongsController != null
                              ? offlineSongsController!.isShuffling.value
                              : favoritesController!.isShuffling.value)
                      ? SpotifyColors.primaryColor
                      : (isDarkMode
                          ? const Color(0xff6D6D6D)
                          : const Color(0xff7E7E7E)),
                  BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}
