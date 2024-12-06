import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/search/songs_search/views_model/songs_search_controller.dart';

class SongCollectionRowItem extends StatelessWidget {
  const SongCollectionRowItem({super.key, required this.playlist, required this.index,});
  final SongsCollectionModel playlist;
  final int index;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = SongsSearchController.instance;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: (){
          controller.activeSelectedSong.value = index;
        },
        borderRadius: BorderRadius.circular(12),
        splashColor: SpotifyColors.primaryColor.withOpacity(0.4),
        highlightColor: SpotifyColors.primaryColor.withOpacity(0.4),
        child: Obx(
              ()=> AnimatedContainer(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: controller.activeSelectedSong.value == index? SpotifyColors.primaryColor : Colors.blueGrey,
                      spreadRadius: 1,
                      blurRadius: controller.activeSelectedSong.value == index? 5 : 1,
                      blurStyle: BlurStyle.outer
                  )
                ]
            ),
            duration: const Duration(milliseconds: 300),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius:  BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 27.5,
                    backgroundColor: SpotifyColors.primaryColor,
                    child: CircleAvatar(
                      radius: 26.5,
                      backgroundColor: isDarkMode?const Color(0xff131016):const Color(0xffFEF5FF),
                      backgroundImage: CachedNetworkImageProvider(playlist.collectionImg),
                    ),
                  ),
                  const SizedBox(width: 12,),
                  Expanded(child: Text(playlist.collectionTitle, style: SpotifyFonts.appStylesMedium17,maxLines: 2,)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
