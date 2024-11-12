import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_auth_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';

class RegisterRemoteData extends GetxController{
  static RegisterRemoteData get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<void> registerUserData(UserModel userData)async{
    try{
      await _db.collection("User").doc(userData.id).set(userData.toJson());
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch(e)
    {
      throw TPlatformException(e.code).message;
    }
    catch (e)
    {
      throw "Something went wrong while user register, Please try again";
    }
  }

  Future<void> saveGoogleUserRecord(UserCredential? userCredential) async {
    try {
      final user = await fetchUserDetails();
      if(user.id.isEmpty)
      {
        if (userCredential != null) {
          final userName = UserModel.generateUsername(userCredential.user!.displayName ?? "");
          final user = UserModel(
            id: userCredential.user!.uid,
            userName: userName,
            email: userCredential.user!.email ?? "",
          );

          await registerUserData(user);
        }
      }

    }
    catch (e) {
      throw "Something went wrong while saving your information. You can re-save your data in your profile.";
    }
  }

  Future<UserModel> fetchUserDetails() async{
    try{
      final documentSnapshot = await _db.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).get();
      if(documentSnapshot.exists)
      {
        return UserModel.fromSnapshot(documentSnapshot);
      }
      else{
        return UserModel.empty();
      }
    }on FirebaseAuthException catch (e)
    {
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch(e)
    {
      throw TPlatformException(e.code).message;
    }
    catch (e)
    {
      throw "Something went wrong, Please try again".tr;
    }
  }
}