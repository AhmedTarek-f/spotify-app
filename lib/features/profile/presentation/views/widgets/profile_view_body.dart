import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/favorites/presentation/views/widgets/favorite_songs_list_view.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.only(bottomRight:Radius.circular(70) ,bottomLeft: Radius.circular(70))
          ),
          child:  Column(
            children: [
              const SizedBox(height: 10,),
              const Center(
                child:  CircleAvatar(
                  radius: 47,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 46.5,
                    backgroundImage: AssetImage(SpotifyImages.profilePic,),
                  ),
                ),
              ),
              const SizedBox(height: 11,),
              Text("o0ahmedtarek@gmail.com",style: SpotifyFonts.appStylesRegular12.copyWith(color: isDarkMode ? const Color(0xffD8D4D4):const Color(0xff222222)),),
              const SizedBox(height: 12,),
              const Text("ahmedtarek",style: SpotifyFonts.appStylesBold20,),
              const SizedBox(height: 18,),
               Row(
                 mainAxisSize: MainAxisSize.min,
                children: [
                  const Column(
                    children: [
                      Text("234",style: SpotifyFonts.appStylesBold20),
                      Text("Follows",style: SpotifyFonts.appStylesRegular14)
                    ],
                  ),
                  SizedBox(width: MediaQuery.sizeOf(context).width*0.3153,),
                  const Column(
                    children: [
                      Text("778",style: SpotifyFonts.appStylesBold20),
                      Text("Followers",style: SpotifyFonts.appStylesRegular14)
                    ],
                  )
                ],
              ),
              const SizedBox(height: 21,),
            ],
          ),
        ),
    const SizedBox(height: 19,),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
      child: const Text("Public Songs",style: SpotifyFonts.appStylesBold15,),
    ),
    const SizedBox(height: 17,),
    Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
          child: const FavoriteSongsListView(),
        ),
    ),

      ],
    );
  }
}
