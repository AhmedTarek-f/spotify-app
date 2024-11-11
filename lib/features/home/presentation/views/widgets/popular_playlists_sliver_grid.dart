import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/views/widgets/expanded_songs_collection.dart';

class PopularPlaylistsSliverGrid extends StatelessWidget {
  const PopularPlaylistsSliverGrid({super.key});
  final List<SongsCollectionModel> songsCollectionList = const [
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist1"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist2"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist3"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist4"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist5"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist6"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist7"),
    SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Playlist8"),
  ];
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 16,
        mainAxisExtent: 200,
      ),
      delegate: SliverChildBuilderDelegate(
              (_, index) => ExpandedSongsCollectionContainer(songsCollection: songsCollectionList[index],),
          childCount: songsCollectionList.length
      ),

    );
  }
}
