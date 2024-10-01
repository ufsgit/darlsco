// import 'dart:async';

// import 'package:darlsco/view/home/bottom_navigation_screen.dart';
// import 'package:darlsco/view/training/training_inspection_screen.dart';
// import 'package:darlsco/view/up_coming_inspectons/up_coming_inspections_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // titletion
  
//   importance: Importance.high,
// );

// class MessageHandler {
//   static onMessageListener(StreamController messageStreamController) {
//     FirebaseMessaging.onMessage.listen((
//       RemoteMessage message,
//     ) async {
//       if (kDebugMode) {
//         print('Handling a foreground message: ${message.messageId}');
//         print('Message data: ${message.data}');
//         print('Message notification: ${message.notification?.title}');
//         print('Message notification: ${message.notification?.body}');
//       }

//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

//         // print(message.notification!.body != null);
//         // if (message.notification!.body != null) {
//         //   navigatorKey.currentState?.pushNamed('/Interview');
//         // }
//       });
//       // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//       //   await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

//       //  await flutterLocalNotificationsPlugin.show(1, 'judfhjhf', 'dsfdsfs', NotificationDetails(
//       //   android: AndroidNotificationDetails('','', ''),

//       //  ));

//       showNotification(message);

//       //  Get.to(()=>UpcomingInspectionsScreen() );

//       messageStreamController.sink.add(message);
//     });
//   }

//   static Future<void> initNotifications() async {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//          InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: null,
//       macOS: null,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onSelectNotification);
//   }

//   static Future onSelectNotification(notificationResponse) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     final userType = preferences.getString('type');

//     switch (userType) {
//       case 'user':
//         Get.to(() => const TrainingInspectionScreen());

//         break;
//       case 'customer':
//         Get.to(() => UpcomingInspectionsScreen());
//         break;
//       default:
//         Get.to(() => const BottomNavigationScreen());
//     }
//   }

//   static Future<void> showNotification(RemoteMessage message) async {
//      AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//     channel.id,
//      channel.name,
      
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//      NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//      int.tryParse(message.messageId.toString())??0,
//      message.notification?.title,
//      message.notification?.body,
//       platformChannelSpecifics,
//       payload: '1',
//     );
//   }

//   static Future<void> firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp();

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     // initialize notification for android
//     var initialzationSettingsAndroid =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings =
//         InitializationSettings(android: initialzationSettingsAndroid);
//     // flutterLocalNotificationsPlugin.initialize(initializationSettings
//     // );

//     final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//         await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//     String? payload = notificationAppLaunchDetails!.notificationResponse?.payload;
//     final didNotificationLaunchApp =
//         notificationAppLaunchDetails.didNotificationLaunchApp ;

//     if (didNotificationLaunchApp) {
//       // var payload = notificationAppLaunchDetails.payload;
//       // print(payload);
//       // onSelectNotification(payload!);
//       // saveLocal(payload.toString(), "localdata");
//       // onSelectNotification(

//       //   );
//     } else {
//       // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       //     onDidReceiveNotificationResponse: onSelectNotification,
//       //     onDidReceiveBackgroundNotificationResponse: onSelectNotification);
//     }

//     if (kDebugMode) {
//       print("Handling a background message: ${message.messageId}");
//       print('Message data: ${message.data}');
//       print('Message notification: ${message.notification?.title}');
//       print('Message notification: ${message.notification?.body}');
//     }
//   }

//   static Future<void> firebaseMessagingForgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp();

//     if (kDebugMode) {
//       print("Handling a background message: ${message.messageId}");
//       print('Message data: ${message.data}');
//       print('Message notification: ${message.notification?.title}');
//       print('Message notification: ${message.notification?.body}');
//     }
//   }
// }
