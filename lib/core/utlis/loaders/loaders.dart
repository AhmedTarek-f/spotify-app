import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:spotify/core/constants/spotify_colors.dart';

abstract class Loaders {

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
          duration:  const Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          content: Container(
            padding:  const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(Get.context!).brightness == Brightness.dark ? SpotifyColors.darkerGrey.withOpacity(0.9) : SpotifyColors.darkGrey.withOpacity(0.9),
            ),
            child: Center(child: Text(message,style: Theme.of(Get.context!).textTheme.labelLarge,),),
          )
      ),
    );
  }

  static successSnackBar ({required title, message ="",int secondsDuration = 3})
  {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: SpotifyColors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
      duration:  Duration(seconds: secondsDuration),
      margin:  const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2_copy,color: Colors.white,),
    );
  }
  static warningSnackBar ({required title, message =""})
  {
    Get.snackbar(
        title,
        message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration:  const Duration(seconds: 3),
      margin:  const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2_copy,color: Colors.white,),
    );
  }
  static errorSnackBar ({required title, message =""})
  {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration:  const Duration(seconds: 3),
      margin:  const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2_copy,color: Colors.white,),
    );
  }
}