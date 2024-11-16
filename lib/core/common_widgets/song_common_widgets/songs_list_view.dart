import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_item.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class SongsListView extends StatelessWidget {
  const SongsListView({super.key});
  final List<SongModel> favoriteSongsList = const [
    SongModel(songImage: SpotifyImages.album1, songTitle: "Don't Smile At Me", songAuthor: "Billie Eilish", songLength: "5:33", playlistId: '', songId: ''),
    SongModel(songImage: SpotifyImages.album2, songTitle: "WildFlower", songAuthor: "Billie Eilish", songLength: "5:33", playlistId: '', songId: ''),
    SongModel(songImage: SpotifyImages.song1, songTitle: "As It Was", songAuthor: "Harry Styles", songLength: "5:33", playlistId: '', songId: ''),
    SongModel(songImage: SpotifyImages.song2, songTitle: "Bad Habit", songAuthor: "Steve Lacy", songLength: "5:33", playlistId: '', songId: ''),
    SongModel(songImage: SpotifyImages.song3, songTitle: "Planet Her", songAuthor: "Doja Cat", songLength: "5:33", playlistId: '', songId: ''),
    SongModel(songImage: SpotifyImages.song4, songTitle: "Sweetest Pie", songAuthor: "Megan Thee Stallion", songLength: "5:33", playlistId: '', songId: ''),
    SongModel(songImage: SpotifyImages.album1, songTitle: "Don't Smile At Me", songAuthor: "Billie Eilish", songLength: "5:33", playlistId: '', songId: ''),
    SongModel(songImage: SpotifyImages.album2, songTitle: "WildFlower", songAuthor: "Billie Eilish", songLength: "5:33", playlistId: '', songId: ''),
    SongModel(songImage: SpotifyImages.song1, songTitle: "As It Was", songAuthor: "Harry Styles", songLength: "5:33", playlistId: '', songId: ''),
    SongModel(songImage: SpotifyImages.song2, songTitle: "Bad Habit", songAuthor: "Steve Lacy", songLength: "5:33", playlistId: '', songId: ''),
    SongModel(songImage: SpotifyImages.song3, songTitle: "Planet Her", songAuthor: "Doja Cat", songLength: "5:33", playlistId: '', songId: ''),
    SongModel(songImage: SpotifyImages.song4, songTitle: "Sweetest Pie", songAuthor: "Megan Thee Stallion", songLength: "5:33", playlistId: '', songId: ''),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, index) => SongItem(songDetails: favoriteSongsList[index],isNetworkImage: false,),
        separatorBuilder: (_, __) => const SizedBox(height: 12,),
        itemCount: favoriteSongsList.length
    );
  }
}
