import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/home_app_bar.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/home_drawer.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/home_songs_bottom_nav.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/home_view_body.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return  Scaffold(
          appBar: const HomeAppBar(),
          endDrawer: const HomeDrawer(),
          bottomNavigationBar: Obx(
            ()=>(!controller.songPlayer.value.playing && controller.songsListPlaying.isEmpty)?
            const SizedBox.shrink():
            const HomeSongsBottomNav()
          ),
          body:  const HomeViewBody()
    );
  }
}
