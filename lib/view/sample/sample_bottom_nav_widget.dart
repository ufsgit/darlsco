import 'package:darlsco/view/sample/sample_about_us.dart';
import 'package:darlsco/view/sample/sample_contact_screen.dart';
import 'package:darlsco/view/sample/sample_home_screen.dart';
import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:flutter/material.dart';

class SampleBottomNavWidget extends StatefulWidget {
  const SampleBottomNavWidget({super.key, this.isLoggedIn = false});
  final bool isLoggedIn;

  @override
  State<SampleBottomNavWidget> createState() => _SampleBottomNavWidgetState();
}

class _SampleBottomNavWidgetState extends State<SampleBottomNavWidget> {
  int screenIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      SampleHomeScreen(isLoggedIn: widget.isLoggedIn, onClickEnquire:(){
        setState(() {
          screenIndex = 1;
        });
      }),
      const SampleContactScreen(),
      const SampleAboutUs(),
    ];
    return Scaffold(
      body: widget.isLoggedIn ? screens[0] : screens[screenIndex],
      bottomNavigationBar: widget.isLoggedIn
          ? null
          : BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedIconTheme: IconThemeData(color: AppColors.primaryBlue),
              selectedLabelStyle:
                  AppStyles.getBodyTextStyle(fontColor: AppColors.primaryBlue),
              currentIndex: screenIndex,
              onTap: (i) {
                print(i);
                setState(() {
                  screenIndex = i;
                });
              },
              selectedItemColor: AppColors.primaryBlue,
              items: [
                  BottomNavigationBarItem(
                      icon: Image.asset('assets/images/home_icon.png',
                          color: screenIndex == 0
                              ? AppColors.primaryBlue
                              : Colors.grey,
                          height: 18),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Image.asset('assets/images/contact.png',
                          color: screenIndex == 1
                              ? AppColors.primaryBlue
                              : Colors.grey,
                          height: 18),
                      label: 'Contact'),
                  BottomNavigationBarItem(
                      icon: Image.asset('assets/images/about.png',
                          color: screenIndex == 2
                              ? AppColors.primaryBlue
                              : Colors.grey,
                          height: 18),
                      label: 'About Us'),
                ]),
    );
  }
}
