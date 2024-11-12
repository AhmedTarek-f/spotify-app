import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';
import 'package:spotify/firebase_options.dart';

import 'package:spotify/spotify_app.dart';
Future<void> main() async{
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setupServiceLocator();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository())
  );

  runApp(const SpotifyApp());
}

