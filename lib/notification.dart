import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

// This needs to be added to your main.dart as a top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling background message: ${message.messageId}');
  // Add any background message handling logic here
}

class FirebaseNotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  static Future<void> initialize() async {
    try {
      // Set up background message handler
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // Request permissions and initialize settings
      await _setupNotifications();
      
      // Handle foreground messages
      await _setupForegroundMessaging();
      
      // Handle notification clicks when app is terminated/closed
      await _handleInitialMessage();
      
      // Get the token
      await getNotificationToken();
      
      log('Firebase Notification Service initialized successfully');
    } catch (e, stackTrace) {
      log('Error initializing Firebase Notification Service', 
          error: e, stackTrace: stackTrace);
    }
  }

  static Future<void> _setupNotifications() async {
    try {
      // Request notification permission
      await Permission.notification.request();
      
      // Request Firebase permissions
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Create the Android notification channel
      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);

      // Initialize local notifications
      await _localNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        ),
        onDidReceiveNotificationResponse: _handleNotificationTap,
      );
    } catch (e) {
      log('Error setting up notifications', error: e);
    }
  }

  static Future<void> _setupForegroundMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });
  }

  static Future<void> _handleInitialMessage() async {
    RemoteMessage? initialMessage = 
        await FirebaseMessaging.instance.getInitialMessage();
        
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Handle notification taps when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  static void _handleMessage(RemoteMessage message) {
    log('Handling message: ${message.messageId}');
    // Add your message handling logic here
    // For example, navigate to a specific screen based on the message
  }

  static void _handleNotificationTap(NotificationResponse response) {
    log('Notification tapped: ${response.payload}');
    // Add your notification tap handling logic here
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final RemoteNotification? notification = message.notification;
    final AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: android.smallIcon,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data.toString(),
      );
    }
  }

  static Future<String?> getNotificationToken() async {
    try {
      final notificationStatus = await Permission.notification.status;
      log('Notification permission status: $notificationStatus');

      if (notificationStatus.isDenied) {
        log('Requesting notification permission...');
        final status = await Permission.notification.request();
        if (status.isDenied) {
          log('Notification permission denied');
          return null;
        }
      }
      _firebaseMessaging.subscribeToTopic('topic');
      // final token = await _firebaseMessaging.getToken();
      // log('FCM Token: $token');
      return 'token';
    } catch (e) {
      log('Error getting FCM token', error: e);
      return null;
    }
  }

  // Method to subscribe to topics
  static Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // Method to unsubscribe from topics
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}