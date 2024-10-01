 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/color_resources.dart';

Positioned commonBackButton() {
    return Positioned(
            top: 20.h,
            left: 20.w,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: CircleAvatar(
                radius: 18.h,
                backgroundColor: ColorResources.whiteColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 25.h,
                    color: ColorResources.colorBlack,
                  ),
                ),
              ),
            ),
          );
}