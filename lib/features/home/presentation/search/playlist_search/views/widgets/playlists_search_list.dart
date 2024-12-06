import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/expanded_songs_collection.dart';
import 'package:spotify/features/home/presentation/search/playlist_search/views_model/playlists_search_controller.dart';


class PlaylistsSearchList extends StatelessWidget {
  const PlaylistsSearchList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PlaylistsSearchController.instance;
    return Obx(
          ()=> Padding(
        padding: const EdgeInsets.only(top: 22),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            ),
            itemBuilder: (_, index) {
              return ExpandedSongsCollectionContainer(songsCollection: controller.playlistsSearchList[index]);
            },
          itemCount: controller.playlistsSearchList.length,
        ),
      ),
    );
  }
}