import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

abstract class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> init() async{
    await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
    );
    final token = await _firebaseMessaging.getToken();
    log("token: $token");
  }

  static Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
    if(message.notification != null) {
      log("Some notification recived");
    }
  }

}