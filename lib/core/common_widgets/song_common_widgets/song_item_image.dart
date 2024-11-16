import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SongItemImage extends StatelessWidget {
  const SongItemImage({
    super.key,
    required this.image,
    this.isNetworkImage = true,
  });

  final String image;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width*0.1487,
      height: MediaQuery.sizeOf(context).height*0.06635,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child:isNetworkImage? CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.contain,
        ):Image.asset(
          image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
