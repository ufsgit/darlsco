import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

class InAppUpdateInfo {
  static AppUpdateInfo? updateInfo;
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool flexibleUpdateAvailable = false;

  static Future<void> checkForUpdate() async {
    await InAppUpdate.checkForUpdate().then((info) {
      updateInfo = info;

      InAppUpdate.startFlexibleUpdate().catchError((e) {
        print(e.toString());
      });
    }).catchError((e) {});
  }

  static void showSnack(String text) {
    if (scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }
}
