import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/navigation_view/navigation_views.dart';
import 'package:spotify/core/common_widgets/spotify_custom_button.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/authentication/sign_in/presentation/views/widgets/sign_in_email_field.dart';
import 'package:spotify/features/authentication/sign_in/presentation/views/widgets/sign_in_password_field.dart';
import 'package:spotify/features/home/presentation/views/home_view.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.07179),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SignInEmailField(),
            const SizedBox(height: 16,),
            const SignInPasswordField(),
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.04358),
              child: const Text("Recovery Password", style: SpotifyFonts.appStylesMedium14,),
            ),
            const SizedBox(height: 22,),
            SpotifyCustomButton(
              buttonTitle: "Sign In",
              height: MediaQuery.sizeOf(context).height*0.09478,
              titleStyle: SpotifyFonts.appStylesBold20.copyWith(color: Colors.white),
              onPressed: (){
                Get.offAll(
                  ()=> const NavigationViews(),
                  transition: Transition.fade,
                  duration: const Duration(milliseconds: 500)
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



