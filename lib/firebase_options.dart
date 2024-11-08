// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDNT6W_U1ju6nuCw-aJLMhDsMpICkDttdc',
    appId: '1:274402675206:web:b9cdb2087b92706887d187',
    messagingSenderId: '274402675206',
    projectId: 'darlsco-inspection-services',
    authDomain: 'darlsco-inspection-services.firebaseapp.com',
    storageBucket: 'darlsco-inspection-services.firebasestorage.app',
    measurementId: 'G-D9ME7QEBYG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfdWACvw_WqK-CTBJYQiLIjE6cHBSY-Og',
    appId: '1:274402675206:android:a9567d5591cdd47787d187',
    messagingSenderId: '274402675206',
    projectId: 'darlsco-inspection-services',
    storageBucket: 'darlsco-inspection-services.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVUvNTuX03K18DHp9LL3xg0TI5_zQTckA',
    appId: '1:274402675206:ios:d27055e01a3a749087d187',
    messagingSenderId: '274402675206',
    projectId: 'darlsco-inspection-services',
    storageBucket: 'darlsco-inspection-services.firebasestorage.app',
    iosBundleId: 'com.inspection.darlsco',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVUvNTuX03K18DHp9LL3xg0TI5_zQTckA',
    appId: '1:274402675206:ios:d27055e01a3a749087d187',
    messagingSenderId: '274402675206',
    projectId: 'darlsco-inspection-services',
    storageBucket: 'darlsco-inspection-services.firebasestorage.app',
    iosBundleId: 'com.inspection.darlsco',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDNT6W_U1ju6nuCw-aJLMhDsMpICkDttdc',
    appId: '1:274402675206:web:0f297f687b9c869787d187',
    messagingSenderId: '274402675206',
    projectId: 'darlsco-inspection-services',
    authDomain: 'darlsco-inspection-services.firebaseapp.com',
    storageBucket: 'darlsco-inspection-services.firebasestorage.app',
    measurementId: 'G-DCZ8MKBT2P',
  );
}
