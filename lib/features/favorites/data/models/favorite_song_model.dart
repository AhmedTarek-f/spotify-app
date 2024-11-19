import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteSongModel{
  const FavoriteSongModel({required this.songId});
  final String songId;

  static FavoriteSongModel empty() => const FavoriteSongModel(songId: "");

  factory FavoriteSongModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    if(document.data() != null) {
      final snapshot = document.data()!;
      return FavoriteSongModel(
          songId: snapshot["SongId"] as String,
      );
    }
    else{
      return empty();
    }
  }
}