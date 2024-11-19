import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_play_icon.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class AppBarBody extends StatelessWidget implements PreferredSizeWidget{
  const AppBarBody({super.key, required this.playlist});
  final SongsCollectionModel playlist;
  @override
  Widget build(BuildContext context) {
    final controller = PlaylistDetailsController.instance;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: SpotifyColors.primaryColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ]
          ),
          child: Container(
              width: MediaQuery.sizeOf(context).width*0.6,
              height: MediaQuery.sizeOf(context).height*0.28,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  imageUrl: playlist.collectionImg,
                  fit: BoxFit.contain,
                ),
              )
          ),
        ),
        const SizedBox(height: 22,),
        Text(playlist.collectionTitle,style: SpotifyFonts.appStylesBold22,),
        const SizedBox(height: 12,),
        SongsPlayIcon(
          onPressed: (){},
          icon: Icon(
            controller.isPlaying.value? Icons.pause :Icons.play_arrow,
            size: 28,
            color: isDarkMode?Colors.white:Colors.black,
          ),
        ),

      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
