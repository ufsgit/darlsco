import 'dart:isolate';

// import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:darlsco/app_%20config/all_countries.dart';
import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/firebase_options.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart' as loc;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_strategy/url_strategy.dart';

import 'view/splash_screen/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final messageStreamController = BehaviorSubject<RemoteMessage>();
const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'));

SendPort? uiSendPort;
final callbackPort = ReceivePort();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // setPathUrlStrategy();
  // await Firebase.initializeApp();

// final channel =  IOWebSocketChannel.connect( Uri.parse('wss://192.168.1.94:4510')    );

//      channel.sink.add('Hello from ufs!');

  runApp(const MyApp());
}

// Future<void> configureAmplify() async {
//   try {
//     await Amplify.addPlugins([AmplifyStorageS3()]);
//     await Amplify.configure(amplifyconfig);
//     print('Amplify initialized successfully');
//   } catch (e) {
//     print('Failed to initialize Amplify: $e');
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size.width > 615 &&
              MediaQuery.of(context).size.width < 1440
          ? const Size(834, 700)
          : MediaQuery.of(context).size.width < 615
              ? const Size(390, 890.2446)
              : const Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          // scaffoldMessengerKey: scaffoldMessengerKey,
          title: 'Darlsco',

          debugShowCheckedModeBanner: false,
          // routes: {
          //   '/cart': (context) => const CartScreen(),
          // },
          initialRoute: '/',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF4F7FA),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white)),
            dialogTheme: const DialogTheme(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              shadowColor: Colors.black26,
            ),
            fontFamily: GoogleFonts.roboto().fontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: child,
          supportedLocales: const [
            Locale("af"),
            Locale("am"),
            Locale("ar"),
            Locale("az"),
            Locale("be"),
            Locale("bg"),
            Locale("bn"),
            Locale("bs"),
            Locale("ca"),
            Locale("cs"),
            Locale("da"),
            Locale("de"),
            Locale("el"),
            Locale("en"),
            Locale("es"),
            Locale("et"),
            Locale("fa"),
            Locale("fi"),
            Locale("fr"),
            Locale("gl"),
            Locale("ha"),
            Locale("he"),
            Locale("hi"),
            Locale("hr"),
            Locale("hu"),
            Locale("hy"),
            Locale("id"),
            Locale("is"),
            Locale("it"),
            Locale("ja"),
            Locale("ka"),
            Locale("kk"),
            Locale("km"),
            Locale("ko"),
            Locale("ku"),
            Locale("ky"),
            Locale("lt"),
            Locale("lv"),
            Locale("mk"),
            Locale("ml"),
            Locale("mn"),
            Locale("ms"),
            Locale("nb"),
            Locale("nl"),
            Locale("nn"),
            Locale("no"),
            Locale("pl"),
            Locale("ps"),
            Locale("pt"),
            Locale("ro"),
            Locale("ru"),
            Locale("sd"),
            Locale("sk"),
            Locale("sl"),
            Locale("so"),
            Locale("sq"),
            Locale("sr"),
            Locale("sv"),
            Locale("ta"),
            Locale("tg"),
            Locale("th"),
            Locale("tk"),
            Locale("tr"),
            Locale("tt"),
            Locale("uk"),
            Locale("ug"),
            Locale("ur"),
            Locale("uz"),
            Locale("vi"),
            Locale("zh")
          ],
          localizationsDelegates: const [
            CountryLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      },
      // child: const SplashScreen(),
      child: const SplashScreen(),
    );
  }
}

getNotificationToken() async {
  try {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    PermissionStatus notificationStatus = await Permission.notification.status;
    print('FCM status $notificationStatus');
    if (!notificationStatus.isDenied) {
      print('FCM status requesting permission.....');

      NotificationSettings notificationSettings =
          await firebaseMessaging.requestPermission();
      print('FCM NOT SETT ${notificationSettings.alert}');
    } else if (!notificationStatus.isGranted) {
      String? token = await firebaseMessaging.getToken();
      print('FCM TOKEN $token');
    }
  } catch (e) {
    print('FCM ERROR $e');
  }
}

getcountry(BuildContext context) async {
  try {
    homeController.isFromPurchase.value = false;
    if (!kIsWeb) {
      PermissionStatus locationStatus = await Permission.location.status;

      if (locationStatus.isDenied) {
        locationStatus = await Permission.location.request();
      }
      PermissionStatus storageStatus = await Permission.storage.status;
      print('hiii permission asked $storageStatus');

      if (storageStatus.isDenied) {}
      storageStatus = await Permission.storage.request();
      // print(locationStatus);
      // if (locationStatus.isPermanentlyDenied) {
      //   await openAppSettings();

      // }

      if (!locationStatus.isDenied) {
        // requestLocationPermission(context);

        // loginController.countryCode.value=
        homeController.currentCountryCode.value =
            await getCountryName(context) ?? '';

        print(homeController.currentCountryCode);
      }
    }
  } catch (e) {
    //    errorLoggingSnackbaR(context,
    //       filename: 'main',
    //       functionName: 'getcountry',
    //       lineNumber: '180');
    // }
//     homeController.update();
//    loginController. update();
  }
}

// accessLocation() async {
//   PermissionStatus status = await Permission.location.request();
//   print('sfwjr $status');
//   if (status.isGranted) {
//     print('Location permissionsdfqa granted.');
//   } else if (status.isDenied) {
//     print('Location permission denied.');
//   } else if (status.isPermanentlyDenied) {
//     print(
//         'Location permission permanently denied. Please enable it in settings.');
//   }
// }

Future<bool> requestLocationPermission(BuildContext context) async {
  final loc.Location location = loc.Location();
  bool serviceStatus = await location.serviceEnabled();
  if (!serviceStatus) {
    // Request to enable location services
    serviceStatus = await location.requestService();
  }
  if (serviceStatus) {
    //  ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Please turn on devices location')));
    return true;
    // Location services are enabled, you can proceed with your logic
  } else {
    return false;
    // Inform the user to enable location services
  }
  // bool serviceEnabled;
  // LocationPermission permission;

  // // Test if location services are enabled.
  // try {
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     print('dfsdf');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Please turn devices location')));
  //     return Future.error('Location services are disabled.');
  //   }
  //   if (serviceEnabled) {
  //     // await accessLocation();
  //   }
  //   permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return false;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return false;
  //   }

  //   return true;
  // } catch (e) {
  //   // errorLoggingSnackbaR(context,
  //   //     filename: 'main',
  //   //     functionName: 'requestLocationPermission',
  //   //     lineNumber: '209');
  //   return false;
  // }
}

Future<String?> getCountryName(BuildContext context) async {
  print('start');
  try {
    bool isLocationAccessed = await requestLocationPermission(context);
    if (isLocationAccessed) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('end');
      List<Placemark> address =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark placeMark = address.first;
      print('efgsgsnd${address.first}');
      String country = placeMark.isoCountryCode ?? '';

      loginController.countryCode.value = Countries.allCountries
              .where(
                  (item) => item['code'] == placeMark.isoCountryCode.toString())
              .toList()[0]['dial_code'] ??
          '';
      print('inital country code    ${loginController.countryCode.value}');
      print(placeMark.administrativeArea);
      print('end');
      return country;
    } else {
      return null;
    }
    // Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // debugPrint('location: ${position.latitude}');
    // final coordinates =  Coordinates(position.latitude, position.longitude);
    // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // var first = addresses.first;
    // this will return country name
  } catch (e) {
    // errorLoggingSnackbaR(context, functionName: functionName, filename: filename, lineNumber: lineNumber)
  }
  return null;
}

// errorLoggingSnackbaR(BuildContext context,
//     {required String functionName,
//     required String filename,
//     required String lineNumber}) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content:
//           Text('Error in $functionName function $filename.dart $lineNumber')));
// }
