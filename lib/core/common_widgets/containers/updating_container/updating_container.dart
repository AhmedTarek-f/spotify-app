import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';

class UpdatingContainer extends StatelessWidget {
  const UpdatingContainer({
    super.key, required this.containerTitle,this.width =200 ,this.height = 150,
  });
  final String containerTitle;
  final double width,height;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Center(
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: isDarkMode? Colors.white :Colors.black87,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(containerTitle,style: SpotifyFonts.appStylesBold20.copyWith(color: isDarkMode? Colors.black : Colors.white),),
                const SizedBox(height: 16,),
                const CircularProgressIndicator(color: SpotifyColors.primaryColor,),
              ],
            )
        ));
  }
}