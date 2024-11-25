
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/common_widgets/shimmer/new_album_shimmer.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/album_container.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class NewAlbumsListView extends StatelessWidget {
  const NewAlbumsListView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.1398,
      child: Obx(
        ()=> controller.isNewAlbumsLoading.value? const NewAlbumShimmer():ListView.separated(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => AlbumContainer(newAlbum: controller.newAlbums.elementAt(index),),
          separatorBuilder: (_, __) => const SizedBox(width: 12,),
          itemCount: controller.newAlbums.length,
        ),
      ),
    );
  }
}
