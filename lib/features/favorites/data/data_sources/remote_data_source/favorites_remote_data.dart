import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';
import 'package:spotify/features/favorites/data/models/favorite_Song_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class FavoritesRemoteData extends GetxController{
  static FavoritesRemoteData get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<List<SongModel>> fetchAllFavoriteSongs() async {
    try{
      final favoriteSongsIdSnapShot = await _db.collection("Users").doc(_auth.currentUser?.uid).collection("FavoriteSongs").get();
      if(favoriteSongsIdSnapShot.docs.isNotEmpty){
        final favoriteSongsId = favoriteSongsIdSnapShot.docs.map((song)=> FavoriteSongModel.fromSnapshot(song)).toList();
        final favoriteSongsIdsList = favoriteSongsId.map((song) => song.songId).toList();
        final favoriteSongsSnapshot = await _db.collection("Songs").where(FieldPath.documentId,whereIn: favoriteSongsIdsList).get();
        return favoriteSongsSnapshot.docs.map((song) => SongModel.fromSnapshot(song)).toList();
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

}