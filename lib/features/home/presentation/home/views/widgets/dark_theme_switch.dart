import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class DarkThemeSwitch extends StatelessWidget {
  const DarkThemeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Row(
      children: [
        const Text("Dark Theme",style:  SpotifyFonts.appStylesBold18,),
        const SizedBox(width: 12,),
        Obx(
              ()=> Switch(
            thumbIcon: WidgetStateProperty. resolveWith<Icon?>((Set<WidgetState> states) {
              return const Icon(Icons.dark_mode,color: Colors.blueAccent,);
            }),
            value: controller.isDarkMode.value,
            onChanged: (value) => controller.toggleThemeMode(),
          ),
        )
      ],
    );
  }
}
