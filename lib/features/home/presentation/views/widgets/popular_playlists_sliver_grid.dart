import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/popular_playlists_shimmer.dart';
import 'package:spotify/features/home/presentation/views/widgets/expanded_songs_collection.dart';
import 'package:spotify/features/home/presentation/views_model/home_controller.dart';

class PopularPlaylistsSliverGrid extends StatelessWidget {
  const PopularPlaylistsSliverGrid({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = HomeController.instance;
    return  Obx(
      ()=> controller.isLoading.value? const PopularPlaylistsShimmer() :SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 16,
          mainAxisExtent: 200,
        ),
        delegate: SliverChildBuilderDelegate(
                (_, index) {
                  if(controller.songsPlaylists[index].collectionImg.isNotEmpty && controller.songsPlaylists[index].collectionImg.trim() != "" ) return ExpandedSongsCollectionContainer(songsCollection: controller.songsPlaylists[index],);
                  return null;
                },
            childCount: controller.songsPlaylists.length
        ),

      ),
    );
  }
}



