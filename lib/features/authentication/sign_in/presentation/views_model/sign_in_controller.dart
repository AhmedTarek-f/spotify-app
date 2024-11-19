import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/core/utlis/popups/full_screen_loader.dart';
import 'package:spotify/core/utlis/services/auth_services/sign_in_with_google_service/sign_in_with_google_service.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';
import 'package:spotify/features/authentication/sign_in/data/repository/sign_in_repository.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();
  late final TextEditingController email;
  late final TextEditingController password;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final Rx<AutovalidateMode> autoValidateMode = AutovalidateMode.disabled.obs;
  final SignInRepository signInRepository = Get.put(SignInRepository());
  RxBool hidePassword = true.obs;


  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  Future<void> signIn() async{
    try{
      if(!loginFormKey.currentState!.validate())
      {
        autoValidateMode.value = AutovalidateMode.always;
        return;
      }
      else{
        loginFormKey.currentState!.save();
        autoValidateMode.value = AutovalidateMode.disabled;
        FullScreenLoader.openLoadingDialog("Logging you in...", SpotifyImages.docerAnimation);
        await signInRepository.signInWithEmailAndPassword(email.text.trim(), password.text.trim());
        clearData();
        await AuthenticationRepository.instance.screenRedirect();
        FullScreenLoader.stopLoading();
        Get.offAll(() => AuthenticationRepository.instance.redirectedScreen);
      }
    }
    catch(e){
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> googleSignIn()async {
    try {
      FullScreenLoader.openLoadingDialog(
          "Logging you in...", SpotifyImages.docerAnimation);
      final UserCredential userCredential = await SignInWithGoogleService.signInWithGoogle();
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        await signInRepository.saveGoogleUserRecord(userCredential);
      }
      await AuthenticationRepository.instance.screenRedirect();
      FullScreenLoader.stopLoading();
      Get.offAll(() => AuthenticationRepository.instance.redirectedScreen);
    }
    catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  void clearData() {
    email.clear();
    password.clear();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}