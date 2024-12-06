import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';

class PlaylistDetailsBottomNav extends StatelessWidget {
  const PlaylistDetailsBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PlaylistDetailsController.instance;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.1),
      height: MediaQuery.sizeOf(context).height*0.07,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width*0.1,
                height: MediaQuery.sizeOf(context).height*0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child:Obx(
                          ()=> CachedNetworkImage(
                        imageUrl: controller.currentSong.value.songImage ,fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) => ShimmerEffect(width: MediaQuery.sizeOf(context).width*0.1, height: MediaQuery.sizeOf(context).height*0.05),
                        errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                      ),
                    )

                ),
              ),
              const SizedBox(width: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                            ()=> Text(
                          controller.currentSong.value.songTitle,

                          style: SpotifyFonts.appStylesBold13,
                        ),
                      ),
                      Obx(
                            ()=> Text(
                          controller.currentSong.value.songAuthor,
                          style: SpotifyFonts.appStylesRegular12.copyWith(color:isDarkMode? const Color(0xffBABABA): const Color(0xff404040) ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.06),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async => await controller.playPreviousSong(),
                  child: SvgPicture.asset(
                    SpotifyImages.previousIcon,
                    colorFilter: ColorFilter.mode(
                      isDarkMode ? const Color(0xffA7A7A7) : const Color(0xff363636),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                GestureDetector(
                  onTap: () async {
                    await controller.toggleIsPlaying();
                  },
                  child: Obx(()=> Icon( controller.isPlaying.value? Icons.pause : Icons.play_arrow,color: isDarkMode ? const Color(0xffA7A7A7) : const Color(0xff363636),)),
                ),
                const SizedBox(width: 8,),
                GestureDetector(
                  onTap: () async => await controller.playNextSong(),
                  child: SvgPicture.asset(
                    SpotifyImages.nextIcon,
                    colorFilter: ColorFilter.mode(
                      isDarkMode ? const Color(0xffA7A7A7) : const Color(0xff363636),
                      BlendMode.srcIn,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}