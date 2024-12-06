import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/playlist_details/views/playlist_details_view.dart';

class ExpandedSongsCollectionContainer extends StatelessWidget {
  const ExpandedSongsCollectionContainer({super.key, required this.songsCollection});
  final SongsCollectionModel songsCollection;
  @override
  Widget build(BuildContext context) {
    final player = getIt.get<AudioPlayer>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              if(player.playing) player.stop();
              HomeController.instance.songsListPlaying.clear();
              Get.to(
                ()=> PlaylistDetailsView(playlist: songsCollection,),
                arguments: {"playlist":songsCollection}
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  imageUrl: songsCollection.collectionImg,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12,top: 4),
          child: SizedBox(width: MediaQuery.sizeOf(context).width*0.28, child: Text(songsCollection.collectionTitle, style: SpotifyFonts.appStylesBold13,)),
        ),
      ],
    );
  }
}