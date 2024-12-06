import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/animation_loader_widget.dart';
import 'package:spotify/features/home/presentation/search/views/songs_search/widgets/songs_search_field.dart';
import 'package:spotify/features/home/presentation/search/views/songs_search/widgets/songs_search_list.dart';
import 'package:spotify/features/home/presentation/search/views_model/search_controller.dart';

class SongsSearchViewBody extends StatelessWidget {
  const SongsSearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeSearchController.instance;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.04179),
      child: Column(
        children: [
          const SizedBox(height: 12,),
          const SongsSearchField(),
          Obx(
                ()=> controller.songsSearchList.isEmpty?
            const Expanded(child: Center(child: AnimationLoaderWidget(text: "Search for a specific song by the song name.", animation: SpotifyImages.searchAnimation))):
            const Expanded(child: SongsSearchList()),
          ),
        ],
      ),
    );
  }
}