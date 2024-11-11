import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/favorites/data/favorite_song_details_model.dart';
import 'package:spotify/features/favorites/presentation/views/widgets/favorite_song_item.dart';

class FavoriteSongsListView extends StatelessWidget {
  const FavoriteSongsListView({super.key});
  final List<FavoriteSongDetailsModel> favoriteSongsList = const [
    FavoriteSongDetailsModel(songImage: SpotifyImages.album1, songTitle: "Don't Smile At Me", songAuthor: "Billie Eilish", songLength: "5:33"),
    FavoriteSongDetailsModel(songImage: SpotifyImages.album2, songTitle: "WildFlower", songAuthor: "Billie Eilish", songLength: "5:33"),
    FavoriteSongDetailsModel(songImage: SpotifyImages.song1, songTitle: "As It Was", songAuthor: "Harry Styles", songLength: "5:33"),
    FavoriteSongDetailsModel(songImage: SpotifyImages.song2, songTitle: "Bad Habit", songAuthor: "Steve Lacy", songLength: "5:33"),
    FavoriteSongDetailsModel(songImage: SpotifyImages.song3, songTitle: "Planet Her", songAuthor: "Doja Cat", songLength: "5:33"),
    FavoriteSongDetailsModel(songImage: SpotifyImages.song4, songTitle: "Sweetest Pie", songAuthor: "Megan Thee Stallion", songLength: "5:33"),
    FavoriteSongDetailsModel(songImage: SpotifyImages.album1, songTitle: "Don't Smile At Me", songAuthor: "Billie Eilish", songLength: "5:33"),
    FavoriteSongDetailsModel(songImage: SpotifyImages.album2, songTitle: "WildFlower", songAuthor: "Billie Eilish", songLength: "5:33"),
    FavoriteSongDetailsModel(songImage: SpotifyImages.song1, songTitle: "As It Was", songAuthor: "Harry Styles", songLength: "5:33"),
    FavoriteSongDetailsModel(songImage: SpotifyImages.song2, songTitle: "Bad Habit", songAuthor: "Steve Lacy", songLength: "5:33"),
    FavoriteSongDetailsModel(songImage: SpotifyImages.song3, songTitle: "Planet Her", songAuthor: "Doja Cat", songLength: "5:33"),
    FavoriteSongDetailsModel(songImage: SpotifyImages.song4, songTitle: "Sweetest Pie", songAuthor: "Megan Thee Stallion", songLength: "5:33"),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, index) => FavoriteSongItem(favoriteSongDetails: favoriteSongsList[index],),
        separatorBuilder: (_, __) => const SizedBox(height: 12,),
        itemCount: favoriteSongsList.length
    );
  }
}
