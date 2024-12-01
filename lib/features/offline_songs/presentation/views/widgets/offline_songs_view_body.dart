import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/back_arrow.dart';
import 'package:spotify/features/offline_songs/presentation/views/widgets/offline_app_bar_body.dart';
import 'package:spotify/features/offline_songs/presentation/views/widgets/offline_playlist_songs_list_view.dart';

class OfflineSongsViewBody extends StatelessWidget {
  const OfflineSongsViewBody({super.key,});
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
             headerSliverBuilder: (context, innerBoxIsScrolled) => [
               SliverAppBar(
                 automaticallyImplyLeading: false,
                 expandedHeight: MediaQuery.sizeOf(context).height*0.43,
                 toolbarHeight: MediaQuery.sizeOf(context).height*0.43,
                 leading: const BackArrow(),
                 bottom: const OfflineAppBarBody(),
                 centerTitle: true,
               ),
             ],
             body: const Padding(
               padding: EdgeInsets.symmetric(horizontal: 16.0),
               child: OfflinePlaylistSongsListView(),
             ),
    );
  }
}

