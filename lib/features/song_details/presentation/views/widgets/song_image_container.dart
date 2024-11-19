import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class SongImageContainer extends StatelessWidget {
  const SongImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SongDetailsController.instance;

    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height*0.4383,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(imageUrl: controller.songDetails.songImage,fit: BoxFit.cover,)
      ),
    );
  }
}
