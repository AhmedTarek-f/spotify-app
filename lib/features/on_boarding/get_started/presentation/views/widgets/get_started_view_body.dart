import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/spotify_custom_button.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/on_boarding/choose_mode/presentation/views/choose_mode_view.dart';

class GetStartedViewBody extends StatelessWidget {
  const GetStartedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
              SpotifyImages.onBoarding1,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height*0.0438,),
            SvgPicture.asset(SpotifyImages.spotifyLogoSVG),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.4774,),
            Text("Enjoy Listening To Music",style: SpotifyFonts.appStylesBold25.copyWith(color: const Color(0xffDADADA)),),
            const SizedBox(height: 25,),
            Text(
              "Discover and stream your favorite tunes,\n create playlists, and explore new music.\n Your journey into endless melodies\n starts here.\n",
              style: SpotifyFonts.appStylesRegular17.copyWith(color: const Color(0xff797979),overflow: TextOverflow.visible),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 37,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.0769),
              child: SpotifyCustomButton(
                onPressed: (){
                  Get.off(()=> const ChooseModeView(),
                      transition: Transition.leftToRightWithFade,
                    duration: const Duration(milliseconds: 500)
                  );
                },
                buttonTitle: "Get Started",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
