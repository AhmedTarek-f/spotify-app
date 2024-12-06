import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class AddOrRemoveFromFavButton extends StatelessWidget {
  const AddOrRemoveFromFavButton({
    super.key, this.playlistDetailsController, this.favoritesController,
  });
  final PlaylistDetailsController? playlistDetailsController;
  final FavoritesController? favoritesController;

  @override
  Widget build(BuildContext context) {
    final controller = SongDetailsController.instance;
    return Obx(
          ()=> IconButton(
          onPressed: () async{
            await controller.addOrRemoveFavoriteSong(songId:playlistDetailsController!=null? playlistDetailsController!.currentSong.value.songId :favoritesController!.currentSong.value.songId);
          },
          icon:controller.isFavorite.value?SvgPicture.asset(SpotifyImages.loveIcon,width: 24,height: 24,colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),):SvgPicture.asset(SpotifyImages.heartIcon,width: 24,height: 24,)),
    );
  }
}
