import 'package:get/get.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/profile/presentation/views_model/profile_controller.dart';
import 'package:spotify/features/song_details/presentation/views/song_details_view.dart';

Future<void> songOnPressedLogic({required SongModel songDetails, required int index, required List<SongModel> playlistSongs, required bool isOffline}) async{
  if(Get.isRegistered<PlaylistDetailsController>() && !PlaylistDetailsController.instance.player.value.playing) PlaylistDetailsController.instance.fetchAllSongsOneByOne(songIndex: index);
  if(Get.isRegistered<PlaylistDetailsController>() && PlaylistDetailsController.instance.player.value.playing && PlaylistDetailsController.instance.currentSongIndex.value != index){
    await PlaylistDetailsController.instance.player.value.pause();
    PlaylistDetailsController.instance.fetchAllSongsOneByOne(songIndex: index);
  }
  if(Get.isRegistered<OfflineSongsController>() && !OfflineSongsController.instance.player.value.playing)  OfflineSongsController.instance.fetchAllSongsOneByOne(songIndex: index);
  if(Get.isRegistered<OfflineSongsController>() && OfflineSongsController.instance.player.value.playing && OfflineSongsController.instance.currentSongIndex.value != index){
    await OfflineSongsController.instance.player.value.pause();
    OfflineSongsController.instance.fetchAllSongsOneByOne(songIndex: index);
  }
  if(Get.isRegistered<FavoritesController>() && !FavoritesController.instance.player.value.playing)  FavoritesController.instance.fetchAllSongsOneByOne(songIndex: index);
  if(Get.isRegistered<FavoritesController>() && FavoritesController.instance.player.value.playing && FavoritesController.instance.currentSongIndex.value != index){
    await FavoritesController.instance.player.value.pause();
    FavoritesController.instance.fetchAllSongsOneByOne(songIndex: index);
  }
  if(Get.isRegistered<ProfileController>() && !ProfileController.instance.player.value.playing)  ProfileController.instance.fetchAllSongsOneByOne(songIndex: index);
  if(Get.isRegistered<ProfileController>() && ProfileController.instance.player.value.playing && ProfileController.instance.currentSongIndex.value != index){
    await ProfileController.instance.player.value.pause();
    ProfileController.instance.fetchAllSongsOneByOne(songIndex: index);
  }
  Get.to(
        () =>  Get.isRegistered<PlaylistDetailsController>()?
    SongDetailsView(
        playlistDetailsController: PlaylistDetailsController.instance,
        profileController: null,
        offlineSongsController: null,
        favoritesController: null
    ):
    Get.isRegistered<OfflineSongsController>()?
    SongDetailsView(
        playlistDetailsController: null,
        profileController: null,
        offlineSongsController: OfflineSongsController.instance,
        favoritesController: null
    ):
    Get.isRegistered<FavoritesController>()?
    SongDetailsView(
        playlistDetailsController: null,
        profileController: null,
        offlineSongsController: null,
        favoritesController: FavoritesController.instance
    ):
    SongDetailsView(
        playlistDetailsController: null,
        profileController: ProfileController.instance,
        offlineSongsController: null,
        favoritesController: null
    ),
    arguments: {"songDetails":songDetails,"playlistSongs": playlistSongs ,"index":index, "isOffline":isOffline},
  );
}