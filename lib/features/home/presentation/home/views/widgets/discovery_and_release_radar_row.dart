import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/songs_collection_shimmer.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/songs_collection_container.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class DiscoveryAndReleaseRadarRow extends StatelessWidget {
  const DiscoveryAndReleaseRadarRow({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Obx(
      ()=> Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          controller.isLoading.value? const Expanded(child: SongsCollectionShimmer()) :SongsCollectionContainer(songsCollection: controller.discoveryPlaylist.value,),
          controller.isLoading.value? const Expanded(child: SongsCollectionShimmer()) :SongsCollectionContainer(songsCollection: controller.releaseRadarPlaylist.value,),
        ],
      ),
    );
  }
}



