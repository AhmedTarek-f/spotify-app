import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/home/presentation/search/views/songs_search/widgets/songs_search_app_bar.dart';
import 'package:spotify/features/home/presentation/search/views/songs_search/widgets/songs_search_view_body.dart';
import 'package:spotify/features/home/presentation/search/views_model/search_controller.dart';

class SongsSearchView extends StatelessWidget {
  const SongsSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeSearchController());
    return const Scaffold(
      appBar: SongsSearchAppBar(),
      body: SongsSearchViewBody(),
    );
  }
}

