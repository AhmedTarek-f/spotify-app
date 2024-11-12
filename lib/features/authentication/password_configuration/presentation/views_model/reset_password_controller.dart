import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/core/utlis/popups/t_full_screen_loader.dart';
import 'package:spotify/core/utlis/services/auth_services/additional_auth_services/additional_auth_services.dart';

class ResetPasswordController extends GetxController
{
  static ResetPasswordController get instance => Get.find();


  Future<void> resendPasswordResetEmail({required String email}) async{
    try{
        TFullScreenLoader.openLoadingDialog("Processing your request...".tr, SpotifyImages.docerAnimation);
        await AdditionalAuthServices.sendPasswordResetEmail(email: email);
        TFullScreenLoader.stopLoading();
        Loaders.successSnackBar(
          title: "Email Sent".tr,
          message: "Email Link Sent to Reset your Password".tr,
        );
    }
    catch(e)
    {
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
        title: "Oh Snap!".tr,
        message: e.toString().tr,
      );
    }

  }
}