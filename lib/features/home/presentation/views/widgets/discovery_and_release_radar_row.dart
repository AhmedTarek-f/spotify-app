import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/views/widgets/songs_collection_container.dart';

class DiscoveryAndReleaseRadarRow extends StatelessWidget {
  const DiscoveryAndReleaseRadarRow({super.key});
  final SongsCollectionModel discoveryCollection = const SongsCollectionModel(collectionImg: SpotifyImages.album1, collectionTitle: "Discover Weekly");
  final SongsCollectionModel releaseRadarCollection = const SongsCollectionModel(collectionImg: SpotifyImages.album2, collectionTitle: "Release Radar");
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SongsCollectionContainer(songsCollection: discoveryCollection,),
        SongsCollectionContainer(songsCollection: releaseRadarCollection,),
      ],
    );
  }
}