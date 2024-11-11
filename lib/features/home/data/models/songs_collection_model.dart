class SongsCollectionModel {

  const SongsCollectionModel({
    required this.collectionImg,
    required this.collectionTitle,
  });

  final String collectionImg;
  final String collectionTitle;

  Map<String,dynamic> toJson() {
    return {
      "CollectionImg":collectionImg,
      "CollectionTitle":collectionTitle,
    };
  }
}
