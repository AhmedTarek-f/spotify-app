import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spotify/core/constants/api_keys.dart';
import 'package:spotify/features/offline_songs/data/models/offline_song_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class OfflineSongsController extends GetxController {
  static OfflineSongsController get instance => Get.find();
  late final Box<OfflineSongModel> _offlineSongsBox;
  final RxBool isPlaying = false.obs;
  RxList<SongModel> songsList = <SongModel>[].obs;
  @override
  void onInit() async{
    await _openHiveSongsBox();
    initOfflineSongsList();
    super.onInit();
  }

  Future<void> _openHiveSongsBox() async {
    _offlineSongsBox = await Hive.openBox<OfflineSongModel>(kSongsBox);
  }

  Future<void> deleteSong({required String songId}) async{
    await _offlineSongsBox.delete(songId);
    songsList.removeWhere((song) => song.songId == songId);
  }

  void initOfflineSongsList() {
    if(_offlineSongsBox.values.isNotEmpty){
      final allOfflineSongs = _offlineSongsBox.values.toList();
      final List<SongModel> allSongs = allOfflineSongs.map((song) => SongModel(
          songId: song.songId,
          songImage: song.songImage,
          songTitle: song.songTitle,
          songAuthor: song.songAuthor,
          songLength: song.songLength,
          songUrl: song.localFilePath!,
          lyrics: song.lyrics
      )).toList();
      songsList.assignAll(allSongs);
    }
  }

  Future<void> saveOfflineSong(OfflineSongModel song) async {
    await _offlineSongsBox.put(song.songId, song);
  }

  @override
  void onClose() async{
    await _offlineSongsBox.close();
  }
}