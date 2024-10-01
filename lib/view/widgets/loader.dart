import 'package:darlsco/core/constants/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Loader {
  static showLoader() {
    showDialog(
        barrierDismissible: false,
        barrierColor: ColorResources.color294C73.withOpacity(0.2),
        context: Get.context!,
        builder: (ctx) => Center(
              child: CircularProgressIndicator(
                strokeWidth: 3.sp,
                color: ColorResources.color294C73,
              ),
            ));
  }

  static stopLoader() {
    Get.back(closeOverlays: true);
  }
}
