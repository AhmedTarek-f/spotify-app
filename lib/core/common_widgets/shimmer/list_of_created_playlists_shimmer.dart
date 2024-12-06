import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/shimmer/created_playlist_shimmer.dart';

class ListOfCreatedPlaylistsShimmer extends StatelessWidget {
  const ListOfCreatedPlaylistsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, __) => const CreatedPlaylistShimmer(),
      separatorBuilder: (_, __) => const SizedBox(height: 8,),
      itemCount: 8,
    );
  }
}