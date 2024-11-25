import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/core/utlis/popups/full_screen_loader.dart';
import 'package:spotify/core/utlis/services/auth_services/register_with_email_and_password_service/register_with_email_and_password_service.dart';
import 'package:spotify/core/utlis/services/auth_services/sign_in_with_google_service/sign_in_with_google_service.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/authentication/register/data/repository/register_repository.dart';
import 'package:spotify/features/authentication/verify_email/presentation/views/verify_email_view.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  RxBool hidePassword = true.obs;
  late final TextEditingController userName;
  late final TextEditingController email;
  late final TextEditingController password;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final Rx<AutovalidateMode>  autoValidateMode = AutovalidateMode.disabled.obs;
  final RegisterRepository _registerRepositoryController = Get.put(RegisterRepository());

  @override
  void onInit() {
    userName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  Future<void> signUp({required BuildContext context})async {
    try{
      if(!registerFormKey.currentState!.validate())
      {
        autoValidateMode.value = AutovalidateMode.always;
        return;
      }
      else{
        registerFormKey.currentState!.save();
        autoValidateMode.value = AutovalidateMode.disabled;
        FullScreenLoader.openLoadingDialog("We are processing your information...", SpotifyImages.docerAnimation,context);
        final UserCredential userCredential = await RegisterWithEmailAndPasswordService.registerWithEmailAndPassword(email.text.trim(), password.text.trim());
        final newUser = UserModel(
          id: userCredential.user!.uid,
          userName: userName.text.trim(),
          email: email.text.trim(),
          following: 0,
          followers: 0,
        );

        await _registerRepositoryController.registerUser(userData: newUser);
        FullScreenLoader.stopLoading();
        Loaders.successSnackBar(title: "Congratulations",message: "Your account has been created! Verify email to continue.");
        Get.to(()=> VerifyEmailView(email: email.text.trim(),));
      }
    }
    catch(e){
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> signUpWithGoogle({required BuildContext context}) async
  {
    try{
      FullScreenLoader.openLoadingDialog("We are processing your information...", SpotifyImages.docerAnimation,context);
      final UserCredential userCredential = await SignInWithGoogleService.signInWithGoogle();
      if(userCredential.additionalUserInfo?.isNewUser ?? false){
        await _registerRepositoryController.saveGoogleUserRecord(userCredential);
      }
      FullScreenLoader.stopLoading();
      await AuthenticationRepository.instance.screenRedirect();
      Get.offAll(()=>AuthenticationRepository.instance.redirectedScreen);
    }
    catch(e)
    {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: "Data not saved!",message: e.toString());
    }
  }


  @override
  void onClose() {
    userName.dispose();
    email.dispose();
    password.dispose();
    super.onClose();
  }
}