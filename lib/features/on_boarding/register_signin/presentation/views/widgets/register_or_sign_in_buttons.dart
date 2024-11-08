import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/spotify_custom_button.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/authentication/register/presentation/views/register_view.dart';
import 'package:spotify/features/authentication/sign_in/presentation/views/sign_in_view.dart';

class RegisterOrSignInButtons extends StatelessWidget {
  const RegisterOrSignInButtons({super.key,});


  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: SpotifyCustomButton(
            onPressed: (){
              Get.offAll(
                () => const RegisterView(),
                transition: Transition.leftToRightWithFade,
                duration: const Duration(milliseconds: 500),
              );
            },
            buttonTitle: "Register",
            height: MediaQuery.sizeOf(context).height*0.08649,
            titleStyle: SpotifyFonts.appStylesMedium19.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(width: 34,),
        Expanded(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height*0.08649,
            child: TextButton(
              onPressed: (){
                Get.offAll(
                      () => const SignInView(),
                  transition: Transition.leftToRightWithFade,
                  duration: const Duration(milliseconds: 500),
                );
              },
              style: TextButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text("Sign in",style: SpotifyFonts.appStylesMedium19.copyWith(color: isDarkMode? const Color(0xffD7D7D7) : const Color(0xff313131)),),
            ),
          ),

        ),
      ],
    );
  }
}