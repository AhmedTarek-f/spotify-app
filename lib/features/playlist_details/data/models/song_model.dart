import 'package:cloud_firestore/cloud_firestore.dart';

class SongModel {
  const SongModel({
    required this.songId,
    required this.songImage,
    required this.songTitle,
    required this.songAuthor,
    required this.songLength,
    required this.songUrl,
    required this.lyrics
  });

  final String songId;
  final String songImage;
  final String songTitle;
  final String songAuthor;
  final String songLength;
  final String songUrl;
  final String lyrics;

  static SongModel empty() => const SongModel(songId: "", songImage: "", songTitle: "", songAuthor: "", songLength: "", songUrl: "", lyrics: '');

  Map<String,dynamic> toJson() {
    return {
      "SongImage":songImage,
      "SongTitle":songTitle,
      "SongAuthor":songAuthor,
      "SongLength":songLength,
      "SongUrl":songUrl,
      "Lyrics":lyrics,
    };
  }

  factory SongModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    if(document.data() != null){
      final Map<String,dynamic> snapshot = document.data()!;
      return SongModel(
          songId: document.id,
          songImage:snapshot["SongImage"] as String,
          songTitle:snapshot["SongTitle"] as String,
          songAuthor:snapshot["SongAuthor"] as String,
          songLength:snapshot["SongLength"] as String,
          songUrl:snapshot["SongUrl"] as String,
          lyrics:snapshot["Lyrics"] as String,
      );
    }
    else{
      return empty();
    }
  }
}