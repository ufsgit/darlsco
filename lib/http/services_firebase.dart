import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
// static final _notification = FlutterLocalNotificationsPlugin();
  static final messaging = FirebaseMessaging.instance;
  static void init(FlutterLocalNotificationsPlugin notification) {
    notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
  }

  static messageNotificationRequest() async {
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
    }
  }

  static getFirbaseToken() async {
    String? token = await messaging.getToken();

    if (kDebugMode) {
      print('Registration Token=$token');
    }
  }
}
