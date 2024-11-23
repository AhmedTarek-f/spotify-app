import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_details_app_bar.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/song_details_view_body.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class SongDetailsView extends StatelessWidget {
  const SongDetailsView({super.key,});
  @override
  Widget build(BuildContext context) {
    Get.put(SongDetailsController());
    return const Scaffold(
      appBar: SongDetailsAppBar(),
      body: SongDetailsViewBody(),
    );
  }
}


