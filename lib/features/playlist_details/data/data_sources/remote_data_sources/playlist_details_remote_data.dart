import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/api_keys.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart';

class PlaylistDetailsRemoteData extends GetxController {
  static PlaylistDetailsRemoteData get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<SongModel>> fetchPlaylistSongs({required List<String>? listOfSongs}) async {
    try{
      if((listOfSongs?.isNotEmpty?? false) && listOfSongs != null ){
        final gettingSongs = await _db.collection("Songs").where(FieldPath.documentId, whereIn: listOfSongs).get();
        if(gettingSongs.docs.isNotEmpty){
          return gettingSongs.docs.map((song) => SongModel.fromSnapshot(song)).toList();
        }
        else{
          return <SongModel>[];
        }
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
      throw "Something went wrong: ${e.toString()}";
    }
  }

  Future<void> deleteCreatedPlaylist({required SongsCollectionModel playlist}) async {
    try{
      await _db.collection("Users")
          .doc(_auth.currentUser?.uid)
          .collection("CreatedPlaylists")
          .doc("${playlist.collectionTitle}_${playlist.id}")
          .delete();
      await _db
          .collection("Users")
          .doc(_auth.currentUser?.uid)
          .collection("RecentlyPlayedPlaylists")
          .doc("${playlist.collectionTitle}_${playlist.id}")
          .delete();
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
  Future<void> UpdateRecentlyPlayedTime({required SongsCollectionModel playlist}) async {
    try{
      await _db.collection("Users").doc(_auth.currentUser!.uid).collection("RecentlyPlayedPlaylists").doc("${playlist.collectionTitle}_${playlist.id}").update(
        {
          "ListOfSongsIds": playlist.listOfSongsIds,
          "lastPlayedAt": DateTime.now().toIso8601String()
        },
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
  Future<void> deleteSongFromCreatedPlaylist({required SongsCollectionModel playlist,required List<String> listOfSongs}) async {
    try{
      final listOfSongsToJson = {
        "ListOfSongsIds":listOfSongs,
      };
      await _db.collection("Users")
          .doc(_auth.currentUser?.uid)
          .collection("CreatedPlaylists")
          .doc("${playlist.collectionTitle}_${playlist.id}").update(listOfSongsToJson);
      await _db
          .collection("Users")
          .doc(_auth.currentUser?.uid)
          .collection("RecentlyPlayedPlaylists")
          .doc("${playlist.collectionTitle}_${playlist.id}").update(listOfSongsToJson);
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
  Future<void> addCreatedPlaylistToPublic({required SongsCollectionModel playlist}) async {
    try{
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("PublicCreatedPlaylists").doc("${playlist.collectionTitle}_${playlist.id}").set(playlist.toJson());
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
  Future<void> deleteCreatedPlaylistFromPublic({required SongsCollectionModel playlist}) async {
    try{
      await _db.collection("Users").doc(_auth.currentUser?.uid).collection("PublicCreatedPlaylists").doc("${playlist.collectionTitle}_${playlist.id}").delete();
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
  Future<bool> isCreatedPlaylistAtPublic({required SongsCollectionModel playlist}) async {
    try{
      final snapshot = await _db.collection("Users").doc(_auth.currentUser?.uid).collection("PublicCreatedPlaylists").doc("${playlist.collectionTitle}_${playlist.id}").get();
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
      throw "Something went wrong: ${e.toString()}";
    }
  }

  Future<String> downloadSong({required SongModel song}) async {
    try {
      // Download the file from Supabase Storage
      final response = await supabase.storage.from(songsBucket).download("all_songs/${song.songBaseName}");

      // Save the file locally
      final directory = await getApplicationDocumentsDirectory();
      final localFilePath = '${directory.path}/${song.songTitle}.mp3';
      final file = File(localFilePath);
      await file.writeAsBytes(response);

      return localFilePath; // Return the local file path
    } catch (e) {
      throw "Error while downloading the song: ${e.toString()}";
    }
  }

  Future<String> downloadSongImage({required SongModel song}) async {
    try {
      // Download the file from Supabase Storage
      final response = await supabase.storage.from(imagesBucket).download("songs_images/${song.songBaseImage}");

      // Save the file locally
      final directory = await getApplicationDocumentsDirectory();
      final localFilePath = '${directory.path}/${song.songBaseImage}';
      final file = File(localFilePath);
      await file.writeAsBytes(response);

      return localFilePath; // Return the local file path
    } catch (e) {
      throw "Error while downloading the song image: ${e.toString()}";
    }
  }
}