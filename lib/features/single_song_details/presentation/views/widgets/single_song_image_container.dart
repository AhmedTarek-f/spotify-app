
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotify/features/single_song_details/presentation/views_model/single_song_details_controller.dart';

class SingleSongImageContainer extends StatelessWidget {
  const SingleSongImageContainer({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = SingleSongDetailsController.instance;
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height*0.4383,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(imageUrl:controller.currentSong.songImage)
      ),
    );
  }
}
