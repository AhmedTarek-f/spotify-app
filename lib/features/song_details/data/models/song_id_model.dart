import 'package:cloud_firestore/cloud_firestore.dart';

class SongIdModel{
  const SongIdModel({
  required this.songId
  });
  final String songId;

  static SongIdModel empty() => const SongIdModel(songId: "");

  Map<String,dynamic> toJson() {
    return {
      "SongId":songId,
    };
  }

  factory SongIdModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    if(document.data() != null) {
      final snapshot = document.data()!;
      return SongIdModel(
        songId: snapshot["SongId"] as String,
      );
    }
    else{
      return empty();
    }
  }
}