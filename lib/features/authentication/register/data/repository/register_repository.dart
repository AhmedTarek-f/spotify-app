import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spotify/features/authentication/register/data/data_sources/remote_data_sources/register_remote_data.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';

class RegisterRepository extends GetxController {
  static RegisterRepository get instance => Get.find();
  final _registerRemoteDataController = Get.put(RegisterRemoteData());

  Future<void> registerUser({required UserModel userData}) async {
    try {
      await _registerRemoteDataController.registerUserData(userData);
    }
    catch (e)
    {
      throw "Something went wrong while user register, Please try again";
    }
  }
  Future<void> saveGoogleUserRecord(UserCredential? userCredential) async {
    try {
      await _registerRemoteDataController.saveGoogleUserRecord(userCredential);
    }
    catch (e) {
    throw "Something went wrong while saving your information. You can re-save your data in your profile.";
    }
  }
}