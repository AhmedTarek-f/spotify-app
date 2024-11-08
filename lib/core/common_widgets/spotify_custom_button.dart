import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_fonts.dart';

class SpotifyCustomButton extends StatelessWidget {
  const SpotifyCustomButton({super.key, this.onPressed, required this.buttonTitle, this.buttonColor=const Color(0xff42C83C), this.titleStyle, this.width, this.height});
  final void Function()? onPressed;
  final String buttonTitle;
  final Color? buttonColor;
  final TextStyle? titleStyle;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width,
      height: height ?? MediaQuery.sizeOf(context).height*0.1090,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:buttonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: onPressed,
        child: Text(buttonTitle,style: titleStyle ?? SpotifyFonts.appStylesBold22.copyWith(color:  const Color(0xffF6F6F6)),),
      ),
    );
  }
}