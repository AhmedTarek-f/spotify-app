import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_images.dart';
import 'package:spotify/features/on_boarding/choose_mode/presentation/views/widgets/circle_theme_choice.dart';

class LightOrDarkModeChoice extends StatelessWidget {
  const LightOrDarkModeChoice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        CircleThemeChoice(
          CircleBackgroundColor:const Color(0xff3B3538),
          svgIcon: SpotifyImages.moonIcon,
          title: "Dark Mode",
          onTap: (){},
        ),
        const SizedBox(width: 71,),
        CircleThemeChoice(
          CircleBackgroundColor:const Color(0xff31393C),
          svgIcon: SpotifyImages.sunIcon,
          title: "Light Mode",
          onTap: (){},
        ),
      ],
    );
  }
}
