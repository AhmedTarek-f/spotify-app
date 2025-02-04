

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/core/constants/api_keys.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/offline_songs/data/models/offline_song_model.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/data/repository/playlist_details_repository.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class PlaylistDetailsController extends GetxController {
  static PlaylistDetailsController get instance => Get.find();
  final PlaylistDetailsRepository _playlistDetailsRepository = Get.put(PlaylistDetailsRepository());
  final homeController = HomeController.instance;
  SongsCollectionModel playlist = Get.arguments["playlist"];
  RxBool isSongsLoading = false.obs;
  RxBool isPlaying = false.obs;
  RxBool isDownloadingProcess = false.obs;
  RxBool isDeletingPlaylist = false.obs;
  RxBool isDeletingSongLoading = false.obs;
  RxBool isCreatedPlaylistPublic = false.obs;
  RxList<SongModel> playlistSongs = <SongModel>[].obs;
  String deletedSongName = "";
  late final Box<OfflineSongModel> _offlineSongsBox;
  String downloadingSongId = "";
  late final bool isCreatedPlaylistPublicOrNot;
  Rx<AudioPlayer> player = getIt.get<AudioPlayer>().obs;
  RxBool isShuffling = false.obs;
  RxBool isRepeating = false.obs;
  RxInt currentSongIndex = 0.obs;
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<SongModel> currentSong = SongModel.empty().obs;
  final bool isOfflineMode = Get.arguments["isOffline"] ?? false;

  @override
  void onInit() async{
    super.onInit();
    await _openHiveSongsBox();
    if(playlist.id != "001" && playlist.id != "002") addToRecentlyPlayedPlaylists(playlist: playlist);
    if(playlist.id != "001" && playlist.id != "002" ) UpdateRecentlyPlayedTime(playlist: playlist);
    fetchPlaylistSongs(listOfSongs: playlist.listOfSongsIds);
    if((playlist.createdBy?.isNotEmpty ?? false) && playlist.createdBy != null) isCreatedPlaylistAtPublic(playlist: playlist);
  }

  void movingPlaylistToTop() {
    if (homeController.recentlyPlayedPlaylists.any((playlistItem) => playlistItem.collectionTitle == playlist.collectionTitle && playlistItem.collectionImg == playlist.collectionImg)) {
      homeController.recentlyPlayedPlaylists.removeWhere((playlistItem) => playlistItem.collectionTitle == playlist.collectionTitle && playlistItem.collectionImg == playlist.collectionImg);
      homeController.recentlyPlayedPlaylists.insert(0, playlist);
    }
  }

  Future<void> addToRecentlyPlayedPlaylists({required SongsCollectionModel playlist}) async{
    if(homeController.recentlyPlayedPlaylists.any((playlistItem)=> (playlistItem.id == playlist.id) && (playlistItem.collectionTitle == playlist.collectionTitle))){
      return;
    }
    else{
      if(playlist.id!="001" && playlist.id!="002") await homeController.addToRecentlyPlayedPlaylists(playlist: playlist);
    }
  }

  Future<void> fetchPlaylistSongs({required List<String>? listOfSongs}) async {
    try{
      isSongsLoading.value = true;
      final allSongs = await _playlistDetailsRepository.fetchPlaylistSongs(listOfSongs: listOfSongs);
      if(allSongs.isNotEmpty){
        playlistSongs.assignAll(allSongs);
        currentSong.value = playlistSongs.elementAt(0);
      }
      isSongsLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> UpdateRecentlyPlayedTime({required SongsCollectionModel playlist}) async {
    try{
      if(homeController.recentlyPlayedPlaylists.any((playlistItem)=> (playlistItem.id == playlist.id) && (playlistItem.collectionTitle == playlist.collectionTitle))){
        await _playlistDetailsRepository.UpdateRecentlyPlayedTime(playlist: playlist);
      }
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> deleteCreatedPlaylist({required SongsCollectionModel playlist}) async {
    try{
      isDeletingPlaylist.value = true;
      await _playlistDetailsRepository.deleteCreatedPlaylist(playlist: playlist);
      homeController.yourCreatedPlaylists.removeWhere((list) => list.collectionTitle == playlist.collectionTitle && list.collectionImg == playlist.collectionImg);
      homeController.recentlyPlayedPlaylists.removeWhere((list) => list.collectionTitle == playlist.collectionTitle && list.collectionImg == playlist.collectionImg);
      isDeletingPlaylist.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> deleteSongFromCreatedPlaylist({required SongModel song}) async {
    try{
      deletedSongName = song.songTitle;
      final listOfSongsIds = playlistSongs.map((song) => song.songId).toList();
      listOfSongsIds.removeWhere((songItem) => songItem == song.songId);
      isDeletingSongLoading.value = true;
      await _playlistDetailsRepository.deleteSongFromCreatedPlaylist(playlist: playlist,listOfSongs: listOfSongsIds);
      playlistSongs.removeWhere((songItem) => songItem.songId == song.songId);
      homeController.yourCreatedPlaylists.firstWhere((playlistItem) => playlistItem.collectionTitle == playlist.collectionTitle && playlistItem.collectionImg == playlist.collectionImg).listOfSongsIds = listOfSongsIds;
      homeController.recentlyPlayedPlaylists.firstWhere((playlistItem) => playlistItem.collectionTitle == playlist.collectionTitle && playlistItem.collectionImg == playlist.collectionImg).listOfSongsIds = listOfSongsIds;
      isDeletingSongLoading.value = false;
      deletedSongName = "";
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> showPlaylistToFollowers({required SongsCollectionModel playlist}) async {
    try{
      await _playlistDetailsRepository.addCreatedPlaylistToPublic(playlist: playlist);
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  Future<void> hidePlaylistFromFollowers({required SongsCollectionModel playlist}) async {
    try{
      await _playlistDetailsRepository.deleteCreatedPlaylistFromPublic(playlist: playlist);
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  void toggleShowHidePlaylist() {
    isCreatedPlaylistPublic.value = !isCreatedPlaylistPublic.value;
  }

  Future<void> checkIfAddOrDeletedFromPublic() async{
    if(isCreatedPlaylistPublic.value != isCreatedPlaylistPublicOrNot) {
      if(isCreatedPlaylistPublic.value){
        await showPlaylistToFollowers(playlist: playlist);
      }
      else {
        await hidePlaylistFromFollowers(playlist: playlist);
      }
    }
  }

  Future<void> isCreatedPlaylistAtPublic({required SongsCollectionModel playlist}) async {
    try{
      isCreatedPlaylistPublic.value = await _playlistDetailsRepository.isCreatedPlaylistAtPublic(playlist: playlist);
      isCreatedPlaylistPublicOrNot =  isCreatedPlaylistPublic.value ;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  bool checkPlaylistCreator() {
    return ("${playlist.collectionTitle}_${playlist.id}" == "${playlist.collectionTitle}_${FirebaseAuth.instance.currentUser?.uid}");
  }

  Future<void> _openHiveSongsBox() async {
    _offlineSongsBox = await Hive.openBox<OfflineSongModel>(kSongsBox);
  }

  Future<void> saveOfflineSong(OfflineSongModel song) async {
    await _offlineSongsBox.put(song.songId, song);
  }

  bool checkIfSongDownloaded({required String songId}){
    return _offlineSongsBox.containsKey(songId);
  }

  Future<void> downloadAndSaveSong({required SongModel song,}) async {
    try {
      downloadingSongId = song.songId;
      // Download the song from Supabase
      isDownloadingProcess.value = true;
      final songLocalFilePath = await _playlistDetailsRepository.downloadSong(song: song);
      final songImageLocalFilePath = await _playlistDetailsRepository.downloadSongImage(song: song);

      // Create the OfflineSongModel
      final offlineSong = OfflineSongModel(
        songId: song.songId,
        songImage: songImageLocalFilePath,
        songTitle: song.songTitle,
        songAuthor: song.songAuthor,
        songLength: song.songLength,
        lyrics: song.lyrics,
        localFilePath: songLocalFilePath,
      );

      // Save the song in Hive
      await saveOfflineSong(offlineSong);
      if(Get.isRegistered<OfflineSongsController>()) OfflineSongsController.instance.songsList.add(SongModel(
          songId: song.songId,
          songImage: songImageLocalFilePath,
          songTitle: song.songTitle,
          songAuthor: song.songAuthor,
          songLength: song.songLength,
          songUrl: songLocalFilePath,
          lyrics: song.lyrics
      ));
      isDownloadingProcess.value = false;
      downloadingSongId = "";

      Loaders.successSnackBar(title: "Note",message: '${song.songTitle} Song downloaded and saved locally');
    }
    catch (e) {
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
      children: playlistSongs.map((song) => isOfflineMode?AudioSource.file(song.songUrl) :AudioSource.uri(Uri.parse(song.songUrl))).toList(),
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
      if (index != null && playlistSongs.isNotEmpty) {
        currentSongIndex.value = index;
        currentSong.value = playlistSongs[index];
        if(index >= (playlistSongs.length-1)){
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
      currentSong.value = playlistSongs[currentSongIndex.value];
      if( isOfflineMode == false && Get.isRegistered<SongDetailsController>()) await SongDetailsController.instance.fetchIfFavoriteSongs(songId: currentSong.value.songId);
      if( isOfflineMode == false && Get.isRegistered<SongDetailsController>()) await SongDetailsController.instance.fetchIfPublicFavoriteSongs(songId: currentSong.value.songId);
    }
    else{
      await fetchAllSongsOneByOne(songIndex: playlistSongs.length-1);
    }
  }

  Future<void> playNextSong() async {
    if(player.value.currentIndex! < playlistSongs.length-1){
      await player.value.seekToNext();
      currentSongIndex.value = player.value.currentIndex ??0;
      currentSong.value = playlistSongs[currentSongIndex.value];
      if( isOfflineMode == false && Get.isRegistered<SongDetailsController>()) await SongDetailsController.instance.fetchIfFavoriteSongs(songId: currentSong.value.songId);
      if( isOfflineMode == false && Get.isRegistered<SongDetailsController>()) await SongDetailsController.instance.fetchIfPublicFavoriteSongs(songId: currentSong.value.songId);
    }
    else{
      await fetchAllSongsOneByOne(songIndex: 0);
    }
  }

  @override
  void onClose(){
    if(isPlaying.value) homeController.songsListPlaying.assignAll(playlistSongs);
    if(isPlaying.value) homeController.assignIndex();
    movingPlaylistToTop();
    if((playlist.createdBy?.isNotEmpty ?? false) && playlist.createdBy != null) checkIfAddOrDeletedFromPublic();
    super.onClose();
  }
}