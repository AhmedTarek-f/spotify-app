import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/dark_theme_switch.dart';
import 'package:spotify/features/home/presentation/home/views/widgets/light_theme_switch.dart';

class ThemeDrawerSection extends StatelessWidget {
  const ThemeDrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Theme Mode",style: SpotifyFonts.appStylesBold20.copyWith(decoration: TextDecoration.underline),),
        const SizedBox(height: 22,),
        const LightThemeSwitch(),
        const DarkThemeSwitch(),
      ],
    );
  }
}
