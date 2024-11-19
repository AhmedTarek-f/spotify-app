import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/shimmer/songs_collection_shimmer.dart';

class PopularPlaylistsShimmer extends StatelessWidget {
  const PopularPlaylistsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 16,
        mainAxisExtent: 200,
      ),
      delegate: SliverChildBuilderDelegate(
              (_, index) => const SongsCollectionShimmer(),
          childCount: 6
      ),

    );
  }
}
