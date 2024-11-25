import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/home/presentation/home_search/views/widgets/home_search_app_bar.dart';
import 'package:spotify/features/home/presentation/home_search/views/widgets/home_search_view_body.dart';
import 'package:spotify/features/home/presentation/home_search/views_model/home_search_controller.dart';

class HomeSearchView extends StatelessWidget {
  const HomeSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeSearchController());
    return const Scaffold(
      appBar: HomeSearchAppBar(),
      body: HomeSearchViewBody(),
    );
  }
}

