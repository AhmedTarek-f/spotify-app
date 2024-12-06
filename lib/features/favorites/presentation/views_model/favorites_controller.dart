import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/favorites/data/repository/favorites_repository.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class FavoritesController extends GetxController{
  static FavoritesController get instance => Get.find();
  final _favoritesRepository = Get.put(FavoritesRepository());
  RxList<SongModel> favoriteSongsList = <SongModel>[].obs;
  final RxBool isFavoriteSongsLoading = false.obs;
  RxBool isPlaying = false.obs;
  Rx<AudioPlayer> player = getIt.get<AudioPlayer>().obs;
  RxBool isShuffling = false.obs;
  RxBool isRepeating = false.obs;
  RxInt currentSongIndex = 0.obs;
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<SongModel> currentSong = SongModel.empty().obs;
  final bool isOfflineMode =  false;

  @override
  void onInit() {
    super.onInit();
    fetchAllFavoriteSongs();
  }

  Future<void> fetchAllFavoriteSongs() async {
    try{
      isFavoriteSongsLoading.value = true;
      final allFavoriteSongs = await _favoritesRepository.fetchAllFavoriteSongs();
      if(allFavoriteSongs.isNotEmpty){
        favoriteSongsList.assignAll(allFavoriteSongs);
        currentSong.value = favoriteSongsList.elementAt(0);
      }
      isFavoriteSongsLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> deleteFromYourFavoriteSongs({required String songId}) async {
    try{
      await _favoritesRepository.deleteFromYourFavoriteSongs(songId: songId);
    }

    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
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

  Future<void> toggleFavIsPlaying() async{
    isPlaying.value = !isPlaying.value;
    if(isPlaying.value) await fetchAllFavoriteSongsOneByOne(songIndex: currentSongIndex.value);
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

  Future<void> fetchAllFavoriteSongsOneByOne({required int songIndex}) async {
    currentSongIndex.value = songIndex;
    final playlist = ConcatenatingAudioSource(
      // Start loading next item just before reaching it
      useLazyPreparation: true,
      // Customise the shuffle algorithm
      shuffleOrder: DefaultShuffleOrder(),
      // Specify the playlist items
      children: favoriteSongsList.map((song) => isOfflineMode?AudioSource.file(song.songUrl) :AudioSource.uri(Uri.parse(song.songUrl))).toList(),
    );
    // Load and play the playlist
    await player.value.setAudioSource(playlist, initialIndex: currentSongIndex.value, initialPosition: Duration.zero);

    player.value.positionStream.listen((p) {
      position.value = p;
    });
    player.value.durationStream.listen((d) {
      if(d!= null){
        duration.value = d;
      }
    });
      player.value.currentIndexStream.listen((index) async{
        if (index != null && favoriteSongsList.isNotEmpty) {
          currentSongIndex.value = index;
          currentSong.value = favoriteSongsList[index];
          if(index >= (favoriteSongsList.length-1)){
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
      currentSong.value = favoriteSongsList[currentSongIndex.value];
      if( isOfflineMode == false && Get.isRegistered<SongDetailsController>()) await SongDetailsController.instance.fetchIfFavoriteSongs(songId: currentSong.value.songId);
      if( isOfflineMode == false && Get.isRegistered<SongDetailsController>()) await SongDetailsController.instance.fetchIfPublicFavoriteSongs(songId: currentSong.value.songId);
    }
    else{
      await fetchAllFavoriteSongsOneByOne(songIndex: favoriteSongsList.length-1);
    }
  }

  Future<void> playNextSong() async {
    if(player.value.currentIndex! < favoriteSongsList.length-1){
      await player.value.seekToNext();
      currentSongIndex.value = player.value.currentIndex ??0;
      currentSong.value = favoriteSongsList[currentSongIndex.value];
      if( isOfflineMode == false && Get.isRegistered<SongDetailsController>()) await SongDetailsController.instance.fetchIfFavoriteSongs(songId: currentSong.value.songId);
      if( isOfflineMode == false && Get.isRegistered<SongDetailsController>()) await SongDetailsController.instance.fetchIfPublicFavoriteSongs(songId: currentSong.value.songId);
    }
    else{
      await fetchAllFavoriteSongsOneByOne(songIndex: 0);
    }
  }

}