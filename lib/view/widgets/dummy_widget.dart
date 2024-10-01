import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/common_widgets.dart';
import '../../core/constants/image_url.dart';

class DummyWidget extends StatelessWidget {
  const DummyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
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
}
