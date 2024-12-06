import 'package:get/get.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';
import 'package:spotify/features/playlist_details/views_model/playlist_details_controller.dart';
import 'package:spotify/features/song_details/presentation/views/song_details_view.dart';

Future<void> songOnPressedLogic({required SongModel songDetails, required int index, required List<SongModel> playlistSongs, required bool isOffline}) async{
  if(Get.isRegistered<PlaylistDetailsController>()){
    if(!PlaylistDetailsController.instance.player.value.playing) PlaylistDetailsController.instance.fetchAllSongsOneByOne(songIndex: index);
    if(PlaylistDetailsController.instance.player.value.playing && PlaylistDetailsController.instance.currentSongIndex.value != index){
      await PlaylistDetailsController.instance.player.value.pause();
      PlaylistDetailsController.instance.fetchAllSongsOneByOne(songIndex: index);
    }
  }
  else if(Get.isRegistered<OfflineSongsController>()){
    if(!OfflineSongsController.instance.player.value.playing)  OfflineSongsController.instance.fetchAllSongsOneByOne(songIndex: index);
    if(OfflineSongsController.instance.player.value.playing && OfflineSongsController.instance.currentSongIndex.value != index){
      await OfflineSongsController.instance.player.value.pause();
      OfflineSongsController.instance.fetchAllSongsOneByOne(songIndex: index);
    }
  }
  else if(Get.isRegistered<FavoritesController>()){
    if(!FavoritesController.instance.player.value.playing)  FavoritesController.instance.fetchAllFavoriteSongsOneByOne(songIndex: index);
    if(FavoritesController.instance.player.value.playing && FavoritesController.instance.currentSongIndex.value != index){
      await FavoritesController.instance.player.value.pause();
      FavoritesController.instance.fetchAllFavoriteSongsOneByOne(songIndex: index);
    }
  }

  Get.isRegistered<PlaylistDetailsController>()?
      Get.to(()=>SongDetailsView(
          playlistDetailsController: PlaylistDetailsController.instance,
          offlineSongsController: null,
          favoritesController: null
      ),
          arguments: {"songDetails":songDetails,"playlistSongs": playlistSongs ,"index":index, "isOffline":isOffline}
      ):
  Get.isRegistered<OfflineSongsController>()?
  Get.to(()=>SongDetailsView(
      playlistDetailsController: null,
      offlineSongsController: OfflineSongsController.instance,
      favoritesController: null
  ),
      arguments: {"songDetails":songDetails,"playlistSongs": playlistSongs ,"index":index, "isOffline":isOffline}
  ):
  Get.to(()=>SongDetailsView(
      playlistDetailsController: null,
      offlineSongsController: null,
      favoritesController: FavoritesController.instance
  ),
      arguments: {"songDetails":songDetails,"playlistSongs": playlistSongs ,"index":index, "isOffline":isOffline}
  );
}