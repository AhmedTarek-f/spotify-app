import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/presentation/home/views_model/home_controller.dart';

class LightThemeSwitch extends StatelessWidget {
  const LightThemeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Row(
      children: [
        const Text("Light Theme",style:  SpotifyFonts.appStylesBold18,),
        const SizedBox(width: 12,),
        Obx(
              ()=> Switch(
            thumbIcon: WidgetStateProperty. resolveWith<Icon?>((Set<WidgetState> states) {
              return const Icon(Icons.light_mode,color: Colors.yellowAccent,);
            }),
            value: !controller.isDarkMode.value,
            onChanged: (value) => controller.toggleThemeMode(),
          ),
        )
      ],
    );
  }
}
