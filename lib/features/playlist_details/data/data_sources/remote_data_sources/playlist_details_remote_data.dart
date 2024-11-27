import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class PlaylistDetailsRemoteData extends GetxController {
  static PlaylistDetailsRemoteData get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

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
    throw "Something went wrong, Please try again";
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
      throw "Something went wrong, Please try again";
    }
  }
  Future<void> UpdateRecentlyPlayedTime({required SongsCollectionModel playlist}) async {
    try{
      await _db.collection("Users").doc(_auth.currentUser!.uid).collection("RecentlyPlayedPlaylists").doc("${playlist.collectionTitle}_${playlist.id}").update(
        {
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
      throw "Something went wrong, Please try again";
    }
  }
}