import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/playlist_details/views/widgets/playlist_details_bottom_nav.dart';
import 'package:spotify/features/playlist_details/views/widgets/playlist_details_view_body.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class PlaylistDetailsView extends StatelessWidget {
  const PlaylistDetailsView({super.key, required this.playlist,});
  final SongsCollectionModel playlist;
  @override
  Widget build(BuildContext context) {
    final controller= Get.put(PlaylistDetailsController());
    return  Scaffold(
      body: PlaylistDetailsViewBody(playlist: playlist,),
      bottomNavigationBar: Obx(()=> (controller.isSongsLoading.value || !controller.isPlaying.value)? const SizedBox.shrink() :const PlaylistDetailsBottomNav()) ,
    );
  }
}

