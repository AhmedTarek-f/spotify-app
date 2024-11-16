import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/back_arrow.dart';
import 'package:spotify/core/common_widgets/sportify_custom_app_bar.dart';
import 'package:spotify/features/playlist_details/views/widgets/playlist_details_view_body.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class PlaylistDetailsView extends StatelessWidget {
  const PlaylistDetailsView({super.key,});
  @override
  Widget build(BuildContext context) {
     Get.put(PlaylistDetailsController());
    return const Scaffold(
      body: PlaylistDetailsViewBody(),
    );
  }
}
