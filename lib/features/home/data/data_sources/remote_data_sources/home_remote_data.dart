
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/home/data/models/new_album_model.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class HomeRemoteData extends GetxController {
  static HomeRemoteData get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

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


  Future<List<SongsCollectionModel>> fetchAllPlaylists() async{
    try{
      final snapshot = await _db.collection("Playlists").get();
      if(snapshot.docs.isNotEmpty){
        return snapshot.docs.map((playlist) => SongsCollectionModel.fromSnapshot(playlist)).toList();
      }
      else{
        return <SongsCollectionModel>[];
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
      throw "Something went wrong: ${e.toString()}";
    }
  }

  Future<List<NewAlbumModel>> fetchAllNewAlbums() async{
    try{
      final snapshot = await _db.collection("NewAlbums").get();
      if(snapshot.docs.isNotEmpty){
        return snapshot.docs.map((newAlbum) => NewAlbumModel.fromSnapshot(newAlbum)).toList();
      }
      else{
        return <NewAlbumModel>[];
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
      throw "Something went wrong: ${e.toString()}";
    }
  }

  Future<void> addToRecentlyPlayedPlaylists({required SongsCollectionModel playlist}) async {
    try{
      await _db.collection("Users").doc(_auth.currentUser!.uid).collection("RecentlyPlayedPlaylists").doc("${playlist.collectionTitle}_${playlist.id}").set(
        {
          ...playlist.toJson(),
          "lastPlayedAt": DateTime.now().toIso8601String()
        },
        SetOptions(merge: true),
      );
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
      throw "Something went wrong: ${e.toString()}";
    }
  }

  Future<List<SongsCollectionModel>> fetchRecentlyPlayedPlaylists() async{
    try{
      final snapshot = await _db.collection("Users").doc(_auth.currentUser?.uid).collection("RecentlyPlayedPlaylists").orderBy("lastPlayedAt", descending: true).get();
      if(snapshot.docs.isNotEmpty){
        return snapshot.docs.map((playlist) => SongsCollectionModel.fromSnapshot(playlist)).toList()..sort(
          (a, b) {
            final dateA = DateTime.tryParse(a.lastPlayedAt ?? '') ?? DateTime(0);
            final dateB = DateTime.tryParse(b.lastPlayedAt ?? '') ?? DateTime(0);
            return dateA.compareTo(dateB);
          },
        );
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
      throw "Something went wrong: ${e.toString()}";
    }
  }

  Future<List<SongsCollectionModel>> fetchYourCreatedPlaylists() async{
    try{
      final snapshot = await _db.collection("Users").doc(_auth.currentUser!.uid).collection("CreatedPlaylists").get();
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
      throw "Something went wrong: ${e.toString()}";
    }
  }

  Future<List<SongModel>> fetchSongs() async {
    try{
      final snapshot = await _db.collection("Songs").get();
      if(snapshot.docs.isNotEmpty){
        return snapshot.docs.map((song) => SongModel.fromSnapshot(song)).toList();
      }
      return <SongModel>[];
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

  Future<void> createPlaylists({required SongsCollectionModel playlist}) async{
    try{
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("CreatedPlaylists").doc("${playlist.collectionTitle}_${playlist.id}").set(playlist.toJson());
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
      throw "Something went wrong: ${e.toString()}";
    }
  }

  Future<void> addSongToCreatedPlaylists({required List<String>? listOfSongs, required SongsCollectionModel playlist}) async{
    try{
      final jsonListOfSongs = {"ListOfSongsIds":listOfSongs};
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("CreatedPlaylists").doc("${playlist.collectionTitle}_${playlist.id}").update(jsonListOfSongs);
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
      throw "Something went wrong: ${e.toString()}";
    }
  }
  Future<void> addSongToRecentlyAndCreatedPlaylists({required List<String>? listOfSongs, required SongsCollectionModel playlist}) async{
    try{
      final jsonListOfSongs = {"ListOfSongsIds":listOfSongs};
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("CreatedPlaylists").doc("${playlist.collectionTitle}_${playlist.id}").update(jsonListOfSongs);
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("RecentlyPlayedPlaylists").doc("${playlist.collectionTitle}_${playlist.id}").update(jsonListOfSongs);
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
      throw "Something went wrong: ${e.toString()}";
    }
  }

  Future<List<UserModel>> fetchFollowingList() async{
    try{
     final snapshot = await _db.collection("Users").doc(_auth.currentUser?.uid).collection("Following").get();
      if(snapshot.docs.isNotEmpty){
        final usersIdsList = snapshot.docs.map((userId) => userId["UserId"] as String).toList();
        final usersDataSnapshot = await _db.collection("Users").where(FieldPath.documentId,whereIn:usersIdsList ).get();
        if(usersDataSnapshot.docs.isNotEmpty){
          return usersDataSnapshot.docs.map((user) => UserModel.fromSnapshot(user)).toList();
        }
        else {
          return <UserModel>[];
        }
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
      throw "Something went wrong: ${e.toString()}";
    }
  }

  Future<List<UserModel>> fetchFollowersList() async{
    try{
      final snapshot = await _db.collection("Users").doc(_auth.currentUser?.uid).collection("Followers").get();
      if(snapshot.docs.isNotEmpty){
        final usersIdsList = snapshot.docs.map((userId) => userId["UserId"] as String).toList();
        final usersDataSnapshot = await _db.collection("Users").where(FieldPath.documentId,whereIn:usersIdsList ).get();
        if(usersDataSnapshot.docs.isNotEmpty){
          return usersDataSnapshot.docs.map((user) => UserModel.fromSnapshot(user)).toList();
        }
        else {
          return <UserModel>[];
        }
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
      throw "Something went wrong: ${e.toString()}";
    }
  }

}