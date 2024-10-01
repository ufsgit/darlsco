import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({super.key, required this.mobile, required this.tab});
  final Widget mobile;
  final Widget tab;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Get.width > 615 ? tab : mobile;
    });
  }
}
