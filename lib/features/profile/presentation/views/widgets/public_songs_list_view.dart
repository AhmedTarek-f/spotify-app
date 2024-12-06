import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/list_of_songs_shimmer.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_item.dart';
import 'package:spotify/features/profile/presentation/views/widgets/public_song_three_dots.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';


class PublicSongsListView extends StatelessWidget {
  const PublicSongsListView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = ProfileController.instance;
    return Obx(
        ()=> controller.isPublicSongsLoading.value? const ListOfSongsShimmer() :ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) => Obx(
              ()=> SongItem(
              songDetails: controller.publicSongsList.elementAt(index),
              threeDotsWidget: PublicSongThreeDots(songItem: controller.publicSongsList.elementAt(index),),
              playlistSongs: controller.publicSongsList,
              index: index,
              isOffline: false,
              isSingleSong: true,
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 12,),
          itemCount: controller.publicSongsList.length
      ),
    );
  }
}

