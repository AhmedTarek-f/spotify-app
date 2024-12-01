import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_item.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/animation_loader_widget.dart';
import 'package:spotify/features/offline_songs/presentation/views/widgets/offline_playlist_songs_action.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';

class OfflinePlaylistSongsListView extends StatelessWidget {
  const OfflinePlaylistSongsListView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = OfflineSongsController.instance;
    return  Obx(
      ()=> controller.songsList.isEmpty?
      const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child:AnimationLoaderWidget(text: "You haven't downloaded any songs yet!", animation: SpotifyImages.offlineModeEmptyAnimation,style: SpotifyFonts.appStylesBold18,)
      ) :ListView.separated(
          itemBuilder: (_, index) {
            return SongItem(
              songDetails: controller.songsList.elementAt(index),
              playlistSongs: controller.songsList,
              index: index,
              threeDotsWidget: OfflinePlaylistSongsAction(song: controller.songsList.elementAt(index)),
              isNetworkImage: false,
              isOffline: true,
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 12,),
          itemCount: controller.songsList.length
      )
    );
  }
}