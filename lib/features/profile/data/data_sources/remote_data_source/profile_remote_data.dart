import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/presentation/discovery_profile/data/models/following_followers_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/song_details/data/models/song_id_model.dart';

class ProfileRemoteData extends GetxController {
  static ProfileRemoteData get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> updateProfilePicture({required Map<String,dynamic> json}) async {
    try{
      await _db.collection("Users").doc(_auth.currentUser!.uid).update(json);
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

  Future<UserModel> fetchUserDetails() async{
    try{
      final documentSnapshot = await _db.collection("Users").doc(_auth.currentUser!.uid).get();
      if(documentSnapshot.exists)
      {
        return UserModel.fromSnapshot(documentSnapshot);
      }
      else{
        return UserModel.empty();
      }
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

  Future<FollowingFollowersModel> getFollowingFollowersData() async{
    try{
      final userDataSnapshot = await _db.collection("Users").doc(_auth.currentUser?.uid).get();
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
  
  Future<List<SongModel>> fetchAllPublicSongs() async {
    try{
      final publicSongsIdSnapShot = await _db.collection("Users").doc(_auth.currentUser?.uid).collection("PublicFavoriteSongs").get();
      if(publicSongsIdSnapShot.docs.isNotEmpty){
        final publicSongsId = publicSongsIdSnapShot.docs.map((song)=> SongIdModel.fromSnapshot(song)).toList();
        final publicSongsIdsList = publicSongsId.map((song) => song.songId).toList();
        final publicSongsSnapshot = await _db.collection("Songs").where(FieldPath.documentId,whereIn: publicSongsIdsList).get();
        return publicSongsSnapshot.docs.map((song) => SongModel.fromSnapshot(song)).toList();
      }
      else{
        return <SongModel>[];
      }
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
  Future<void> deleteFromYourPublicFavoriteSongs({required String songId}) async {
    try{
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("PublicFavoriteSongs").doc(songId).delete();
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
