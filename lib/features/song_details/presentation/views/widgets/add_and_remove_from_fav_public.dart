import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class AddAndRemoveFromFavPublic extends StatelessWidget {
  const AddAndRemoveFromFavPublic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SongDetailsController.instance;
    final profileController = Get.put(ProfileController());;
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.055),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 40),
        onSelected: (value) async{
          if (value == "addToFavoriteProfile"){
            controller.isFavoritePublic.value=true;
            profileController.publicSongsList.add(controller.songDetails);
            await controller.addToYourPublicFavoriteSongs(songId: controller.songDetails.songId);
          }
          else if(value == "removeFromFavoriteProfile"){
            controller.isFavoritePublic.value=false;
            profileController.publicSongsList.removeWhere((song) => song.songId == controller.songDetails.songId);
            await controller.deleteFromYourPublicFavoriteSongs(songId: controller.songDetails.songId);
          }
        },
        itemBuilder: (context) => [
          controller.isFavoritePublic.value?
          const PopupMenuItem(
            value: 'removeFromFavoriteProfile',
            child: Row(
              children: [
                Icon(Icons.remove, color: Colors.red),
                SizedBox(width: 8),
                Text('Remove from your profile songs'),
              ],
            ),
          )
              :const PopupMenuItem(
            value: 'addToFavoriteProfile',
            child: Row(
              children: [
                Icon(Icons.add, color: SpotifyColors.primaryColor),
                SizedBox(width: 8),
                Text('Add to your profile songs'),
              ],
            ),
          ),
        ],
        icon:  SvgPicture.asset(SpotifyImages.threeDotsIcon),
      ),
    );
  }
}
