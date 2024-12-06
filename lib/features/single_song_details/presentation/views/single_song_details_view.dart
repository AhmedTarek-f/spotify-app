import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/single_song_details_app_bar.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/single_song_details_view_body.dart';
import 'package:spotify/features/single_song_details/presentation/views_model/single_song_details_controller.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_details_app_bar.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_details_view_body.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class SingleSongDetailsView extends StatelessWidget {
  const SingleSongDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(SingleSongDetailsController());
    return  const Scaffold(
      appBar: SingleSongDetailsAppBar(),
      body: SingleSongDetailsViewBody(),
    );
  }
}



