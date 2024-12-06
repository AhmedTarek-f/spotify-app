import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/home/presentation/search/playlist_search/views/widgets/playlists_search_app_bar.dart';
import 'package:spotify/features/home/presentation/search/playlist_search/views/widgets/playlists_search_view_body.dart';
import 'package:spotify/features/home/presentation/search/playlist_search/views_model/playlists_search_controller.dart';

class PlaylistsSearchView extends StatelessWidget {
  const PlaylistsSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlaylistsSearchController());
    return const Scaffold(
      appBar: PlaylistsSearchAppBar(),
      body: PlaylistsSearchViewBody(),
    );
  }
}

