
import 'package:get/get.dart';
import 'package:spotify/core/utlis/loaders/loaders.dart';
import 'package:spotify/features/home/data/models/songs_collection_model.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/playlist_details/data/repository/playlist_details_repository.dart';
import 'package:spotify/features/playlist_details/data/models/song_model.dart';

class PlaylistDetailsController extends GetxController {
  static PlaylistDetailsController get instance => Get.find();
  final PlaylistDetailsRepository _playlistDetailsRepository = Get.put(PlaylistDetailsRepository());
  final homeController = HomeController.instance;
  SongsCollectionModel playlist = Get.arguments["playlist"];
  RxBool isSongsLoading = false.obs;
  RxBool isPlaying = false.obs;
  RxList<SongModel> playlistSongs = <SongModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    addToRecentlyPlayedPlaylists(playlist: playlist);
    fetchPlaylistSongs(playlistId: playlist.id);
  }

  Future<void> addToRecentlyPlayedPlaylists({required SongsCollectionModel playlist}) async{
    if(playlist.id!="001" &&
        playlist.id!="002" &&
        (!homeController.recentlyPlayedPlaylists.any((item)=>item.id == playlist.id))
    ) await homeController.addToRecentlyPlayedPlaylists(playlist: playlist);
  }

  Future<void> fetchPlaylistSongs({required String playlistId}) async {
    try{
      isSongsLoading.value = true;
      final allSongs = await _playlistDetailsRepository.fetchPlaylistSongs(playlistId: playlistId);
      playlistSongs.assignAll(allSongs);
      isSongsLoading.value = false;
    }
    catch (e)
    {
      Loaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }

  }