import 'package:cloud_firestore/cloud_firestore.dart';

class SongsCollectionModel {

  const SongsCollectionModel({
    required this.id,
    required this.collectionImg,
    required this.collectionTitle,
    this.createdBy,
  });
  final String id;
  final String collectionImg;
  final String collectionTitle;
  final String? createdBy;

  static SongsCollectionModel empty() => const SongsCollectionModel(id: "", collectionImg: "", collectionTitle: "");

  Map<String,dynamic> toJson() {
    return {
      "Image":collectionImg,
      "Name":collectionTitle,
      "CreatedBy":createdBy,
    };
  }

  factory SongsCollectionModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    if(document.data() != null){
      final snapshot = document.data()!;
      return SongsCollectionModel(
          id: document.id,
          collectionImg: snapshot["Image"] as String,
          collectionTitle: snapshot["Name"] as String,
          createdBy: snapshot["CreatedBy"] as String?,
      );
    }
    else{
      return empty();
    }
  }

}
