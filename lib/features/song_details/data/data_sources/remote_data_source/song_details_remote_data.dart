import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';

class SongDetailsRemoteData extends GetxController {
  static SongDetailsRemoteData get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  
  Future<void> addToYourFavoriteSongs({required String songId}) async {
    try{
      final songToJson = {"SongId":songId};
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("FavoriteSongs").doc(songId).set(songToJson);
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

  Future<void> deleteFromYourFavoriteSongs({required String songId}) async {
    try{
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("FavoriteSongs").doc(songId).delete();
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

  Future<bool> fetchIfFavoriteSongs({required String songId}) async {
    try{
      final snapshot = await _db.collection("Users").doc(_auth.currentUser?.uid).collection("FavoriteSongs").doc(songId).get();
      return snapshot.exists;
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

  Future<void> addToYourPublicFavoriteSongs({required String songId}) async {
    try{
      final songToJson = {"SongId":songId};
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("PublicFavoriteSongs").doc(songId).set(songToJson);
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

  Future<bool> fetchIfPublicFavoriteSongs({required String songId}) async {
    try{
      final snapshot = await _db.collection("Users").doc(_auth.currentUser?.uid).collection("PublicFavoriteSongs").doc(songId).get();
      return snapshot.exists;
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