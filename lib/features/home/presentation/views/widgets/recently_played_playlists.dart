import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/play_lists_horizontally_shimmer.dart';
import 'package:spotify/features/home/presentation/views/widgets/songs_collection_container.dart';
import 'package:spotify/features/home/presentation/views_model/home_controller.dart';

class RecentlyPlayedPlaylists extends StatelessWidget {
  const RecentlyPlayedPlaylists({super.key,});
  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.228,
      child: Obx(
            ()=> controller.isRecentlyPlayedPlaylistsLoading.value? const PlaylistsHorizontallyShimmer() :ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => SongsCollectionContainer(songsCollection: controller.recentlyPlayedPlaylists.elementAt(index)),
            separatorBuilder: (_, __) => const SizedBox(width: 12,),
            itemCount: controller.recentlyPlayedPlaylists.length
        ),
      ),
      
    );
  }
}