import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spotify/core/constants/api_keys.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';
import 'package:spotify/firebase_options.dart';

import 'package:spotify/spotify_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setupServiceLocator();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository())
  );
  await Supabase.initialize(
    url: projectUrl,
    anonKey: anonKey,
  );

  runApp(const SpotifyApp());
}

