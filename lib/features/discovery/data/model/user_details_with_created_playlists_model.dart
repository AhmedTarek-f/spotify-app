import 'package:spotify/features/home/data/models/songs_collection_model.dart';

class UserDetailsWithCreatedPlaylistsModel{
  UserDetailsWithCreatedPlaylistsModel({
    required this.id,
    required this.userName,
    required this.profileImg,
    required this.publicCreatedPlaylists,
  });
  final String id;
  final String userName;
  final String? profileImg;
  List<SongsCollectionModel> publicCreatedPlaylists;
}