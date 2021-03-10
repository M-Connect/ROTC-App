import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialise() async {
    if (Platform.isIOS) {
      // request permissions if we're on android
      _fcm.requestPermission();
    }
  }
}