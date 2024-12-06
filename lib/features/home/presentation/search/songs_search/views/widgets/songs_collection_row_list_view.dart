import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/search/views/songs_search/widgets/song_collection_row_item.dart';

class SongsCollectionRowListView extends StatelessWidget {
  const SongsCollectionRowListView({super.key, required this.createdPlaylists});
  final List<SongsCollectionModel> createdPlaylists;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.sizeOf(context).width*0.7,
      height: createdPlaylists.isEmpty? MediaQuery.sizeOf(context).height*0.1 :MediaQuery.sizeOf(context).height*0.2,
      child: createdPlaylists.isEmpty?
      const Center(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: Text("You haven't created any playlist yet! let's create one.",style: SpotifyFonts.appStylesMedium17,overflow: TextOverflow.visible,),
      ))
          :ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => SongCollectionRowItem(playlist: createdPlaylists[index], index: index,),
        separatorBuilder: (_, __) => const SizedBox(height: 8,),
        itemCount: createdPlaylists.length,
      ),
    );
  }
}
