import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';
import 'package:spotify/features/home/data/models/new_album_model.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';

class HomeRemoteData extends GetxController {
  static HomeRemoteData get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  
  Future<List<SongsCollectionModel>> fetchAllPlaylists() async{
    try{
      final snapshot = await _db.collection("Playlists").get();
      return snapshot.docs.map((playlist) => SongsCollectionModel.fromSnapshot(playlist)).toList();
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

  Future<List<NewAlbumModel>> fetchAllNewAlbums() async{
    try{
      final snapshot = await _db.collection("NewAlbums").get();
      return snapshot.docs.map((newAlbum) => NewAlbumModel.fromSnapshot(newAlbum)).toList();
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

  Future<void> addToRecentlyPlayedPlaylists({required SongsCollectionModel playlist}) async {
    try{
      await _db.collection("Users").doc(_auth.currentUser!.uid).collection("RecentlyPlayedPlaylists").doc(playlist.id).set(playlist.toJson());
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

  Future<void> addToYourCreatedPlaylists({required SongsCollectionModel playlist}) async {
    try{
      await _db.collection("Users").doc(_auth.currentUser!.uid).collection("YourCreatedPlaylists").add(playlist.toJson());
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

  Future<List<SongsCollectionModel>> fetchRecentlyPlayedPlaylists() async{
    try{
      final snapshot = await _db.collection("Users").doc(_auth.currentUser!.uid).collection("RecentlyPlayedPlaylists").get();
      if(snapshot.docs.isNotEmpty){
        return snapshot.docs.map((playlist) => SongsCollectionModel.fromSnapshot(playlist)).toList();
      }
      return <SongsCollectionModel>[];
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

  Future<List<SongsCollectionModel>> fetchYourCreatedPlaylists() async{
    try{
      final snapshot = await _db.collection("Users").doc(_auth.currentUser!.uid).collection("YourCreatedPlaylists").get();
      if(snapshot.docs.isNotEmpty){
        return snapshot.docs.map((playlist) => SongsCollectionModel.fromSnapshot(playlist)).toList();
      }
      return <SongsCollectionModel>[];
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