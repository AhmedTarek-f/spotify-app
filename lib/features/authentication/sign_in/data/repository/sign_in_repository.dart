import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/services/auth_services/sign_in_with_email_and_password_service/sign_in_with_email_and_password_service.dart';
import 'package:spotify/features/authentication/register/data/data_sources/remote_data_sources/register_remote_data.dart';

class SignInRepository extends GetxController {
  static SignInRepository get instance => Get.find();

  Future<void> signInWithEmailAndPassword(String email,String password) async {
    try {
      await SignInWithEmailAndPasswordService.loginWithEmailAndPassword(email, password);
    }
    catch (e)
    {
      throw e.toString();
    }
  }

  Future<void> saveGoogleUserRecord(UserCredential? userCredential) async {
    try {
      final _registerRemoteDataController = Get.put(RegisterRemoteData());
      await _registerRemoteDataController.saveGoogleUserRecord(userCredential);
    }
    catch (e) {
      throw "Something went wrong while saving your information. You can re-save your data in your profile.";
    }
  }
}