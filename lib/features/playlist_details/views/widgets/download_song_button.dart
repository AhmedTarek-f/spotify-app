import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class DownloadSongButton extends StatelessWidget {
  const DownloadSongButton({
    super.key, required this.song,
  });
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    final controller = PlaylistDetailsController.instance;
    return InkWell(
        splashColor: SpotifyColors.primaryColor.withOpacity(0.4),
        highlightColor: SpotifyColors.primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(50),
        onTap: () async{
          if(!controller.checkIfSongDownloaded(songId: song.songId)) await controller.downloadAndSaveSong(song: song);
        },
        child: Obx(
          ()=> (controller.isDownloadingProcess.value && controller.downloadingSongId == song.songId)?
          const SizedBox(width: 16,height: 16, child: Center(child: CircularProgressIndicator(color:SpotifyColors.primaryColor,))):
          controller.checkIfSongDownloaded(songId: song.songId)? const Icon(Icons.download_done_outlined,color: SpotifyColors.primaryColor,) :const Icon(Icons.download_for_offline_outlined),
        )
    );
  }
}