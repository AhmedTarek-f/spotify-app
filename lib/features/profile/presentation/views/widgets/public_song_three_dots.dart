import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class PublicSongThreeDots extends StatelessWidget {
  const PublicSongThreeDots({super.key, required this.songItem,});
  final SongModel songItem;
  @override
  Widget build(BuildContext context) {
    final profileController = ProfileController.instance;
    return PopupMenuButton<String>(
      onSelected: (value) async{
        if (value == "removeFromPublicSongs"){
          profileController.publicSongsList.removeWhere((song) => song.songId == songItem.songId );
          await profileController.deleteFromYourPublicFavoriteSongs(songId: songItem.songId);
        }

      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'removeFromPublicSongs',
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
