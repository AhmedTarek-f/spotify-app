import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/views/widgets/songs_collection_container.dart';

class PlaylistsHorizontallyListView extends StatelessWidget {
  const PlaylistsHorizontallyListView({super.key});
  final List<SongsCollectionModel> songsPlaylists  = const [
    SongsCollectionModel(collectionImg: SpotifyImages.album1, collectionTitle: "Playlist1"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist2"),
    SongsCollectionModel(collectionImg: SpotifyImages.album1, collectionTitle: "Playlist3"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist4"),
    SongsCollectionModel(collectionImg: SpotifyImages.album1, collectionTitle: "Playlist5"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist6"),
    SongsCollectionModel(collectionImg: SpotifyImages.album1, collectionTitle: "Playlist7"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist8"),
    SongsCollectionModel(collectionImg: SpotifyImages.album1, collectionTitle: "Playlist9"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist10"),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.218,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => SongsCollectionContainer(songsCollection: songsPlaylists[index]),
          separatorBuilder: (_, __) => const SizedBox(width: 12,),
          itemCount: songsPlaylists.length
      ),
    );
  }
}