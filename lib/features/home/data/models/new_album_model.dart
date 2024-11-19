import 'package:cloud_firestore/cloud_firestore.dart';

class NewAlbumModel {
  const NewAlbumModel({
    required this.albumTitle,
    required this.albumImgUrl,
    required this.authorName,
    required this.playlistId,
  });

  final String albumTitle;
  final String albumImgUrl;
  final String authorName;
  final String playlistId;

  static NewAlbumModel empty() => const NewAlbumModel(albumTitle: "", albumImgUrl: "", authorName: "", playlistId: "");

  Map<String,dynamic> toJson() {
    return {
      "AlbumTitle":albumTitle ,
      "AlbumImgUrl":albumImgUrl,
      "AuthorName":authorName,
      "PlaylistId":playlistId,
    };
  }

  factory NewAlbumModel.fromSnapshot(DocumentSnapshot<Map<String ,dynamic>> document) {
    if(document.data() != null) {
      final snapshot = document.data()!;
      return NewAlbumModel(
          albumTitle: snapshot["AlbumTitle"] as String,
          albumImgUrl: snapshot["AlbumImgUrl"] as String,
          authorName: snapshot["AuthorName"] as String,
          playlistId: snapshot["PlaylistId"] as String,
      );
    }
    else {
      return empty();
    }
  }

}