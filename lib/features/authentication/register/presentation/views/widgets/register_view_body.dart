import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/or_divider.dart';
import 'package:spotify/core/common_widgets/social_buttons.dart';
import 'package:spotify/core/common_widgets/two_text_one_clickable.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/authentication/register/presentation/views/widgets/register_form.dart';
import 'package:spotify/features/authentication/register/presentation/views_model/register_controller.dart';
import 'package:spotify/features/authentication/sign_in/presentation/views/sign_in_view.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height*0.05568,),
          const Center(child:Text("Register",style: SpotifyFonts.appStylesBold30,)),
          const SizedBox(height: 22,),
          TwoTextOneClickable(
            firstPart: const Text("If You Need Any Support ",style: SpotifyFonts.appStylesRegular12,),
            secondClickablePart: Text("Click Here",style: SpotifyFonts.appStylesRegular12.copyWith(color: SpotifyColors.primaryColor),),
            onClicked: (){},
          ),
          const SizedBox(height: 26,),
          const RegisterForm(),
          const SizedBox(height: 39,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.08461),
            child: const OrDivider(),
          ),
          const SizedBox(height: 44,),
          SocialButtons(
            googleOnPressed: ()async{
              await registerController.signUpWithGoogle(context: context);
            },
          ),
          const SizedBox(height: 44,),
          TwoTextOneClickable(
            firstPart: const Text("Do You Have An Account? ",style: SpotifyFonts.appStylesMedium14,),
            secondClickablePart: Text("Sign In",style: SpotifyFonts.appStylesMedium14.copyWith(color: const Color(0xff288CE9)),),
            onClickedSplashColor: const Color(0xff288CE9).withOpacity(0.5),
            onClickedHighlightColor: const Color(0xff288CE9).withOpacity(0.2),
            onClicked: (){
              Get.off(
                ()=> const SignInView(),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 500),
              );
            },
          ),
        ],
      ),
    );
  }
}
