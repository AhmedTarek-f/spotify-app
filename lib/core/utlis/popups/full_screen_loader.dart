import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/utlis/loaders/t_animation_loader_widget.dart';

abstract class TFullScreenLoader
{
  static void openLoadingDialog(String text, String animation)
  {
    final bool isDarkMode = Theme.of(Get.context!).brightness == Brightness.dark;
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
            child: Container(
              color: isDarkMode?SpotifyColors.dark: Colors.white,
              width: Get.width,
              height: Get.height,
              child: Column(
                children: [
                  const SizedBox(height: 200,),
                  TAnimationLoaderWidget(text: text, animation: animation,)
                ],
              ),
            )
        ),

    );
  }

  static void stopLoading()
  {
    Navigator.of(Get.overlayContext!).pop();
  }
}