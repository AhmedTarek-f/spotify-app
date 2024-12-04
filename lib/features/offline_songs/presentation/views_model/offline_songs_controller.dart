import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/core/constants/api_keys.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/features/offline_songs/data/models/offline_song_model.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class OfflineSongsController extends GetxController {
  static OfflineSongsController get instance => Get.find();
  late final Box<OfflineSongModel> _offlineSongsBox;
  final RxBool isPlaying = false.obs;
  RxList<SongModel> songsList = <SongModel>[].obs;
  Rx<AudioPlayer> player = getIt.get<AudioPlayer>().obs;
  RxBool isShuffling = false.obs;
  RxBool isRepeating = false.obs;
  RxInt currentSongIndex = 0.obs;
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<SongModel> currentSong = SongModel.empty().obs;

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
      if(allSongs.isNotEmpty){
        songsList.assignAll(allSongs);
        currentSong.value = songsList.elementAt(0);
      }
    }
  }

  Future<void> saveOfflineSong(OfflineSongModel song) async {
    await _offlineSongsBox.put(song.songId, song);
  }

  Future<void> toggleRepeat() async{
    isRepeating.value = !isRepeating.value;
    if(isRepeating.value)  await player.value.setLoopMode(LoopMode.one);
    if(!isRepeating.value)  await player.value.setLoopMode(LoopMode.all);
  }
  Future<void> toggleShuffle() async{
    isShuffling.value = !isShuffling.value;
    if(isShuffling.value) await player.value.setShuffleModeEnabled(true);
    if(!isShuffling.value) await player.value.setShuffleModeEnabled(false);
  }

  Future<void> toggleIsPlaying() async{
    isPlaying.value = !isPlaying.value;
    if(isPlaying.value) await fetchAllSongsOneByOne(songIndex: currentSongIndex.value);
    if(!isPlaying.value) await player.value.pause();
  }


  String formatDuration(Duration d){
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}";
  }

  Future<void> handlePlayAndPause() async{
    if(player.value.playing){
      isPlaying.value=false;
      await player.value.pause();
    }
    else{
      isPlaying.value = true;
      await player.value.play();
    }
  }

  void handleSeek(double value){
    player.value.seek(Duration(seconds: value.toInt()));
  }

  Future<void> fetchAllSongsOneByOne({required int songIndex}) async {
    currentSongIndex.value = songIndex;
    final playlist = ConcatenatingAudioSource(
      // Start loading next item just before reaching it
      useLazyPreparation: true,
      // Customise the shuffle algorithm
      shuffleOrder: DefaultShuffleOrder(),
      // Specify the playlist items
      children: songsList.map((song) => AudioSource.file(song.songUrl)).toList(),
    );
    // Load and play the playlist
    await player.value.setAudioSource(playlist, initialIndex: currentSongIndex.value, initialPosition: Duration.zero);
    player.value.positionStream.listen((p) {
      position.value = p;
    });
    player.value.durationStream.listen((d) {
      if(d != null){
        duration.value = d;
      }
    });
    player.value.currentIndexStream.listen((index) async{
      if (index != null) {
        currentSongIndex.value = index;
        currentSong.value = songsList[currentSongIndex.value];
        if(index >= (songsList.length-1)){
          await player.value.setLoopMode(LoopMode.all);
        }
      }
    });
    isPlaying.value = true;
    await player.value.play();
  }

  Future<void> playPreviousSong() async {
    if(player.value.currentIndex!>0){
      await player.value.seekToPrevious();
      currentSongIndex.value = player.value.currentIndex ??0;
      currentSong.value = songsList[currentSongIndex.value];
    }
    else{
      await fetchAllSongsOneByOne(songIndex: songsList.length-1);
    }
  }

  Future<void> playNextSong() async {
    if(player.value.currentIndex! < songsList.length-1){
      await player.value.seekToNext();
      currentSongIndex.value = player.value.currentIndex ??0;
      currentSong.value = songsList[currentSongIndex.value];
    }
    else{
      await fetchAllSongsOneByOne(songIndex: 0);
    }
  }

  @override
  void onClose() async{
    await player.value.stop();
    await _offlineSongsBox.close();
    super.onClose();
  }
}