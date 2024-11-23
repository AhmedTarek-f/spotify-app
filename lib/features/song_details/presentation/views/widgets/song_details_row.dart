import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            Obx(()=> Text(controller.currentSong.songTitle,style: SpotifyFonts.appStylesBold20,)),
            const SizedBox(height: 8,),
            Obx(()=> Text(controller.currentSong.songAuthor,style: SpotifyFonts.appStylesRegular20.copyWith(color:isDarkMode? const Color(0xffBABABA): const Color(0xff404040) ),))
          ],
        ),
        const AddOrRemoveFromFavButton(),
      ],
    );
  }
}
