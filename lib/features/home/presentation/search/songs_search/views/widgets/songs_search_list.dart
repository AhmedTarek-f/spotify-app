import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_item.dart';
import 'package:spotify/features/home/presentation/search/views/songs_search/widgets/songs_search_three_dots.dart';
import 'package:spotify/features/home/presentation/search/views_model/search_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class SongsSearchList extends StatelessWidget {
  const SongsSearchList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeSearchController.instance;
    return Obx(
          ()=> Padding(
        padding: const EdgeInsets.only(top: 22),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              final List<SongModel> singleSong = [controller.songsSearchList[index]];
              return SongItem(songDetails:controller.songsSearchList[index] ,index: index,playlistSongs:singleSong,isThreeDotsWidgetUsed: true, threeDotsWidget: SongsSearchThreeDots(song: controller.songsSearchList[index]), isOffline: false,);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8,),
            itemCount: controller.songsSearchList.length
        ),
      ),
    );
  }
}