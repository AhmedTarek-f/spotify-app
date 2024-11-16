import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_item_image.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class SongItem extends StatelessWidget {
  const SongItem({super.key, required this.songDetails, this.isNetworkImage});
  final SongModel songDetails;
  final bool? isNetworkImage;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: (){

      },
      splashColor: SpotifyColors.primaryColor.withOpacity(0.3),
      highlightColor: SpotifyColors.primaryColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1,color: SpotifyColors.primaryColor.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
                color:isDarkMode? Colors.white54.withOpacity(0.1) : Colors.black38.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1
            ),
          ]
        ),
        child: Row(
          children: [
            SongItemImage(image: songDetails.songImage,isNetworkImage: isNetworkImage ?? true,),
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
        ),
      ),
    );
  }
}
