import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/or_divider.dart';
import 'package:spotify/core/common_widgets/social_buttons.dart';
import 'package:spotify/core/common_widgets/two_text_one_clickable.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/authentication/register/presentation/views/register_view.dart';
import 'package:spotify/features/authentication/sign_in/presentation/views/widgets/sign_in_form.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height*0.09478,),
          const Center(child:Text("Sign In",style: SpotifyFonts.appStylesBold30,)),
          const SizedBox(height: 22,),
          TwoTextOneClickable(
            firstPart: const Text("If You Need Any Support ",style: SpotifyFonts.appStylesRegular12,),
            secondClickablePart: Text("Click Here",style: SpotifyFonts.appStylesRegular12.copyWith(color: SpotifyColors.primaryColor),),
            onClicked: (){},
          ),
          const SizedBox(height: 38,),
          const SignInForm(),
          const SizedBox(height: 31,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.08461),
            child: const OrDivider(),
          ),
          const SizedBox(height: 44,),
          SocialButtons(
            googleOnPressed: (){},
            appleOnPressed: (){},
          ),
          const SizedBox(height: 57,),
          TwoTextOneClickable(
            firstPart: const Text("Not A Member ? ",style: SpotifyFonts.appStylesMedium14,),
            secondClickablePart: Text(" Register Now",style: SpotifyFonts.appStylesMedium14.copyWith(color: const Color(0xff288CE9)),),
            onClickedSplashColor: const Color(0xff288CE9).withOpacity(0.5),
            onClickedHighlightColor: const Color(0xff288CE9).withOpacity(0.2),
            onClicked: (){
              Get.off(
                ()=> const RegisterView(),
                transition: Transition.leftToRightWithFade,
                duration: const Duration(milliseconds: 500),
              );
            },
          ),
        ],
      ),
    );
  }
}