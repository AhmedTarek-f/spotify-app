import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/navigation_view/navigation_upper_part.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';

class UnderlinedTitle extends StatelessWidget {
  const UnderlinedTitle({super.key, required this.title, this.titleStyle, this.underlinedStyleWidth=24, this.underlinedStyleHeight=4});
  final String title;
  final TextStyle? titleStyle;
  final double? underlinedStyleWidth,underlinedStyleHeight;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style:titleStyle ?? SpotifyFonts.appStylesMedium20,),
        NavigationUpperPart(width: underlinedStyleWidth,height: underlinedStyleHeight,),
      ],
    );
  }
}
