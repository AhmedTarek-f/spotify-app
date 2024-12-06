import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/core/utlis/popups/full_screen_loader.dart';
import 'package:spotify/core/utlis/services/auth_services/additional_auth_services/additional_auth_services.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';
import 'package:spotify/features/authentication/sign_in/presentation/views/sign_in_view.dart';
import 'package:spotify/features/discovery/presentation/discovery/views_model/discovery_controller.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';

class ReAuthUserLoginController extends GetxController {
  static ReAuthUserLoginController get instance => Get.find();
  late final TextEditingController verifyEmail;
  late final TextEditingController verifyPassword;
  RxBool hidePassword = true.obs;
  Rx<AutovalidateMode> autoValidateMode = AutovalidateMode.disabled.obs;
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    verifyEmail = TextEditingController();
    verifyPassword = TextEditingController();
  }


  Future<void> reAuthenticateEmailAndPassword(BuildContext context) async {
    try{
      if(!reAuthFormKey.currentState!.validate()){
        autoValidateMode.value = AutovalidateMode.always;
      }
      else{
        autoValidateMode.value = AutovalidateMode.disabled;
        FullScreenLoader.openLoadingDialog("Processing...", SpotifyImages.docerAnimation ,context);
        await AdditionalAuthServices.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
        await AuthenticationRepository.instance.deleteAccount();
        FullScreenLoader.stopLoading();
        Get.offAll(()=> const SignInView());
        if(Get.isRegistered<HomeController>()) Get.delete<HomeController>();
        if(Get.isRegistered<DiscoveryController>()) Get.delete<DiscoveryController>();
        if(Get.isRegistered<ProfileController>()) Get.delete<ProfileController>();
        if(Get.isRegistered<FavoritesController>()) Get.delete<FavoritesController>();
      }
    }catch (e)
    {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }


  @override
  void onClose() {
    verifyEmail.dispose();
    verifyPassword.dispose();
    super.onClose();
  }
}