import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NetworChecker {
  static List<ConnectivityResult> connectionStatus = [ConnectivityResult.none];
  static final Connectivity connectivity = Connectivity();
  static late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) {
    //   return Future.value(null);
    // }

    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(List<ConnectivityResult> result) async {
    // setState(() {
    //   _connectionStatus = result;
    // });
    // ignore: avoid_print
    if (result[0] == ConnectivityResult.none) {
      isConnected=false;
      // Get.showSnackbar(GetSnackBar(message: 'No Network Found'));
      print('nbiu');
      
    }
    print('Connectivity changed: ${result}');
  }

}