import 'package:flutter/material.dart';

class FavoriteSongItemImage extends StatelessWidget {
  const FavoriteSongItemImage({
    super.key,
    required this.image,
  });

  final String image;

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
        child: Image.asset(
          image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
