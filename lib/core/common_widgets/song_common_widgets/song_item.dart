import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_item_image.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/song_on_pressed_logic.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/playlist_details/views/widgets/download_song_button.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/single_song_details/presentation/views/single_song_details_view.dart';


class SongItem extends StatelessWidget {
  const SongItem({
    super.key,
    required this.songDetails,
    this.threeDotsWidget,
    this.isThreeDotsWidgetUsed = true,
    required this.playlistSongs,
    required this.index,
    this.isNetworkImage = true,
    required this.isOffline,
    this.isPlaying = false,
    this.isSingleSong = false,
  });
  final SongModel songDetails;
  final Widget? threeDotsWidget;
  final bool isThreeDotsWidgetUsed;
  final List<SongModel> playlistSongs;
  final int index;
  final bool isNetworkImage;
  final bool isOffline;
  final bool isPlaying;
  final bool isSingleSong;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        if(isSingleSong){
          FocusScope.of(context).unfocus();
          HomeController.instance.songsListPlaying.clear();
          Get.to(
            () => const SingleSongDetailsView(),
            arguments: {"songDetails":songDetails}
          );
        }
        else{
          await songOnPressedLogic(playlistSongs:playlistSongs ,index:index ,isOffline: isOffline,songDetails: songDetails);
        }
      },
      splashColor: SpotifyColors.primaryColor.withOpacity(0.3),
      highlightColor: SpotifyColors.primaryColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color:isPlaying? SpotifyColors.primaryColor :SpotifyColors.primaryColor.withOpacity(0.7),
              blurRadius: isPlaying? 10:5,
              spreadRadius: 1,
              blurStyle: BlurStyle.outer
            ),
          ]
        ),
        child: Row(
          children: [
            SongItemImage(image: songDetails.songImage,isNetworkImage: isNetworkImage,),
            const SizedBox(width: 20,),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(songDetails.songTitle,style: isPlaying? SpotifyFonts.appStylesBold16.copyWith(color: SpotifyColors.primaryColor.withOpacity(0.8)) :SpotifyFonts.appStylesBold16,maxLines: 1,),
                  Text(songDetails.songAuthor,style: isPlaying? SpotifyFonts.appStylesRegular12.copyWith(color: SpotifyColors.primaryColor.withOpacity(0.8)): SpotifyFonts.appStylesRegular12,maxLines: 1,),
                ],
              ),
            ),
            Expanded(
              flex: isThreeDotsWidgetUsed?2:1,
              child: Row(
                  children: [
                    Expanded(child: Text(songDetails.songLength,style: SpotifyFonts.appStylesRegular15,)),
                    if(Get.isRegistered<PlaylistDetailsController>())Obx(
                      ()=>(PlaylistDetailsController.instance.isDownloadingProcess.value && PlaylistDetailsController.instance.downloadingSongId == songDetails.songId)?
                      Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: DownloadSongButton(song: songDetails,),
                    ):
                      PlaylistDetailsController.instance.isDownloadingProcess.value?
                      InkWell(
                        onTap: (){
                          Loaders.warningSnackBar(title: "Note!",message: "There is a song in the downloading process, please wait for a few seconds ...");
                        },
                        child: AbsorbPointer(
                          absorbing: true,
                          child: Expanded(
                            child: DownloadSongButton(song: songDetails,),
                          ),
                        ),
                      )
                      :Expanded(
                      child: DownloadSongButton(song: songDetails,),
                    ),
                    ) ,
                    (isThreeDotsWidgetUsed && Get.isRegistered<PlaylistDetailsController>())?
                    Obx(
                      ()=>(Get.isRegistered<PlaylistDetailsController>() && PlaylistDetailsController.instance.isDeletingSongLoading.value && PlaylistDetailsController.instance.deletedSongName == songDetails.songTitle)?
                      threeDotsWidget!:
                      Expanded(child: threeDotsWidget!)
                    ) :
                   isThreeDotsWidgetUsed? Expanded(child: threeDotsWidget!) : const SizedBox.shrink(),
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
