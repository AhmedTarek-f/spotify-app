import 'package:flutter/material.dart';
import 'package:spotify/core/constants/spotify_colors.dart';
import 'package:spotify/core/theme/custom_theme/spotify_app_bar.dart';
import 'package:spotify/core/theme/custom_theme/spotify_text_form_field_theme.dart';

abstract class SpotifyAppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Satoshi",
    brightness: Brightness.light,
    primaryColor: SpotifyColors.primaryColor,
    scaffoldBackgroundColor: Color(0xffF2F2F2),
    appBarTheme: SpotifyAppBar.lightAppBarTheme,
    inputDecorationTheme: SpotifyTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: "Satoshi",
      brightness: Brightness.dark,
      primaryColor: SpotifyColors.primaryColor,
      scaffoldBackgroundColor: Color(0xff1C1B1B),
      appBarTheme: SpotifyAppBar.darkAppBarTheme,
      inputDecorationTheme: SpotifyTextFormFieldTheme.darkInputDecorationTheme
  );
}