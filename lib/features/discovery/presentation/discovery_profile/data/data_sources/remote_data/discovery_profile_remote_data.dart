import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/data/models/following_followers_model.dart';

class DiscoveryProfileRemoteData extends GetxController{
  static DiscoveryProfileRemoteData get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<FollowingFollowersModel> getFollowingFollowersData({required String userId}) async{
    try{
      final userDataSnapshot = await _db.collection("Users").doc(userId).get();
      final userData = UserModel.fromSnapshot(userDataSnapshot);
      return FollowingFollowersModel(following: userData.following ?? 0,followers: userData.followers??0);
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
      throw "Something went wrong:${e.toString()}";
    }
  }
}