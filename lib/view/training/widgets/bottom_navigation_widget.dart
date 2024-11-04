import 'dart:async';

import 'package:darlsco/view/training/documentation_page.dart';
import 'package:darlsco/view/training/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:darlsco/view/training/cart_screen.dart';
import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/view/home/home_screen.dart';
import 'package:darlsco/view/training/order_page.dart';
import 'package:darlsco/view/home/contact_us_screen.dart';
import 'package:darlsco/view/training_phase2/drawer_account.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:darlsco/view/home/widgets/about_us_screen.dart';
import 'package:badges/badges.dart' as badges;

import '../../../controller/tainning/trainnig_controller.dart';
import '../../home/bottom_navigation_screen.dart';

// ignore: must_be_immutable
class BottomNavigationWidget extends StatefulWidget {
  BottomNavigationWidget({super.key, this.selectedIndex = 0});
  int selectedIndex;

  @override
  BottomNavigationWidgetState createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final HomeController globalHomeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (homeController.isuserLogin.value == true || // inspection enabled
        homeController.isTraineeLogin.value == true // training enabled
        ||
        homeController.isUserLoggedIn) {
      try {
        Timer.periodic(const Duration(minutes: 1), (timer) {
          try {
            homeController.checkUserTypeChanged(context);
          } catch (e) {}
        });
      } catch (e) {}
    }
    // trainingHomeController.getItemCart();
    super.initState();
  }
// default pages training pages

  final List<Widget> trainigPagesDefault = [
    const HomePage(initialIndex: 1), // select training tab
    const CartScreen(isFromPurchase: false),

    const ContactUs(),
    const AboutUsScreen(),

    const DocumentationPage(),
    Container(), // Placeholder for the Profile tab
  ];

  // training Tab

  final List<Widget> trainingTabPages = [
    const HomePage(initialIndex: 1), // select training tab
    const CartScreen(isFromPurchase: false),
    const OrderPage(),
    const DocumentationPage(),
    const ProfileViewPage()
  ];

  // inspection tab

  final inspectionTabPages = [
    const HomePage(initialIndex: 0), // select inspection tab
    const ContactUs(),
    const AboutUsScreen(),
  ];

  // calliberation tab

  final calliberationTabPages = [
    const HomePage(initialIndex: null), // select calliberation tab
    const ContactUs(),
    const AboutUsScreen(),
  ];

  void _onItemTapped(int index) {
    
    setState(() {
      if (index == 4 && homeController.isUserLoggedIn) {
        _scaffoldKey.currentState?.openEndDrawer();
        return;
      }

      homeController.pageIndex.value =
          index; // inspection tab page should be shown

      widget.selectedIndex = index; // bottom nav index
    });
  }

// icons in bnb
  _getIcon(int index, IconData filledIcon, IconData outlinedIcon) {
    return index == 1
        ? badges.Badge(
            badgeStyle:
                const badges.BadgeStyle(badgeColor: ColorResources.colorE5AA17),
            badgeContent: Obx(() => Text(
                  '${tcontoller.homeQuatity.value}',
                  style: const TextStyle(color: Colors.black),
                )),
            child: Icon(
              widget.selectedIndex == index ? filledIcon : outlinedIcon,
            ),
          )
        : Icon(
            widget.selectedIndex == index ? filledIcon : outlinedIcon,
            size: 25.h,
          );
  }

// <<<<<<<<<<<<<<<<< START BUILDING >>>>>>>>>>> //

  @override
  Widget build(BuildContext context) {
   

    return PopScope(
      canPop: false,
      child: Obx(
        () => Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.black,
          endDrawerEnableOpenDragGesture: false,
          endDrawer: globalHomeController.isTraineeLogin.value
              ? const Drawer(child: DrawerAccount())
              : null,
          body: getPage(),
       
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: widget.selectedIndex,
                selectedItemColor: const Color.fromARGB(255, 5, 60, 122),
                unselectedItemColor: const Color.fromARGB(255, 5, 60, 122),
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: TextStyle(
                    color: ColorResources.colorBlack,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w900),
                unselectedLabelStyle: GoogleFonts.dmSans(
                  color: const Color.fromARGB(255, 5, 60, 122),
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold,
                ),
                onTap: _onItemTapped,
                // items: globalHomeController.tabIndex.value == 0||
                items: homeController.isInspectionSection.value
                    ? [
                        BottomNavigationBarItem(
                            icon: homeController.pageIndex.value == 0
                                ? const Icon(
                                    Icons.home,
                                    color: ColorResources.color294C73,
                                  )
                                : const Icon(Icons.home_outlined),
                            label: 'Home'),
                        BottomNavigationBarItem(
                            icon: homeController.pageIndex.value == 1
                                ? const Icon(
                                    Icons.mail,
                                    color: ColorResources.color294C73,
                                  )
                                : const Icon(Icons.mail_outline),
                            label: 'Contact'),
                        BottomNavigationBarItem(
                            icon: globalHomeController.pageIndex.value == 2
                                ? const Icon(
                                    Icons.groups_2,
                                    color: ColorResources.color294C73,
                                  )
                                : const Icon(Icons.groups_2_outlined),
                            label: 'About Us'),
                      ]
                    : homeController.isCalliberationSection.value
                        ? [
                            BottomNavigationBarItem(
                                icon: homeController.pageIndex.value == 0
                                    ? const Icon(
                                        Icons.home,
                                        color: ColorResources.color294C73,
                                      )
                                    : const Icon(Icons.home_outlined),
                                label: 'Home'),
                            BottomNavigationBarItem(
                                icon: homeController.pageIndex.value == 1
                                    ? const Icon(
                                        Icons.mail,
                                        color: ColorResources.color294C73,
                                      )
                                    : const Icon(Icons.mail_outline),
                                label: 'Contact'),
                            BottomNavigationBarItem(
                                icon: globalHomeController.pageIndex.value == 2
                                    ? const Icon(
                                        Icons.groups_2,
                                        color: ColorResources.color294C73,
                                      )
                                    : const Icon(Icons.groups_2_outlined),
                                label: 'About Us'),
                          ]
                        : homeController.isTrainingSectionnew.value
                            ? homeController.isUserLoggedIn
                                ? [
                                    BottomNavigationBarItem(
                                      icon: _getIcon(
                                          0, Icons.home, Icons.home_outlined),
                                      label: 'Home',
                                    ),
                                    BottomNavigationBarItem(
                                      icon: _getIcon(1, Icons.shopping_cart,
                                          Icons.shopping_cart_outlined),
                                      label: 'Cart',
                                    ),
                                    BottomNavigationBarItem(
                                      icon: _getIcon(
                                          2,
                                          Icons.view_comfortable_rounded,
                                          Icons.view_comfortable_outlined),
                                      label: 'Order',
                                    ),
                                    BottomNavigationBarItem(
                                      icon: _getIcon(
                                          3, Icons.book, Icons.book_outlined),
                                      label: 'Documentation',
                                    ),
                                    BottomNavigationBarItem(
                                      icon: _getIcon(4, Icons.person_2_rounded,
                                          Icons.person_2_outlined),
                                      label: 'Profile',
                                    ),
                                  ]
                                : [
                                    BottomNavigationBarItem(
                                      icon: _getIcon(
                                          0, Icons.home, Icons.home_outlined),
                                      label: 'Home',
                                    ),
                                    BottomNavigationBarItem(
                                      icon: _getIcon(1, Icons.shopping_cart,
                                          Icons.shopping_cart_outlined),
                                      label: 'Cart',
                                    ),
                                    BottomNavigationBarItem(
                                      icon: _getIcon(
                                          2, Icons.mail, Icons.mail_outline),
                                      label: 'Contact',
                                    ),
                                    BottomNavigationBarItem(
                                      icon: _getIcon(3, Icons.groups,
                                          Icons.groups_2_outlined),
                                      label: 'About Us',
                                    ),
                                    BottomNavigationBarItem(
                                      icon: _getIcon(
                                          4, Icons.book, Icons.book_outlined),
                                      label: 'Documentation',
                                    ),
                                  ]
                            :[
                            BottomNavigationBarItem(
                                icon: homeController.pageIndex.value == 0
                                    ? const Icon(
                                        Icons.home,
                                        color: ColorResources.color294C73,
                                      )
                                    : const Icon(Icons.home_outlined),
                                label: 'Home'),
                            BottomNavigationBarItem(
                                icon: homeController.pageIndex.value == 1
                                    ? const Icon(
                                        Icons.mail,
                                        color: ColorResources.color294C73,
                                      )
                                    : const Icon(Icons.mail_outline),
                                label: 'Contact'),
                            BottomNavigationBarItem(
                                icon: globalHomeController.pageIndex.value == 2
                                    ? const Icon(
                                        Icons.groups_2,
                                        color: ColorResources.color294C73,
                                      )
                                    : const Icon(Icons.groups_2_outlined),
                                label: 'About Us'),
                          ]),
          ),
        ),
      ),
    );
  }

  Widget getPage() {
    if (homeController.isInspectionSection.value) {
      print('JBFUIR 1');
      return inspectionTabPages[homeController.pageIndex.value];
    } else if (homeController.isTrainingSectionnew.value) {
      print('JBFUIR 2');
      return homeController.isUserLoggedIn
          ? trainingTabPages[homeController.pageIndex.value]
          : trainigPagesDefault[homeController.pageIndex.value];
    } else if (homeController.isCalliberationSection.value) {
      print('JBFUIR 3');
      return calliberationTabPages[homeController.pageIndex.value];
    } else {
      print('JBFUIR 4');
      return inspectionTabPages[widget.selectedIndex];
    }
  }
}
