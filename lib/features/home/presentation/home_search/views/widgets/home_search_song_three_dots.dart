import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/navigation_view/navigation_views.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/home_search/views/widgets/songs_collection_row_list_view.dart';
import 'package:spotify/features/home/presentation/home_search/views_model/home_search_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class HomeSearchSongThreeDots extends StatelessWidget {
  const HomeSearchSongThreeDots({super.key, required this.song,});
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    final controller = HomeSearchController.instance;
    return PopupMenuButton<String>(
      onSelected: (value) async{
        if (value == "addSongToPlaylist"){
          openPlaylistListChoices(createdPlaylists: controller.allCreatedPlaylists(),songItem:song,controller: controller);
        }

      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'addSongToPlaylist',
          child: Row(
            children: [
              Icon(Icons.add, color: SpotifyColors.primaryColor),
              SizedBox(width: 8),
              Text('Add to playlist'),
            ],
          ),
        )
      ],
      icon:  SvgPicture.asset(SpotifyImages.threeDotsHorizontallyIcon),
    );
  }

  void openPlaylistListChoices({
    required List<SongsCollectionModel> createdPlaylists,
    required SongModel songItem,
    required HomeSearchController controller,
  }) {
    Get.defaultDialog(
      barrierDismissible: controller.isAddingSongLoading.value,
      title: "Select From Your Created Playlists",
      titleStyle: SpotifyFonts.appStylesBold18,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SongsCollectionRowListView(createdPlaylists: createdPlaylists,),
        ],
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: SpotifyColors.primaryColor),
        onPressed: ()async{

          createdPlaylists.isEmpty? Get.offAll(()=>const NavigationViews()) :await controller.addSongToCreatedPlaylists(song: songItem);
        },
        child: Obx(
          ()=> controller.isAddingSongLoading.value?
          const SizedBox(width: 16,height: 16, child: CircularProgressIndicator(color: Colors.white,))
          :(createdPlaylists.isEmpty? Text("Create",style: SpotifyFonts.appStylesBold16.copyWith(color: Colors.white),) :Text("Add",style: SpotifyFonts.appStylesBold16.copyWith(color: Colors.white),))
        ),
      ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
        onPressed: (){
          Get.back();
        },
        child: Text("Cancel",style: SpotifyFonts.appStylesBold16.copyWith(color: Colors.white)),
      ),
    );
  }
}



