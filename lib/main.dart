import 'dart:io';
import 'dart:isolate';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:darlsco/app_%20config/all_countries.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/controller/network/network_helper.dart';
import 'package:darlsco/firebase_options.dart';
import 'package:darlsco/http/http_urls.dart';
import 'package:darlsco/notification.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/telr/network_helper_class.dart';
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
import 'package:google_fonts/google_fonts.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import 'view/splash_screen/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final messageStreamController = BehaviorSubject<RemoteMessage>();
const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'));

SendPort? uiSendPort;
final callbackPort = ReceivePort();
bool isConnected =true;
Future<void> main() async {
  print(HttpUrls.baseUrl);
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  await FirebaseNotificationService.initialize();
  // NetworChecker().initConnectivity();

  // NetworChecker.connectivitySubscription = NetworChecker
  //     .connectivity.onConnectivityChanged
  //     .listen(NetworChecker().updateConnectionStatus);

  runApp(const MyApp());
}

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
          title: 'Darlsco',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          theme: ThemeData(
            dropdownMenuTheme: DropdownMenuThemeData(
              inputDecorationTheme: InputDecorationTheme(
                
              )
            ),
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
      child: const SplashScreen(),
    );
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

      if (storageStatus.isDenied) {}
      storageStatus = await Permission.storage.request();

      if (!locationStatus.isDenied) {
        homeController.currentCountryCode.value =
            await getCountryName(context) ?? '';
      }
    }
  } catch (e) {}
}

Future<bool> requestLocationPermission(BuildContext context) async {
  final loc.Location location = loc.Location();
  bool serviceStatus = await location.serviceEnabled();
  if (!serviceStatus) {
    serviceStatus = await location.requestService();
  }
  if (serviceStatus) {
    return true;
  } else {
    return false;
  }
}

Future<String?> getCountryName(BuildContext context) async {
  try {
    bool isLocationAccessed = await requestLocationPermission(context);
    if (isLocationAccessed) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> address =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark placeMark = address.first;
      String country = placeMark.isoCountryCode ?? '';

      loginController.countryCode.value = Countries.allCountries
              .where(
                  (item) => item['code'] == placeMark.isoCountryCode.toString())
              .toList()[0]['dial_code'] ??
          '';
      print(placeMark.administrativeArea);
      return country;
    } else {
      return null;
    }
  } catch (e) {}
  return null;
}
