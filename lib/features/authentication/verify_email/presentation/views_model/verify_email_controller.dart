import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/success_screen.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/core/utlis/services/auth_services/additional_auth_services/additional_auth_services.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';

class VerifyEmailController extends GetxController
{
  static VerifyEmailController get instance => Get.find();

  // Send Email When ever Verify Screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();

  }

  // Send Email Verification link
 Future<void> sendEmailVerification()async{
    try{
      await AdditionalAuthServices.sendEmailVerification();
      Loaders.successSnackBar(title: "Email Sent",message: "Please check your inbox and verify your email.");
    }
    catch(e)
   {
     Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
   }
  }

  // Timer to automatically redirect on Email Verification
  Future<void> setTimerForAutoRedirect() async
  {
    Timer.periodic(
        const Duration(seconds: 1),
        (timer) async{
          await FirebaseAuth.instance.currentUser?.reload();
          final user = FirebaseAuth.instance.currentUser;
          if(user?.emailVerified ?? false)
            {
              timer.cancel();
              Get.off(()=>SuccessScreen(
                isAnimation: true,
                image: SpotifyImages.successfullyRegisterAnimation,
                title:"Your account successfully created!",
                subTitle: "Welcome to Your Ultimate Music Destination Your Account is Created",
                onPressed: () async{
                  await AuthenticationRepository.instance.screenRedirect();
                  Get.offAll(()=> AuthenticationRepository.instance.redirectedScreen);
                }
              )
              );
            }
        },
    );
  }
  // Manually check if email verified
  Future<void> checkEmailVerificationStatus() async{
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser!=null && currentUser.emailVerified)
    {
      Get.off(()=>SuccessScreen(
        isAnimation: true,
        image: SpotifyImages.successfullyRegisterAnimation,
        title:"Your account created",
        subTitle: "",
        onPressed: () async{
          await AuthenticationRepository.instance.screenRedirect();
          Get.offAll(()=> AuthenticationRepository.instance.redirectedScreen);
        }
      )
      );
    }
  }

}