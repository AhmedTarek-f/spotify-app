import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction =false,
    this.actionText,
    this.onActionPressed
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,width: MediaQuery.sizeOf(context).width*0.8),
          const SizedBox(height: 24,),
          Text(
            text,
            style: SpotifyFonts.appStylesMedium16,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
          const SizedBox(height: 24,),
          if(showAction)SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(backgroundColor: Colors.grey.shade700),
              child: Text(
                actionText ?? "",
                style: SpotifyFonts.appStylesMedium16.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
