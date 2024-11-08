import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/common_widgets/back_arrow.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/on_boarding/register_signin/presentation/views/widgets/register_or_sign_in_buttons.dart';

class RegisterSignInViewBody extends StatelessWidget {
  const RegisterSignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark; 
    return Stack(
      children: [
        Positioned(
          bottom: 0,
            left: 0,
            child: Image.asset(SpotifyImages.onBoarding3),
        ),
        Positioned(
          bottom: 0,
            right: 0,
            child: Image.asset(SpotifyImages.onBoarding3BottomSlashes)
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Image.asset(SpotifyImages.onBoarding3TopSlashes)
        ),
        Positioned(
            top: MediaQuery.sizeOf(context).height*0.04265,
            left: MediaQuery.sizeOf(context).width*0.0769,
            child: const BackArrow(),
        ),
        Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height*0.20734,),
            SvgPicture.asset(
                SpotifyImages.spotifyLogoSVG,
              width: MediaQuery.sizeOf(context).width*0.60256,
              height: MediaQuery.sizeOf(context).height*0.08412,
            ),
            const SizedBox(height: 55,),
            const Text("Enjoy Listening To Music",style: SpotifyFonts.appStylesBold26,),
            const SizedBox(height: 21,),
            Text("Spotify is a proprietary Swedish audio\n streaming and media services provider",style: SpotifyFonts.appStylesRegular17.copyWith(color: isDarkMode ? const Color(0xffA0A0A0) : const Color(0xff797979)),),
            const SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07692),
              child: const RegisterOrSignInButtons(),
            ),
          ],
        )
      ],
    );
  }
}


