import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/animation_loader_widget.dart';
import 'package:spotify/features/home/presentation/search/playlist_search/views/widgets/playlists_search_field.dart';
import 'package:spotify/features/home/presentation/search/playlist_search/views/widgets/playlists_search_list.dart';
import 'package:spotify/features/home/presentation/search/playlist_search/views_model/playlists_search_controller.dart';


class PlaylistsSearchViewBody extends StatelessWidget {
  const PlaylistsSearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PlaylistsSearchController.instance;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.04179),
      child: Column(
        children: [
          const SizedBox(height: 12,),
          const PlaylistsSearchField(),
          Obx(
                ()=> controller.playlistsSearchList.isEmpty?
            const Expanded(child: Center(child: AnimationLoaderWidget(text: "Search for a specific playlist by the playlist name.", animation: SpotifyImages.searchAnimation))):
            const Expanded(child: PlaylistsSearchList()),
          ),
        ],
      ),
    );
  }
}