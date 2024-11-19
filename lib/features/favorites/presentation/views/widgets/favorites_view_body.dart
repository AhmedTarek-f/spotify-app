import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_play_icon.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/animation_loader_widget.dart';
import 'package:spotify/features/favorites/presentation/views/widgets/favorite_songs_list_view.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';

class FavoritesViewBody extends StatelessWidget {
  const FavoritesViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = FavoritesController.instance;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
      child: Obx(()=> controller.favoriteSongsList.isNotEmpty?NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return[
            SliverAppBar(
              expandedHeight: 80,
              title: const Text("Liked Songs",style: SpotifyFonts.appStylesBold22,),
              bottom: SongsPlayIcon(
                onPressed: (){},
                icon: Icon(
                  // controller.isPlaying.value? Icons.pause :Icons.play_arrow,
                  Icons.play_arrow,
                  size: 28,
                  color: isDarkMode?Colors.white:Colors.black,
                ),
              ),
              centerTitle: true,
              toolbarHeight: 70,
            ),
          ];
        },
        body: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: FavoriteSongsListView(),
        ),
      ):const AnimationLoaderWidget(text: "You haven't added any songs to your favorite songs yet!", animation: SpotifyImages.flyingSongsAnimation) )  ,
    );
  }
}