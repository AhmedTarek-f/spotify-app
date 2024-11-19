import 'package:cloud_firestore/cloud_firestore.dart';

class SongModel {
  const SongModel({
    required this.playlistId,
    required this.songId,
    required this.songImage,
    required this.songTitle,
    required this.songAuthor,
    required this.songLength,
    required this.songUrl,
  });

  final String playlistId;
  final String songId;
  final String songImage;
  final String songTitle;
  final String songAuthor;
  final String songLength;
  final String songUrl;

  static SongModel empty() => const SongModel(songId: "", playlistId: "", songImage: "", songTitle: "", songAuthor: "", songLength: "", songUrl: "");

  Map<String,dynamic> toJson() {
    return {
      "PlaylistId":playlistId,
      "SongImage":songImage,
      "SongTitle":songTitle,
      "SongAuthor":songAuthor,
      "SongLength":songLength,
      "SongUrl":songUrl,
    };
  }

  factory SongModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    if(document.data() != null){
      final Map<String,dynamic> snapshot = document.data()!;
      return SongModel(
          playlistId:snapshot["PlaylistId"] as String,
          songId: document.id,
          songImage:snapshot["SongImage"] as String,
          songTitle:snapshot["SongTitle"] as String,
          songAuthor:snapshot["SongAuthor"] as String,
          songLength:snapshot["SongLength"] as String,
          songUrl:snapshot["SongUrl"] as String,
      );
    }
    else{
      return empty();
    }
  }
}