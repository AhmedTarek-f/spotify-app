import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/discovery/presentation/views/discovery_view.dart';
import 'package:spotify/features/favorites/presentation/views/favorites_view.dart';
import 'package:spotify/features/home/presentation/views/home_view.dart';
import 'package:spotify/features/profile/presentation/views/profile_view.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  final RxInt selectedIndex = 0.obs;

  final List<Widget> mainViews = const [
    HomeView(),
    DiscoveryView(),
    FavoritesView(),
    ProfileView(),
  ];

  void changeSelectedIndex(int value){
    selectedIndex.value = value;
  }
}