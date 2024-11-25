import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/utlis/loaders/animation_loader_widget.dart';

abstract class FullScreenLoader
{
  static void openLoadingDialog(String text, String animation , BuildContext context)
  {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showDialog(
        context: context,
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
                  AnimationLoaderWidget(text: text, animation: animation,)
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