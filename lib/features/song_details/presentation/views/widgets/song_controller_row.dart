import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_play_icon.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class SongControllersRow extends StatelessWidget {
  const SongControllersRow({
    super.key,
    this.playlistDetailsController,
    this.offlineSongsController,
    this.favoritesController,
    this.profileController,
  });

  final PlaylistDetailsController? playlistDetailsController;
  final OfflineSongsController? offlineSongsController;
  final FavoritesController? favoritesController;
  final ProfileController? profileController;

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
                  : favoritesController != null
                      ? await favoritesController!.toggleRepeat()
                      : await profileController!.toggleRepeat(),
          child: Obx(
            () => SvgPicture.asset(
              SpotifyImages.repeatIcon,
              colorFilter: ColorFilter.mode(
                (playlistDetailsController != null
                        ? playlistDetailsController!.isRepeating.value
                        : offlineSongsController != null
                            ? offlineSongsController!.isRepeating.value
                            : favoritesController != null
                                ? favoritesController!.isRepeating.value
                                : profileController!.isRepeating.value)
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
                  : favoritesController != null
                      ? await favoritesController!.playPreviousSong()
                      : await profileController!.playPreviousSong(),
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
                  : favoritesController != null
                      ? await favoritesController!.handlePlayAndPause()
                      : await profileController!.handlePlayAndPause(),
          icon: Obx(
            () => Icon(
              (playlistDetailsController != null
                      ? playlistDetailsController!.isPlaying.value
                      : offlineSongsController != null
                          ? offlineSongsController!.isPlaying.value
                          : favoritesController != null
                              ? favoritesController!.isPlaying.value
                              : profileController!.isPlaying.value)
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
                  : favoritesController != null
                      ? await favoritesController!.playNextSong()
                      : await profileController!.playNextSong(),
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
                    : favoritesController != null
                        ? await favoritesController!.toggleShuffle()
                        : await profileController!.toggleShuffle();
          },
          child: Obx(
            () => SvgPicture.asset(
              SpotifyImages.shuffleIcon,
              colorFilter: ColorFilter.mode(
                  (playlistDetailsController != null
                          ? playlistDetailsController!.isShuffling.value
                          : offlineSongsController != null
                              ? offlineSongsController!.isShuffling.value
                              : favoritesController != null
                                  ? favoritesController!.isShuffling.value
                                  : profileController!.isShuffling.value)
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
