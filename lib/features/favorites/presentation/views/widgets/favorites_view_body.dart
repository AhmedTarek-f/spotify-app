import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/favorites/presentation/views/widgets/favorite_songs_list_view.dart';
import 'package:spotify/features/favorites/presentation/views/widgets/favorite_songs_play_icon.dart';

class FavoritesViewBody extends StatelessWidget {
  const FavoritesViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
      child:  NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return[
              const SliverAppBar(
                expandedHeight: 80,
                title: Text("Liked Songs",style: SpotifyFonts.appStylesBold22,),
                bottom: FavoriteSongsPlayIcon(),
                centerTitle: true,
                toolbarHeight: 70,
              ),
            ];
          },
          body: const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: FavoriteSongsListView(),
          ),
      ),
    );
  }
}