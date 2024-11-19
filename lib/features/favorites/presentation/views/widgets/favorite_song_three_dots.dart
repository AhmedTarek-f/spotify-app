import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class FavoriteSongThreeDots extends StatelessWidget {
  const FavoriteSongThreeDots({super.key, required this.songItem,});
  final SongModel songItem;
  @override
  Widget build(BuildContext context) {
    final favoritesController = FavoritesController.instance;
    return PopupMenuButton<String>(
      onSelected: (value) async{
        if (value == "removeFromFavoriteSongs"){
          favoritesController.favoriteSongsList.removeWhere((song) => song.songId == songItem.songId );
          await favoritesController.deleteFromYourFavoriteSongs(songId: songItem.songId);
        }

      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'removeFromFavoriteSongs',
          child: Row(
            children: [
              Icon(Icons.remove, color: Colors.red),
              SizedBox(width: 8),
              Text('remove'),
            ],
          ),
        )
      ],
      icon:  SvgPicture.asset(SpotifyImages.threeDotsHorizontallyIcon),
    );
  }
}