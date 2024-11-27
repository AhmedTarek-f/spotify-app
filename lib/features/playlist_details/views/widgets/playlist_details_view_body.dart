import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/back_arrow.dart';
import 'package:spotify/core/common_widgets/containers/updating_container/updating_container.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/playlist_details/views/widgets/app_bar_body.dart';
import 'package:spotify/features/playlist_details/views/widgets/playlist_songs_list_view.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class PlaylistDetailsViewBody extends StatelessWidget {
  const PlaylistDetailsViewBody({super.key, required this.playlist,});
  final SongsCollectionModel playlist;
  @override
  Widget build(BuildContext context) {
    final controller = PlaylistDetailsController.instance;
    return Stack(
      children: [
        Obx(
          ()=> AbsorbPointer(
            absorbing: controller.isDeletingPlaylist.value,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: ((playlist.createdBy?.isNotEmpty ?? false) && playlist.createdBy != null)? MediaQuery.sizeOf(context).height*0.45 :MediaQuery.sizeOf(context).height*0.43,
                  toolbarHeight: ((playlist.createdBy?.isNotEmpty ?? false) && playlist.createdBy != null)? MediaQuery.sizeOf(context).height*0.45:MediaQuery.sizeOf(context).height*0.43,
                  leading: const BackArrow(),
                  actions: [
                    if(controller.checkPlaylistCreator()) PopupMenuButton<String>(
                      offset: const Offset(0, 40),
                      onSelected: (value) async{
                        if (value == "removePlaylist"){
                          await controller.deleteCreatedPlaylist(playlist: playlist);
                          if(!controller.isDeletingPlaylist.value) Get.back();
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'removePlaylist',
                          child: Row(
                            children: [
                              Icon(Icons.remove, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete Playlist'),
                            ],
                          ),
                        )
                      ],
                      icon:  SvgPicture.asset(SpotifyImages.threeDotsIcon),
                    ),
                  ],
                  bottom: AppBarBody(playlist: playlist,),
                  centerTitle: true,
                ),
              ],
              body: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: PlaylistSongsListView(),
              ),
            ),
          ),
        ),
        Obx(()=>controller.isDeletingPlaylist.value? const UpdatingContainer(containerTitle: "Deleting playlist"): const SizedBox.shrink()),
      ],
    );
  }
}

