import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/spotify_custom_button.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/on_boarding/choose_mode/presentation/views/widgets/light_or_dark_mode_choice.dart';
import 'package:spotify/features/on_boarding/register_signin/presentation/views/register_sign_in_view.dart';

class ChooseModeViewBody extends StatelessWidget {
  const ChooseModeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
                SpotifyImages.onBoarding2,
              fit: BoxFit.cover,
            ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height*0.0438,),
            SvgPicture.asset(SpotifyImages.spotifyLogoSVG),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.4028,),
            Text("Choose Mode",style: SpotifyFonts.appStylesBold22.copyWith(color: const Color(0xffDADADA)),),
            const SizedBox(height: 32,),
            const LightOrDarkModeChoice(),
            const SizedBox(height: 68,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.0769),
              child: SpotifyCustomButton(
                onPressed: (){
                  Get.to(
                    ()=> const RegisterSignInView(),
                    transition: Transition.leftToRightWithFade,
                    duration: const Duration(milliseconds: 500)
                  );
                },
                buttonTitle: "Continue",
              ),
            ),
          ],
        ),
      ],
    );
  }
}



