import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/theme/spotify_app_theme.dart';
import 'package:spotify/features/on_boarding/get_started/presentation/views/get_started_view.dart';

class SpotifyApp extends StatelessWidget {
  const SpotifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: SpotifyAppTheme.lightTheme,
      darkTheme: SpotifyAppTheme.darkTheme,
      home: const GetStartedView(),
    );
  }
}
