import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class PlaylistDetailsRemoteData extends GetxController {
  static PlaylistDetailsRemoteData get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<SongModel>> fetchPlaylistSongs({required String playlistId}) async {
    try{
      final data = await _db.collection("Songs").where("PlaylistId",isEqualTo: playlistId).get();
      return data.docs.map((song) => SongModel.fromSnapshot(song)).toList();
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