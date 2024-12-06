import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_play_icon.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/search/songs_search/views/songs_search_view.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class AppBarBody extends StatelessWidget implements PreferredSizeWidget{
  const AppBarBody({super.key, required this.playlist});
  final SongsCollectionModel playlist;
  @override
  Widget build(BuildContext context) {
    final controller = PlaylistDetailsController.instance;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: SpotifyColors.primaryColor.withOpacity(0.6),
                  spreadRadius: 3,
                  blurRadius: 10,
                ),
              ]
          ),
          child: Container(
              width: MediaQuery.sizeOf(context).width*0.6,
              height: MediaQuery.sizeOf(context).height*0.28,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  imageUrl: playlist.collectionImg,
                  fit: BoxFit.cover,
                ),
              )
          ),
        ),
        const SizedBox(height: 22,),
        Text(playlist.collectionTitle,style: SpotifyFonts.appStylesBold22,),
        const SizedBox(height: 8,),
        if((playlist.createdBy?.isNotEmpty ?? false) && playlist.createdBy != null) Text("Created by: ${playlist.createdBy!}",style: SpotifyFonts.appStylesBold13,),
        const SizedBox(height: 12,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(controller.checkPlaylistCreator()) IconButton(
              onPressed: (){Get.to(()=>const SongsSearchView());},
              icon: const Icon(Icons.playlist_add),
            ),
            if(controller.checkPlaylistCreator())  const SizedBox(width: 12,),
            if(!controller.checkPlaylistCreator()) SizedBox(width: MediaQuery.sizeOf(context).width*0.16,),
            SongsPlayIcon(
              onPressed: ()async{
                if(controller.playlistSongs.isNotEmpty) await controller.toggleIsPlaying();
              },
              icon: Obx(
              ()=> Icon(
                  controller.isPlaying.value? Icons.pause :Icons.play_arrow,
                  size: 28,
                  color: isDarkMode?Colors.white:Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 12,),
            IconButton(
                onPressed: ()async{
                  if(controller.playlistSongs.isNotEmpty) await controller.toggleShuffle();
                  },
              icon: Obx(
                    ()=> SvgPicture.asset(SpotifyImages.shuffleIcon,colorFilter: ColorFilter.mode(
                    controller.isShuffling.value? SpotifyColors.primaryColor:(isDarkMode?const Color(0xff6D6D6D) :const Color(0xff7E7E7E)), BlendMode.srcIn
                ),
                ),
              ),
            )
          ],
        ),

      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
