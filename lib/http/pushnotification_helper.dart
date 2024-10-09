import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationHelper {
  static String fcmToken = "";

  static Future<void> initialized() async {
    await Firebase.initializeApp();
    if (Platform.isAndroid) {
      // local notification initialized

      // NotificationHelper.initialized();
    } else if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission();
    }
    FirebaseMessaging.onBackgroundMessage((backgroundHandler));
    //if App is Terminated state &  used click notification

    getDeviceTokenToSendNotifications();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        print('new notification');
      }
    });

    // App is Forground
    FirebaseMessaging.onMessage.listen((message) {
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        print(message.notification?.title);
        print(message.notification?.body);

        print(message.data);
        NotificationHelper.displayNotification(message);
      }
      //local notification code to display
    });

    //app on background not terminated    

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        print(message.notification?.title);
        print(message.notification?.body);

        print(message.data);
      }
    });
  }

  static getDeviceTokenToSendNotifications() async {
    fcmToken = FirebaseMessaging.instance.getAPNSToken().toString();
    print('devicetoken: $fcmToken');
  }
}

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // static void initialized(){
  //   const AndroidInitializationSettings androidInitializationSettings=AndroidInitializationSettings('@mipmap/ic_launcher');
  //   flutterLocalNotificationsPlugin.initialize(InitializationSettings(
  //   android: androidInitializationSettings,
  //   iOS:IOSInitializationSettings() ,
  //   macOS: MacOSInitializationSettings(),

  // ),onSelectNotification:(details){
  //   print( 'on select $details');

  // } ,);
  // }

  static void displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 100;
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails("Darlsco", "darlsco inspection",
            importance: Importance.max, priority: Priority.high),
      );
      await flutterLocalNotificationsPlugin.show(
          id,
          message.notification?.title,
          message.notification?.body,
          notificationDetails,
          payload: message.data['_id'] ?? '');
    } catch (e) {
      print(e);
    }
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification?.title.toString());
}
