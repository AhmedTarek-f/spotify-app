import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/single_song_details_app_bar.dart';
import 'package:spotify/features/single_song_details/presentation/views/widgets/single_song_details_view_body.dart';
import 'package:spotify/features/single_song_details/presentation/views_model/single_song_details_controller.dart';

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



