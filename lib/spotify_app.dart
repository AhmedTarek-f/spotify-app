import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/core/theme/spotify_app_theme.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';

class SpotifyApp extends StatelessWidget {
  const SpotifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationRepository authenticationRepository = AuthenticationRepository.instance;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: authenticationRepository.isDarkMode() == null? ThemeMode.system : authenticationRepository.initTheme(),
      theme: SpotifyAppTheme.lightTheme,
      darkTheme: SpotifyAppTheme.darkTheme,
      home: authenticationRepository.redirectedScreen,
    );
  }
}
