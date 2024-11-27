import 'package:cloud_firestore/cloud_firestore.dart';

class SongsCollectionModel {

   SongsCollectionModel({
    required this.id,
    required this.collectionImg,
    required this.collectionTitle,
    this.createdBy,
     this.lastPlayedAt,
    this.listOfSongsIds,
  });

   final String id;
   final String collectionImg;
   final String collectionTitle;
   final String? createdBy;
   final String? lastPlayedAt;
   List<String>? listOfSongsIds;


  static SongsCollectionModel empty() =>  SongsCollectionModel(id: "", collectionImg: "", collectionTitle: "");

  Map<String,dynamic> toJson() {
    return {
      "Id":id,
      "Image":collectionImg,
      "Name":collectionTitle,
      "CreatedBy":createdBy,
      'lastPlayedAt': lastPlayedAt,
      "ListOfSongsIds": listOfSongsIds != null ? List<String>.from(listOfSongsIds!) : [],
    };
  }

  factory SongsCollectionModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    if(document.data() != null){
      final snapshot = document.data()!;
      return SongsCollectionModel(
          id: (snapshot["Id"] ?? document.id) as String,
          collectionImg: snapshot["Image"] as String,
          collectionTitle: snapshot["Name"] as String,
          createdBy: snapshot["CreatedBy"] as String?,
          lastPlayedAt: snapshot["lastPlayedAt"]as String?,
          listOfSongsIds:snapshot["ListOfSongsIds"] != null ? List<String>.from(snapshot["ListOfSongsIds"]) :[],
      );
    }
    else{
      return empty();
    }
  }

}
