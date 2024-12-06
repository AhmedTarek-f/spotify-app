import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/animation_loader_widget.dart';
import 'package:spotify/features/favorites/presentation/views/widgets/favorite_songs_list_view.dart';
import 'package:spotify/features/favorites/presentation/views/widgets/favorites_app_bar_body.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';

class FavoritesViewBody extends StatelessWidget {
  const FavoritesViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
      child: Obx(()=> controller.favoriteSongsList.isNotEmpty?NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return[
             const SliverAppBar(
              expandedHeight: 100,
              toolbarHeight: 100,
              title: Text("Liked Songs",style: SpotifyFonts.appStylesBold22,),
              bottom: FavoritesAppBarBody(),
              centerTitle: true,
            ),
          ];
        },
        body: const Padding(
          padding: EdgeInsets.only(top: 32.0),
          child: FavoriteSongsListView(),
        ),
      ):const AnimationLoaderWidget(text: "You haven't added any songs to your favorite songs yet!", animation: SpotifyImages.flyingSongsAnimation) )  ,
    );
  }
}