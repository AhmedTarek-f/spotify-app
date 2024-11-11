class NewAlbumModel {
  const NewAlbumModel({
  required this.albumTitle,
  required this.albumImgUrl,
  required this.authorName,
  });

  final String albumTitle;
  final String albumImgUrl;
  final String authorName;

  Map<String,dynamic> toJson() {
    return {
      "AlbumTitle":albumTitle ,
      "AlbumImgUrl":albumImgUrl,
      "AuthorName":authorName,
    };
  }

}