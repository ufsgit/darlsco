import 'package:darlsco/view/home/about_us_page.dart';
import 'package:darlsco/view/home/widgets/about_us_screen2.dart';
import 'package:darlsco/view/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(mobile: AboutUsScreen2(), tab: AboutUsScreenTab());
  }
}
