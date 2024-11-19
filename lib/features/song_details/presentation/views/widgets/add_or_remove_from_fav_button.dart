import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class AddOrRemoveFromFavButton extends StatelessWidget {
  const AddOrRemoveFromFavButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller = SongDetailsController.instance;
    return Obx(
          ()=> IconButton(
          onPressed: () async{
            await controller.addOrRemoveFavoriteSong(songId: controller.songDetails.songId);
          },
          icon:controller.isFavorite.value?SvgPicture.asset(SpotifyImages.loveIcon,width: 24,height: 24,colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),):SvgPicture.asset(SpotifyImages.heartIcon,width: 24,height: 24,)),
    );
  }
}
