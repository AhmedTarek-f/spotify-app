import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/home/data/models/new_album_model.dart';
import 'package:spotify/features/home/presentation/views/widgets/album_container.dart';

class NewAlbumsListView extends StatelessWidget {
  const NewAlbumsListView({super.key});
  final List<NewAlbumModel> albumsList = const [
    NewAlbumModel(
      albumTitle: "Happier Than Ever",
      albumImgUrl: SpotifyImages.homeAlbum1,
      authorName: "Billie Eilish",
    ),
    NewAlbumModel(
      albumTitle: "Happier Than Ever",
      albumImgUrl: SpotifyImages.homeAlbum1,
      authorName: "Billie Eilish",
    ),
    NewAlbumModel(
      albumTitle: "Happier Than Ever",
      albumImgUrl: SpotifyImages.homeAlbum1,
      authorName: "Billie Eilish",
    ),
    NewAlbumModel(
      albumTitle: "Happier Than Ever",
      albumImgUrl: SpotifyImages.homeAlbum1,
      authorName: "Billie Eilish",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.1398,
      child: ListView.separated(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => AlbumContainer(newAlbum: albumsList[index],),
        separatorBuilder: (_, __) => const SizedBox(width: 12,),
        itemCount: albumsList.length,
      ),
    );
  }
}
