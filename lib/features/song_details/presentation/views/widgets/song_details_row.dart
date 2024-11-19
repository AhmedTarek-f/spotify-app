import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/song_details/presentation/views/widgets/add_or_remove_from_fav_button.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class SongDetailsRow extends StatelessWidget {
  const SongDetailsRow({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = SongDetailsController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller.songDetails.songTitle,style: SpotifyFonts.appStylesBold20,),
            const SizedBox(height: 8,),
            Text(controller.songDetails.songAuthor,style: SpotifyFonts.appStylesRegular20.copyWith(color:isDarkMode? const Color(0xffBABABA): const Color(0xff404040) ),)
          ],
        ),
        const AddOrRemoveFromFavButton(),
      ],
    );
  }
}
