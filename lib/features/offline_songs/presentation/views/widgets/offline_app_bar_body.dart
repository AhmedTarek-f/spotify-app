import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/common_widgets/song_common_widgets/songs_play_icon.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';

class OfflineAppBarBody extends StatelessWidget implements PreferredSizeWidget{
  const OfflineAppBarBody({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = OfflineSongsController.instance;
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
                child: Image.asset(
                  SpotifyImages.offlineBackground,
                  fit: BoxFit.cover,
                ),
              )
          ),
        ),
        const SizedBox(height: 22,),
        const Text("Offline Songs",style: SpotifyFonts.appStylesBold22,),
        const SizedBox(height: 12,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: MediaQuery.sizeOf(context).width*0.16,),
            SongsPlayIcon(
              onPressed: (){},
              icon: Icon(
                controller.isPlaying.value? Icons.pause :Icons.play_arrow,
                size: 28,
                color: isDarkMode?Colors.white:Colors.black,
              ),
            ),
            const SizedBox(width: 12,),
            IconButton(onPressed: (){}, icon: SvgPicture.asset(SpotifyImages.shuffleIcon,colorFilter: ColorFilter.mode(isDarkMode?Colors.white:Colors.black, BlendMode.srcIn),)),
          ],
        ),

      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
