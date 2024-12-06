import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_auth_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/data/model/followers_following_model.dart';

class AuthRemoteData extends GetxController{
  static AuthRemoteData get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // LogOut User
  Future<void> logout() async
  {
    try{
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
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
      throw "Something went wrong, Please try again";
    }

  }

  Future<void> deleteAccount() async{
    try{
      final allUsers = await _db.collection("Users").get();
      final allUsersList = allUsers.docs.map((user)=> UserModel.fromSnapshot(user)).toList();
      final currentUserFollowersIds = await _db.collection("Users").doc(_auth.currentUser?.uid).collection("Followers").get();
      final currentUserFollowersIdsList = currentUserFollowersIds.docs.map((follower)=> FollowersFollowingModel.fromSnapshot(follower)).toList();
      final currentUserFollowingIds =await _db.collection("Users").doc(_auth.currentUser?.uid).collection("Following").get();
      final currentUserFollowingIdsList = currentUserFollowingIds.docs.map((following)=> FollowersFollowingModel.fromSnapshot(following)).toList();
      for(int i=0 ; i<currentUserFollowersIdsList.length ; i++){
        await _db.collection("Users").doc(currentUserFollowersIdsList[i].userId).collection("Following").doc(_auth.currentUser?.uid).delete();
        num userFollowing = allUsersList.firstWhere((user) => user.id == currentUserFollowersIdsList[i].userId).following ?? 0;
        await _db.collection("Users").doc(currentUserFollowersIdsList[i].userId).update({"Following":--userFollowing});
      }
      for(int i=0 ; i<currentUserFollowingIdsList.length ; i++){
        await _db.collection("Users").doc(currentUserFollowingIdsList[i].userId).collection("Followers").doc(_auth.currentUser?.uid).delete();
        num userFollowers = allUsersList.firstWhere((user) => user.id == currentUserFollowingIdsList[i].userId).followers ?? 0;
        await _db.collection("Users").doc(currentUserFollowingIdsList[i].userId).update({"Followers":--userFollowers});
      }
      await _db.collection("Users").doc(_auth.currentUser?.uid).delete();
      await FirebaseAuth.instance.currentUser!.delete();
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
      throw "Something went wrong, Please try again";
    }
  }

}