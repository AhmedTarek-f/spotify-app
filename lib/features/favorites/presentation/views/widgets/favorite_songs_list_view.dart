import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/list_of_songs_shimmer.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_item.dart';
import 'package:spotify/features/favorites/presentation/views/widgets/favorite_song_three_dots.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';

class FavoriteSongsListView extends StatelessWidget {
  const FavoriteSongsListView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;

    return Obx(
      () => controller.isFavoriteSongsLoading.value?
      const ListOfSongsShimmer():
      ListView.separated(
          itemBuilder: (_, index) => SongItem(songDetails: controller.favoriteSongsList.elementAt(index),threeDotsWidget: FavoriteSongThreeDots(songItem: controller.favoriteSongsList.elementAt(index),),),
          separatorBuilder: (_, __) => const SizedBox(height: 12,),
          itemCount: controller.favoriteSongsList.length
      ),
    );
  }
}