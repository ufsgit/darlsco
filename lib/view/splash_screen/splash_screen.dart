import 'package:darlsco/view/user_block/user_block_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/controller/upcoming_inspections/upcoming_inspection_controller.dart';

import 'package:darlsco/main.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/training/training_inspection_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/common_widgets.dart';

import '../../core/constants/image_url.dart';
import '../training/widgets/bottom_navigation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UpcomingInspectionsController upcontroller =
      Get.put(UpcomingInspectionsController());
  AppUpdateInfo? updateInfo;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    mainInitFunction();

    // homeController.numberTextList = [
    //   '0',
    //   '0',
    //   '${upcontroller.upcomingInspectionListData.length}',
    //   '${homeController.customerLocations.length}'
    // ];

    super.initState();
  }

  mainInitFunction() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      const String version = '1.0.12';
      await homeController.versionCheck(version, context);
      if (homeController.isAppBlocked.value) {
        Get.to(() => const UserBlockScreen());
        return;
      }
      _deleteCacheDir();
      SharedPreferences preferences = await SharedPreferences.getInstance();

      String token = preferences.getString('token') ?? '';
      String customerType = preferences.getString('type') ?? '';

      print(packageInfo.version);
      if (token != '' && customerType == 'customer') {
        bool? verifyProfile = await homeController.verifyCustomerProfile();
        if (verifyProfile == false) {
          await loginController.logout(context);

          //  Get.offAll(() =>const   ProfilePage(isEdit: false,isFromHomePage: false,isFromPurchase: false,));
        }
      }

      await homeController.isUsersignedIn();

      getcountry(context);
      // Future.delayed(const Duration(seconds: 2), () async {
      await checkUserType();
    } catch (e) {
      //  errorLoggingSnackbaR(context, functionName: 'mainInitFunction', error: e.toString());
    }
    // if(Platform.isAndroid ){
    //   await checkForUpdate(setState);

    // }

    // if (updateInfo != null) {
    //   if (updateInfo!.updateAvailability ==
    //       UpdateAvailability.updateAvailable) {
    //     InAppUpdate.startFlexibleUpdate();
    //   } else {
    //     homeController.isUsersignedIn();

    //      getcountry();
    //     // Future.delayed(const Duration(seconds: 2), () async {
    //     await checkUserType();
    //   }
    // } else {
    //   homeController.isUsersignedIn();

    //    getcountry();
    //   // Future.delayed(const Duration(seconds: 2), () async {
    //   await checkUserType();
    // }

    // homeController.versionCheck(packageInfo.version);
    // await MessageHandler. initNotifications();

//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: (value) async {
//     // Get.to(()=>UpcomingInspectionsScreen());
//   });

//   await Firebase.initializeApp(
//       options: kIsWeb
//           ? DefaultFirebaseOptions.web
//           : Platform.isAndroid
//               ? DefaultFirebaseOptions.android
//               : Platform.isIOS
//                   ? DefaultFirebaseOptions.ios
//                   : DefaultFirebaseOptions.android);
//   final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//       await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
// // String? payload = notificationAppLaunchDetails!.payload;
//   final didNotificationLaunchApp =
//       notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

//   if (didNotificationLaunchApp) {
//     // var payload = notificationAppLaunchDetails!.notificationResponse;
//     // print(payload);
//     // onSelectNotification(payload!);
//     // saveLocal(payload.toString(), "localdata");
//     // onSelectNotification(

//     //   );
//   } else {
//     // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//     //     onDidReceiveNotificationResponse: onSelectNotification,
//     //     onDidReceiveBackgroundNotificationResponse: onSelectNotification);
//   }

//   // payload= notificationAppLaunchDetails!.payload;
//   // if (payload != null) {
//   //   routeToGo = '/Interview';
//   //   navigatorKey.currentState?.pushNamed('/Interview');
//   // }

//   // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//   //   if (message.notification!.body != null) {
//   //     SharedPreferences preferences = await SharedPreferences.getInstance();
//   //     final userType = preferences.getString('type');

//   //     switch (userType) {
//   //       case 'user':
//   //         Get.to(() => const TrainingInspectionScreen());

//   //         break;
//   //       case 'customer':
//   //         Get.to(() => UpcomingInspectionsScreen());
//   //         break;
//   //       default:
//   //         Get.to(() => const BottomNavigationScreen());
//   //     }
//   //   }
//   // });
//   // await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//   // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//   //     alert: true, badge: true, sound: true);
//   // NotificationService.messageNotificationRequest();
//   // FirebaseMessaging.instance.getNotificationSettings();

//   // FirebaseMessaging.instance.getInitialMessage();

//   // MessageHandler.onMessageListener(messageStreamController);
//   // FirebaseMessaging.onBackgroundMessage(
//   //     MessageHandler.firebaseMessagingBackgroundHandler);

//   // FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    // Get.off(
    //   () => const BottomNavigationScreen(),
    // );
    // });
  }

  Future<void> _deleteCacheDir() async {
    try {
      var tempDir = await getTemporaryDirectory();

      if (await tempDir.exists()) {
        tempDir.deleteSync(recursive: true);
      }
    } catch (e) {
      //  errorLoggingSnackbaR(context, functionName: '_deleteCacheDir', error: e.toString());
    }
  }

  checkUserType() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String customerType = sharedPreferences.getString('type') ?? '';
    print('dfwrf $customerType');
    switch (customerType) {
      case 'user':
        Get.offAll(() => const TrainingInspectionScreen());
        // Get.offAll(() => const SampleUserSection());
        break;
      case 'customer':
        Get.offAll(() => BottomNavigationWidget());
        // Get.offAll(() => const SampleBottomNavWidget(isLoggedIn: true));

        break;
      default:
        Get.offAll(() => BottomNavigationWidget());
        // Get.offAll(()=>const SampleBottomNavWidget(isLoggedIn: false));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: commonBackgroundLinearColor(
          childWidget: Center(
        child: Image.asset(
          splashScreenLogo,
          width: 210.w,
          height: 98.h,
        ),
      )),
    );
  }

  // Future<void> checkForUpdate(setState) async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     setState(() {
  //       updateInfo = info;
  //       print(updateInfo?.updateAvailability.toString());
  //     });

  //     if (updateInfo != null) {
  //       if (updateInfo!.updateAvailability ==
  //           UpdateAvailability.updateAvailable) {
  //         InAppUpdate.startFlexibleUpdate();
  //       }
  //     }
  //   }).catchError((e) {
  //     print(e.toString());
  //   });
  // }
}
