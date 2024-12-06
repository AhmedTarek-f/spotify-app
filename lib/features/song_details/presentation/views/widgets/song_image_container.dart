import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class SongImageContainer extends StatelessWidget {
  const SongImageContainer({
    super.key, this.playlistDetailsController, this.offlineSongsController, this.favoritesController,
  });
  final PlaylistDetailsController? playlistDetailsController;
  final OfflineSongsController? offlineSongsController;
  final FavoritesController? favoritesController;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height*0.4383,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Obx(
            ()=> (playlistDetailsController!= null? playlistDetailsController!.isOfflineMode == false :offlineSongsController!= null ? false :favoritesController!.isOfflineMode == false)?
                CachedNetworkImage(imageUrl:playlistDetailsController!= null? playlistDetailsController!.currentSong.value.songImage:favoritesController!.currentSong.value.songImage,fit: BoxFit.cover,):
                Image.file(File(offlineSongsController!.currentSong.value.songImage),fit: BoxFit.cover,)
          )
      ),
    );
  }
}
