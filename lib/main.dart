import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spotify/core/constants/api_keys.dart';
import 'package:spotify/core/utlis/functions/setup_service_locator.dart';
import 'package:spotify/core/utlis/notifications/local_notifications/local_notifications.dart';
import 'package:spotify/core/utlis/notifications/push_notifications/push_notifications.dart';
import 'package:spotify/features/authentication/data/repository/authentication_repository.dart';
import 'package:spotify/firebase_options.dart';
import 'package:spotify/spotify_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async{
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  setupServiceLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository())
  );
  await Supabase.initialize(
    url: projectUrl,
    anonKey: anonKey,
  );
  await LocalNotifications.init();
  await PushNotifications.init();
  FirebaseMessaging.onBackgroundMessage(PushNotifications.firebaseBackgroundMessage);
  FirebaseMessaging.onMessage.listen((RemoteMessage message){
    if(message.notification != null){
      String payloadData = jsonEncode(message.data);
      LocalNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData
      );
    }
  });
  runApp(const SpotifyApp());
}
