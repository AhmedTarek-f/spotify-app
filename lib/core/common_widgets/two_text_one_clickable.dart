import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_colors.dart';

class TwoTextOneClickable extends StatelessWidget {
  const TwoTextOneClickable({
    super.key,
    required this.firstPart,
    required this.secondClickablePart,
    this.onClicked,
    this.onClickedSplashColor,
    this.onClickedHighlightColor,
  });
  final Text firstPart;
  final Text secondClickablePart;
  final void Function()? onClicked;
  final Color? onClickedSplashColor;
  final Color? onClickedHighlightColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        firstPart,
        InkWell(
          onTap: onClicked,
          borderRadius: BorderRadius.circular(30),
          splashColor: onClickedSplashColor ?? SpotifyColors.primaryColor.withOpacity(0.5),
          highlightColor: onClickedHighlightColor ?? SpotifyColors.primaryColor.withOpacity(0.2),
          child: secondClickablePart,
        ),
      ],
    );
  }
}
