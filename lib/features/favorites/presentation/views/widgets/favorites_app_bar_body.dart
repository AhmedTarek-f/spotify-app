import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_play_icon.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';

class FavoritesAppBarBody extends StatelessWidget implements PreferredSizeWidget{
  const FavoritesAppBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.sizeOf(context).width*0.16,),
        SongsPlayIcon(
          onPressed: ()async{
            await controller.toggleFavIsPlaying();
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
            await controller.toggleShuffle();
          },
          icon: Obx(
                ()=> SvgPicture.asset(SpotifyImages.shuffleIcon,colorFilter: ColorFilter.mode(
                controller.isShuffling.value? SpotifyColors.primaryColor:(isDarkMode?const Color(0xff6D6D6D) :const Color(0xff7E7E7E)), BlendMode.srcIn
            ),
            ),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
