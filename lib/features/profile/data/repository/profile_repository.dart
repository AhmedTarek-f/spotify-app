import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:spotify/features/authentication/register/data/models/user_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/profile/data/data_sources/remote_data_source/profile_remote_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ProfileRepository extends GetxController {
  static ProfileRepository get instance => Get.find();

  final _profileRemoteData = Get.put(ProfileRemoteData());
  final SupabaseClient supaBase = Supabase.instance.client;

  Future<UserModel> fetchUserDetails() async {
    try{
      return await _profileRemoteData.fetchUserDetails();
    }
    catch (e){
      throw e.toString();
    }
  }
  Future<void> updateProfilePicture({required String newProfilePic}) async{
    try{
      Map<String,dynamic> json = {"ProfileImg":newProfilePic,};
     await _profileRemoteData.updateProfilePicture(json: json);
    }
    catch (e){
      throw e.toString();
    }
  }

  Future<String> uploadProfileImage({required XFile image}) async {
    try{
      final String uniqueId = const Uuid().v4(); // Generate a unique identifier
      final String path = "${uniqueId}_${basename(image.path)}";
      final File imageFile = File(image.path);
      await supaBase.storage.from("images/profile_pictures").upload(path,imageFile);
      return await supaBase.storage.from("images/profile_pictures").getPublicUrl(path);
    }
    catch(e){
      throw e.toString();
    }
  }

  Future<List<SongModel>> fetchAllPublicSongs() async {
    try{
      return await _profileRemoteData.fetchAllPublicSongs();
    }
    catch (e)
    {
      throw e.toString();
    }
  }
  Future<void> deleteFromYourPublicFavoriteSongs({required String songId}) async {
    try{
      await _profileRemoteData.deleteFromYourPublicFavoriteSongs(songId: songId);
    }
    catch (e)
    {
      throw e.toString();
    }
  }
}