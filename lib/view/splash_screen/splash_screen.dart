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
  final UpcomingInspectionsController upcontroller = Get.put(UpcomingInspectionsController());
  AppUpdateInfo? updateInfo;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    mainInitFunction();

    super.initState();
  }

  mainInitFunction() async {
    try {
      loginController.isFromSplashOrLogin = true;
      const String version = '1.0.15';
      // 16 // ====> LATEST
      await homeController.versionCheck(version, context);
      if (homeController.isAppBlocked.value) {
        Get.to(() => const UserBlockScreen());
        return;
      }
      _deleteCacheDir();
      SharedPreferences preferences = await SharedPreferences.getInstance();

      String token = preferences.getString('token') ?? '';
      String customerType = preferences.getString('type') ?? '';

      if (token != '' && customerType == 'customer') {
        bool? verifyProfile = await homeController.verifyCustomerProfile();
        if (verifyProfile == false) {
          await loginController.logout(context);

        }
      }

      await homeController.isUsersignedIn();
      getcountry(context);
      await checkUserType();
    } catch (e) {
    }
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
    switch (customerType) {
      case 'user':
        Get.offAll(() => const TrainingInspectionScreen());
        // Get.offAll(() => const SampleUserSection());
        break;
      case 'customer':
        Get.offAll(() => BottomNavigationWidget());

        break;
      default:
        Get.offAll(() => BottomNavigationWidget());
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
