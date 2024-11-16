import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/favorites/presentation/views/widgets/favorite_song_item_image.dart';
import 'package:spotify/features/song_details/data/models/song_model.dart';

class SongItem extends StatelessWidget {
  const SongItem({super.key, required this.songDetails});
  final SongModel songDetails;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FavoriteSongItemImage(image: songDetails.songImage),
        const SizedBox(width: 20,),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(songDetails.songTitle,style: SpotifyFonts.appStylesBold16,maxLines: 1,),
              Text(songDetails.songAuthor,style: SpotifyFonts.appStylesRegular12,maxLines: 1,),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(child: Text(songDetails.songLength,style: SpotifyFonts.appStylesRegular15,)),
              Expanded(child: SvgPicture.asset(SpotifyImages.threeDotsHorizontallyIcon)),
            ],
          ),
        )
      ],
    );
  }
}
