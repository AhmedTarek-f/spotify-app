import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotify/core/constants/spotify_images.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key,});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: (){Get.back();},
      child: CircleAvatar(
        radius: 16,
        backgroundColor: isDarkMode ? const Color(0xff232222) : const Color(0xffE8E8E8),
        child: Center(
          child: SvgPicture.asset(
            SpotifyImages.leftArrowIcon,
            colorFilter: ColorFilter.mode(
              isDarkMode ? const Color(0xffDDDDDD) : const Color(0xff414141),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}