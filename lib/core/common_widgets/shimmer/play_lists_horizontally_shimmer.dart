import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/shimmer/songs_collection_shimmer.dart';

class PlaylistsHorizontallyShimmer extends StatelessWidget {
  const PlaylistsHorizontallyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.23,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => const SongsCollectionShimmer(),
          separatorBuilder: (_, __) => const SizedBox(width: 12,),
          itemCount: 6
      ),
    );;
  }
}