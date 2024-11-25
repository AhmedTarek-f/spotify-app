import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/on_boarding/choose_mode/presentation/views/widgets/circle_theme_choice.dart';
import 'package:spotify/features/on_boarding/choose_mode/presentation/views_model/choose_mode_controller.dart';

class LightOrDarkModeChoice extends StatelessWidget {
  const LightOrDarkModeChoice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChooseModeController());
    return Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Obx(
          ()=> CircleThemeChoice(
            CircleBackgroundColor:const Color(0xff3B3538),
            svgIcon: SpotifyImages.moonIcon,
            title: "Dark Mode",
            svgColor: controller.isDarkMode.value?Colors.blue[900]!:Colors.white,
            titleColor: controller.isDarkMode.value?Colors.blue[900]!:Colors.white,
            onTap: ()async{
              if(!controller.isDarkMode.value){
                await controller.toggleThemeMode();
              }
            },
          ),
        ),
        const SizedBox(width: 71,),
        Obx(
          ()=> CircleThemeChoice(
            CircleBackgroundColor:const Color(0xff31393C),
            svgIcon: SpotifyImages.sunIcon,
            title: "Light Mode",
            svgColor: controller.isDarkMode.value?Colors.white:Colors.yellowAccent,
            titleColor: controller.isDarkMode.value?Colors.white:Colors.yellowAccent,
            onTap: ()async{
              if(controller.isDarkMode.value){
                await controller.toggleThemeMode();
              }
            },
          ),
        ),
      ],
    );
  }
}
