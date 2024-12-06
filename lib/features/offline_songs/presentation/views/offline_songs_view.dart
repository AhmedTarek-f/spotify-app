import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/offline_songs/presentation/views/widgets/offline_songs_bottom_nav.dart';
import 'package:spotify/features/offline_songs/presentation/views/widgets/offline_songs_view_body.dart';
import 'package:spotify/features/offline_songs/presentation/views_model/offline_songs_controller.dart';

class OfflineSongsView extends StatelessWidget {
  const OfflineSongsView({super.key,});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OfflineSongsController());
    return   Scaffold(
      body: const OfflineSongsViewBody(),
      bottomNavigationBar: Obx(()=> (!controller.isPlaying.value)? const SizedBox.shrink() : const OfflineSongsBottomNav() ),
    );
  }

}