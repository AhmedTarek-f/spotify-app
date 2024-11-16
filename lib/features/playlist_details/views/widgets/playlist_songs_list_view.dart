import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/list_of_songs_shimmer.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_item.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class PlaylistSongsListView extends StatelessWidget {
  const PlaylistSongsListView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = PlaylistDetailsController.instance;
    return Obx(
        ()=> controller.isSongsLoading.value? const ListOfSongsShimmer():ListView.separated(
          itemBuilder: (_, index) => SongItem(songDetails: controller.playlistSongs.elementAt(index),),
          separatorBuilder: (_, __) => const SizedBox(height: 12,),
          itemCount: controller.playlistSongs.length
      ),
    );
  }
}


