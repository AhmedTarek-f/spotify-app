import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/features/discovery/presentation/discovery/views/discovery_view.dart';
import 'package:spotify/features/favorites/presentation/views/favorites_view.dart';
import 'package:spotify/features/favorites/presentation/views_model/favorites_controller.dart';
import 'package:spotify/features/home/presentation/home/views/home_view.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';
import 'package:spotify/features/profile/presentation/views/profile_view.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  final RxInt selectedIndex = 0.obs;
  final player = getIt.get<AudioPlayer>();

  final List<Widget> mainViews = const [
    HomeView(),
    DiscoveryView(),
    FavoritesView(),
    ProfileView(),
  ];

  void changeSelectedIndex(int value)async{
    selectedIndex.value = value;
    if(selectedIndex.value ==2)
    {
      HomeController.instance.songsListPlaying.clear();
       if(player.playing) await player.stop();
      if(Get.isRegistered<FavoritesController>()){
        FavoritesController.instance.isPlaying.value = false;
        await FavoritesController.instance.player.value.pause();
      }
    }
    else{
      if(Get.isRegistered<FavoritesController>() && FavoritesController.instance.isPlaying.value){
        FavoritesController.instance.player.value.stop();
      }
    }

  }
}