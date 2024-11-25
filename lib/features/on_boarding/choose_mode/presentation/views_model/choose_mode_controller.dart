import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';

class ChooseModeController extends GetxController {
  static ChooseModeController get instance => Get.find();
  final _deviceStorage = getIt.get<GetStorage>();
  late final RxBool isDarkMode;


  @override
  void onInit() {
    super.onInit();
    final bool isDarkOrLight = _deviceStorage.read("isDarkTheme")!=null?_deviceStorage.read("isDarkTheme"):false;
    isDarkMode = isDarkOrLight.obs;
  }

  Future<void> toggleThemeMode()async{
    await changeThemeMode();
  }

  Future<void> changeThemeMode() async{
    if(Get.isDarkMode && isDarkMode.value)
    {
      await _deviceStorage.write("isDarkTheme", false);
      isDarkMode.value = false;
      ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
    }
    else {
      await _deviceStorage.write("isDarkTheme", true);
      isDarkMode.value = true;
      ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
    }
  }
}