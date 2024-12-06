import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class PlaylistSongsThreeDots extends StatelessWidget {
  const PlaylistSongsThreeDots({super.key, required this.song,});
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    final controller = PlaylistDetailsController.instance;

    return InkWell(
        splashColor: SpotifyColors.primaryColor.withOpacity(0.4),
        highlightColor: SpotifyColors.primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(50),
        onTap: () async {
          await controller.deleteSongFromCreatedPlaylist(song: song);
        },
        child: Obx(
              ()=> (controller.isDeletingSongLoading.value && controller.deletedSongName == song.songTitle)?
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: SizedBox(width: 16,height: 16,child: CircularProgressIndicator(color: Colors.redAccent,),),
          )  :
          const Icon(Icons.remove,color: Colors.redAccent,size: 32,),
        )
    );
  }
}
