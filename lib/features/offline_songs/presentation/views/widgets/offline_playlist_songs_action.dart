import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class OfflinePlaylistSongsAction extends StatelessWidget {
  const OfflinePlaylistSongsAction({super.key, required this.song,});
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    final controller = OfflineSongsController.instance;

    return InkWell(
        splashColor: SpotifyColors.primaryColor.withOpacity(0.4),
        highlightColor: SpotifyColors.primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(50),
        onTap: () async {
          if(controller.currentSong.value.songId == song.songId){
            controller.isPlaying.value = false;
            await controller.player.value.stop();
          }
          await controller.deleteSong(songId: song.songId);
        },
        child: const Icon(Icons.remove,color: Colors.redAccent,size: 32,),

    );
  }
}
