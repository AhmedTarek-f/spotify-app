import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/core/utlis/popups/full_screen_loader.dart';
import 'package:spotify/core/utlis/services/auth_services/additional_auth_services/additional_auth_services.dart';

class ResetPasswordController extends GetxController
{
  static ResetPasswordController get instance => Get.find();


  Future<void> resendPasswordResetEmail({required String email , required BuildContext context}) async{
    try{
        FullScreenLoader.openLoadingDialog("Processing your request...", SpotifyImages.docerAnimation,context);
        await AdditionalAuthServices.sendPasswordResetEmail(email: email);
        FullScreenLoader.stopLoading();
        Loaders.successSnackBar(
          title: "Email Sent",
          message: "Email Link Sent to Reset your Password",
        );
    }
    catch(e)
    {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
        title: "Oh Snap!",
        message: e.toString(),
      );
    }

  }
}