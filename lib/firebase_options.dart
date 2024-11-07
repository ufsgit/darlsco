// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDYIO69XHUWOBoJ7JpiGjHCNdiWSXTWDgo',
    appId: '1:917044543784:web:0d8b85ed679083d49a501d',
    messagingSenderId: '917044543784',
    projectId: 'darlsco',
    authDomain: 'darlsco.firebaseapp.com',
    storageBucket: 'darlsco.appspot.com',
    measurementId: 'G-GL4M75ERK6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB16xImBAsMAp3lROKoWfYmd7grtoxhwWc',
    appId: '1:917044543784:android:ac062583466829a29a501d',
    messagingSenderId: '917044543784',
    projectId: 'darlsco',
    storageBucket: 'darlsco.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBP7TAGIVXkkX1dcSngpOFMc6-d0weRlos',
    appId: '1:917044543784:ios:a73dba7300f2bddd9a501d',
    messagingSenderId: '917044543784',
    projectId: 'darlsco',
    storageBucket: 'darlsco.appspot.com',
    iosBundleId: 'com.inspection.darlsco',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBP7TAGIVXkkX1dcSngpOFMc6-d0weRlos',
    appId: '1:917044543784:ios:8b1fb5ae540c50da9a501d',
    messagingSenderId: '917044543784',
    projectId: 'darlsco',
    storageBucket: 'darlsco.appspot.com',
    iosBundleId: 'com.inspection.darlsco.RunnerTests',
  );
}
