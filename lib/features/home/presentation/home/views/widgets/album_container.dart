
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/home/data/models/new_album_model.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/playlist_details/views/playlist_details_view.dart';

class AlbumContainer extends StatelessWidget {
  const AlbumContainer({super.key, required this.newAlbum});

  final NewAlbumModel newAlbum;

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return GestureDetector(
      onTap: (){
        Get.to(()=> PlaylistDetailsView(playlist: controller.songsPlaylists.firstWhere((playlist)=> playlist.id == newAlbum.playlistId)),
            arguments: {"playlist":controller.songsPlaylists.firstWhere((playlist)=> playlist.id == newAlbum.playlistId)}
        );

      },
      child: Container(
        padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.05688,top: 14),
        width: MediaQuery.sizeOf(context).width*0.8564,
        height: MediaQuery.sizeOf(context).height*0.1398,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: SpotifyColors.primaryColor,
        ),
        child: Stack(
            clipBehavior: Clip.none,
            children:[
              Positioned(
                bottom: 0,
                left: -20,
                child: CachedNetworkImage(
                    imageUrl: newAlbum.albumImgUrl,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child:  Image.asset(SpotifyImages.homeAlbumSlashes),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width*0.4038,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("New Album",style: SpotifyFonts.appStylesMedium10.copyWith(color: Colors.white),),
                    Text(newAlbum.albumTitle,style:  SpotifyFonts.appStylesBold19.copyWith(color: Colors.white), maxLines: 2,),
                    Text(newAlbum.authorName,style:  SpotifyFonts.appStylesMedium13.copyWith(color: Colors.white),),
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }
}