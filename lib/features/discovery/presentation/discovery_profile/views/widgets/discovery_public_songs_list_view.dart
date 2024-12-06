import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/list_of_songs_shimmer.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_item.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/views_model/discovery_profile_controller.dart';

class DiscoveryPublicSongsListView extends StatelessWidget {
  const DiscoveryPublicSongsListView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = DiscoveryProfileController.instance;
    return Obx(
        ()=> controller.isUserPublicSongsLoading.value? const ListOfSongsShimmer() :ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) => SongItem(
            songDetails: controller.publicSongsList.elementAt(index),
            isThreeDotsWidgetUsed: false,
            playlistSongs: controller.publicSongsList,
            index: index,
            isOffline: false,
            isSingleSong: true,
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 12,),
          itemCount: controller.publicSongsList.length
      ),
    );
  }
}

