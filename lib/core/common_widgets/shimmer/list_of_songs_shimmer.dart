import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/shimmer/song_item_shimmer.dart';

class ListOfSongsShimmer extends StatelessWidget {
  const ListOfSongsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
        itemBuilder: (_, index) => const SongItemShimmer(),
        separatorBuilder: (_, __) => const SizedBox(height: 12,),
        itemCount: 16
    );
  }
}