import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/home_app_bar.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/home_drawer.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/home_view_body.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return const Scaffold(
      appBar: HomeAppBar(),
      endDrawer: HomeDrawer(),
      body:  HomeViewBody()
    );
  }
}


