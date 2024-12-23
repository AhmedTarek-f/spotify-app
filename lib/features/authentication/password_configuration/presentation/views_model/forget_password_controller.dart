import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/core/utlis/popups/full_screen_loader.dart';
import 'package:spotify/core/utlis/services/auth_services/additional_auth_services/additional_auth_services.dart';
import 'package:spotify/features/authentication/password_configuration/presentation/views/reset_password_view.dart';

class ForgetPasswordController extends GetxController
{
  static ForgetPasswordController get instance => Get.find();

  GlobalKey<FormState> forgetPasswordKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  void applyAutoValidateMode()
  {
    autoValidateMode = AutovalidateMode.always;
    update();
  }
  void disableAutoValidateMode()
  {
    autoValidateMode = AutovalidateMode.disabled;
    update();
  }

  Future<void> sendPasswordResetEmail({required BuildContext context}) async{
    try{
      if(!forgetPasswordKey.currentState!.validate()){
        applyAutoValidateMode();
      }
      else{
        disableAutoValidateMode();
        FullScreenLoader.openLoadingDialog("Processing your request...", SpotifyImages.docerAnimation,context);
        await AdditionalAuthServices.sendPasswordResetEmail(email: email.text.trim());
        FullScreenLoader.stopLoading();
        Loaders.successSnackBar(
            title: "Email Sent",
            message: "Email Link Sent to Reset your Password",
        );
        Get.to(()=> ResetPasswordView(email: email.text.trim(),));
      }
    }
    catch(e)
    {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
          title: "Oh snap!",
          message: e.toString(),
      );
    }

  }


  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }
}