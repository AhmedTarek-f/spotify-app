import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';

class CircleThemeChoice extends StatelessWidget {
  const CircleThemeChoice({
    super.key,
    required this.CircleBackgroundColor, required this.svgIcon, this.title, this.onTap,
  });
  final Color CircleBackgroundColor;
  final String svgIcon;
  final String? title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor: CircleBackgroundColor,
            radius: 36.5,
            child: Center(child: SvgPicture.asset(svgIcon)),
          ),
        ),
        const SizedBox(height: 17,),
        Text(title?? "",style: SpotifyFonts.appStylesMedium17.copyWith(color: const Color(0xffDADADA)),)
      ],
    );
  }
}
