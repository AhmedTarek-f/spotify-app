import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/shimmer/play_lists_horizontally_shimmer.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/views/widgets/songs_collection_container.dart';
import 'package:spotify/features/home/presentation/views_model/home_controller.dart';

class PlaylistsHorizontallyListView extends StatelessWidget {
  const PlaylistsHorizontallyListView({super.key, required this.songsPlaylists});
  final Set<SongsCollectionModel> songsPlaylists;
  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return controller.isRecentlyPlayedLoading.value? const PlaylistsHorizontallyShimmer() :SizedBox(
      height: MediaQuery.sizeOf(context).height*0.218,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            List<SongsCollectionModel> songsList = songsPlaylists.toList();
            return SongsCollectionContainer(songsCollection: songsList[index]);
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12,),
          itemCount: songsPlaylists.length
      ),
    );
  }
}