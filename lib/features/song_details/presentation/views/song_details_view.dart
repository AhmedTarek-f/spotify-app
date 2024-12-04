import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_details_app_bar.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_details_view_body.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class SongDetailsView extends StatelessWidget {
  const SongDetailsView({
    super.key,
    required this.playlistDetailsController,
    required this.profileController,
    required this.offlineSongsController,
    required this.favoritesController,
  });
  final PlaylistDetailsController? playlistDetailsController;
  final ProfileController? profileController;
  final OfflineSongsController? offlineSongsController;
  final FavoritesController? favoritesController;
  @override
  Widget build(BuildContext context) {
    Get.put(SongDetailsController());
    return  Scaffold(
      appBar: const SongDetailsAppBar(),
      body: SongDetailsViewBody(
        playlistDetailsController: playlistDetailsController,
        offlineSongsController: offlineSongsController,
        favoritesController: favoritesController,
        profileController: profileController,
      ),
    );
  }
}



