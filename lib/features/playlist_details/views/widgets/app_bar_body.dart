import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_play_icon.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';

class AppBarBody extends StatelessWidget implements PreferredSizeWidget{
  const AppBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    final SongsCollectionModel playlist = Get.arguments["playlist"];
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
        const SongsPlayIcon(),

      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
