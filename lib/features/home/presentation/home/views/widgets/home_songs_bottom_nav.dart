import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class HomeSongsBottomNav extends StatelessWidget {
  const HomeSongsBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
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
                        imageUrl:controller.currentSong.value.songImage,fit: BoxFit.cover,),
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
                  onTap: () async => await controller.songPlayer.value.seekToPrevious(),
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
                    await controller.songPlayer.value.stop();
                    controller.songsListPlaying.clear();
                  },
                  child: Icon(Icons.pause,color: isDarkMode ? const Color(0xffA7A7A7) : const Color(0xff363636),),
                ),
                const SizedBox(width: 8,),
                GestureDetector(
                  onTap: () async => await controller.songPlayer.value.seekToNext(),
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