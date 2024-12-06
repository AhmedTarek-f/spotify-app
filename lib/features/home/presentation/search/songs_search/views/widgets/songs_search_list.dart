import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_item.dart';
import 'package:spotify/features/home/presentation/search/songs_search/views/widgets/songs_search_three_dots.dart';
import 'package:spotify/features/home/presentation/search/songs_search/views_model/songs_search_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class SongsSearchList extends StatelessWidget {
  const SongsSearchList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SongsSearchController.instance;
    return Obx(
          ()=> Padding(
        padding: const EdgeInsets.only(top: 22),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              final List<SongModel> singleSong = [controller.songsSearchList[index]];
              return SongItem(
                songDetails:controller.songsSearchList[index],
                index: index,
                playlistSongs: singleSong,
                isThreeDotsWidgetUsed: true,
                threeDotsWidget: SongsSearchThreeDots(song: controller.songsSearchList[index]),
                isOffline: false,
                isSingleSong: true,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 16,),
            itemCount: controller.songsSearchList.length
        ),
      ),
    );
  }
}