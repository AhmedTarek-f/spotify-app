import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/discovery/data/model/followers_following_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/song_details/data/models/song_id_model.dart';

class DiscoveryRemoteData extends GetxController{
  static DiscoveryRemoteData get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<List<UserModel>> fetchAllRegisteredUsers() async{
    try{
      final snapshot = await _db.collection("Users").where("Id" , isNotEqualTo: _auth.currentUser?.uid).get();
      if(snapshot.docs.isNotEmpty){
        return snapshot.docs.map((user) => UserModel.fromSnapshot(user)).toList();
      }
      else{
        return <UserModel>[];
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

  Future<List<SongModel>> fetchUserPublicSongs({required String userId}) async{
    try{
      final snapshot = await _db.collection("Users").doc(userId).collection("PublicFavoriteSongs").get();
      if(snapshot.docs.isNotEmpty){
       final List<SongIdModel> songsList= snapshot.docs.map((song) => SongIdModel.fromSnapshot(song)).toList();
       final List<String> songsIDs = songsList.map((song) => song.songId).toList();
       final publicSongsList = await _db.collection("Songs").where(FieldPath.documentId, whereIn: songsIDs).get();
       return publicSongsList.docs.map((song) => SongModel.fromSnapshot(song)).toList();
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

  Future<num> followUser({required String userId}) async {
    try{
      final snapshot = await _db.collection("Users").doc(userId).get();
      final userData = UserModel.fromSnapshot(snapshot);
      num userFollowers = userData.followers ?? 0;
      await _db.collection("Users").doc(userId).collection("Followers").doc(_auth.currentUser?.uid).set(FollowersFollowingModel(userId: _auth.currentUser!.uid).toJson());
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("Following").doc(userId).set(FollowersFollowingModel(userId:userId).toJson());
      final updatingUserFollowersToJson = {"Followers":userFollowers++};
      await _db.collection("Users").doc(userId).update(updatingUserFollowersToJson);
      return userFollowers;
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

  Future<num> unfollowUser({required String userId}) async {
    try{
      final snapshot = await _db.collection("Users").doc(userId).get();
      final userData = UserModel.fromSnapshot(snapshot);
      num userFollowers = userData.followers!;
      await _db.collection("Users").doc(userId).collection("Followers").doc(_auth.currentUser?.uid).delete();
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("Following").doc(userId).delete();
      final updatingUserFollowersToJson = {"Followers":userFollowers--};
      await _db.collection("Users").doc(userId).update(updatingUserFollowersToJson);
      return userFollowers;
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

  Future<List<String>> followingIds() async {
    try{
      final snapshot = await _db.collection("Users").doc(_auth.currentUser?.uid).collection("Following").get();
      if(snapshot.docs.isNotEmpty){
        final allFollowersList = snapshot.docs.map((following) => FollowersFollowingModel.fromSnapshot(following)).toList();
        final List<String> allFollowersIdsList = allFollowersList.map((follower)=>follower.userId).toList();
        return allFollowersIdsList;
      }
      else{
        return <String>[];
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
}