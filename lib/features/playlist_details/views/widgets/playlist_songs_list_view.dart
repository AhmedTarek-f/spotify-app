import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/list_of_songs_shimmer.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_item.dart';
import 'package:spotify/features/playlist_details/views/widgets/playlist_songs_three_dots.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class PlaylistSongsListView extends StatelessWidget {
  const PlaylistSongsListView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = PlaylistDetailsController.instance;
    return Obx(
        ()=> controller.isSongsLoading.value? const ListOfSongsShimmer():
        ListView.separated(
            itemBuilder: (_, index) => Obx(
                ()=> SongItem(
                songDetails: controller.playlistSongs.elementAt(index),
                isThreeDotsWidgetUsed: ((controller.playlist.createdBy?.isNotEmpty ?? false) && controller.playlist.createdBy != null && FirebaseAuth.instance.currentUser?.uid == controller.playlist.id),
                playlistSongs: controller.playlistSongs,
                index: index,
                threeDotsWidget: PlaylistSongsThreeDots(song: controller.playlistSongs.elementAt(index)),
                isOffline: false,
                isPlaying:(controller.isPlaying.value && controller.currentSongIndex.value == index),
              ),
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 16,),
            itemCount: controller.playlistSongs.length
                ),

    );
  }
}