import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/back_arrow.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/playlist_details/views/widgets/app_bar_body.dart';
import 'package:spotify/features/playlist_details/views/widgets/playlist_songs_list_view.dart';

class PlaylistDetailsViewBody extends StatelessWidget {
  const PlaylistDetailsViewBody({super.key, required this.playlist,});
  final SongsCollectionModel playlist;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: MediaQuery.sizeOf(context).height*0.41,
            toolbarHeight: MediaQuery.sizeOf(context).height*0.41,
            leading: const BackArrow(),
            bottom: AppBarBody(playlist: playlist,),
            centerTitle: true,
          ),
        ],
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: PlaylistSongsListView(),
        ),
    );
  }
}

