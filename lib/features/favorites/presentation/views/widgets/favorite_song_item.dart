import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/favorites/data/favorite_song_details_model.dart';
import 'package:spotify/features/favorites/presentation/views/widgets/favorite_song_item_image.dart';

class FavoriteSongItem extends StatelessWidget {
  const FavoriteSongItem({super.key, required this.favoriteSongDetails});
  final FavoriteSongDetailsModel favoriteSongDetails;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FavoriteSongItemImage(image: favoriteSongDetails.songImage),
        const SizedBox(width: 20,),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(favoriteSongDetails.songTitle,style: SpotifyFonts.appStylesBold16,maxLines: 1,),
              Text(favoriteSongDetails.songAuthor,style: SpotifyFonts.appStylesRegular12,maxLines: 1,),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(child: Text(favoriteSongDetails.songLength,style: SpotifyFonts.appStylesRegular15,)),
              Expanded(child: SvgPicture.asset(SpotifyImages.threeDotsHorizontallyIcon)),
            ],
          ),
        )
      ],
    );
  }
}
