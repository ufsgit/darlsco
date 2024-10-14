import 'dart:async';

import 'package:darlsco/view/training/certificate_page.dart';
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
    print('kjbihjbh ${homeController.tabIndex.value}');
          print('hiii 111 ${widget.selectedIndex}');

    if (homeController.isuserLogin.value == true || // inspection enabled
            homeController.isTraineeLogin.value == true // training enabled
        ) {
     try {
        Timer.periodic(const Duration(minutes: 1), (timer) {
        homeController.checkUserTypeChanged(context);
      });
     } catch (e) {
       
     }
    }
     print('getItemCart1');
    trainingHomeController.getItemCart();
    super.initState();
  }
// default pages training pages

  final List<Widget> trainigPagesDefault = [
    const HomePage(initialIndex: 1), // select inspection tab
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

  void _onItemTapped(int index) {
    setState(() {

      if (homeController.isuserLogin.value &&
              homeController.isTraineeLogin.value ||
          homeController.isuserLogin.value &&
              !homeController.isTraineeLogin.value ||
          !homeController.isuserLogin.value &&
              !homeController.isTraineeLogin.value) {
        print('hiii 112');
        if (globalHomeController.tabIndex.value == 0

            ) {

        } else {
          print('eferwg3w');
          if (globalHomeController.isTraineeLogin.value &&
                  index == 4 // training enabled and 4th index of bnb
              ) {
            print('fetgtr 1');
            _scaffoldKey.currentState?.openEndDrawer(); // open drawer
          } else {
            print('fetgtr 2');

            homeController.pageIndex.value =
                index; // inspection tab page should be shown

            widget.selectedIndex = index; // bottom nav index
          }
        }
        if (index == 4) {
          print('hiii 115');
          _scaffoldKey.currentState?.openEndDrawer(); // open drawer
        } else {
          homeController.inspectionDropdownValue.value = '';
          homeController.equipmentListCustomer = {};
          homeController.inspectionDateController.clear();
          homeController.inspectionMessageController.clear();
          homeController.isChooseEquipment.value = false;

          homeController.pageIndex.value =
              index; // inspection tab page should be shown
          widget.selectedIndex = index; // bottom nav index
        }
      } else if (!homeController.isuserLogin.value &&
          homeController.isTraineeLogin.value) {
        print('hiii 113');

        if (homeController.isuserLogin.value == true &&
                homeController.isTraineeLogin.value ==
                    false // inspection enabled and training disabled
            ) {
          print('hiii 114');

          homeController.inspectionDropdownValue.value = '';
          homeController.equipmentListCustomer = {};
          homeController.inspectionDateController.clear();
          homeController.inspectionMessageController.clear();
          homeController.isChooseEquipment.value = false;

          homeController.pageIndex.value =
              index; // inspection tab page should be shown
          widget.selectedIndex = index; // bottom nav index
          if (index == 4) {
            print('hiii 115');
            _scaffoldKey.currentState?.openEndDrawer(); // open drawer
          }
        } else {
          if (globalHomeController.isTraineeLogin.value &&
                  index == 4 // training enabled and 4th index of bnb
              ) {
            print('hiii 116');
            _scaffoldKey.currentState?.openEndDrawer(); // open drawer
          } else {
            print('hiii 117');

            homeController.pageIndex.value =
                index; // inspection tab page should be shown

            widget.selectedIndex = index; // bottom nav index
          }
        }
      }
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
    // try {
    //       homeController.tabIndex.value=homeController.pageIndex.value;

    // } catch (e) {

    // }
   
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
          //<<<<<<<<<<<<<<<<<<< SCREEN BODY >>>>>>>>>>>>>>>>>>
          // body: globalHomeController.tabIndex.value ==
          //         0 // selected inspection tab
          //     // ||
          //     //         homeController.isuserLogin.value == true &&
          //     //             homeController.isTraineeLogin.value == false
          //     ? homeController.isuserLogin.value &&
          //             homeController.isTraineeLogin
          //                 .value // if tab is in inspection and training and inspection is enabled
          //         ? pagesDefault[globalHomeController.pageIndex.value]
          //         : inspectionTabPages[globalHomeController
          //             .pageIndex.value] // show inspection tab pages
          //     :
          //     // homeController.isTraineeLogin.value &&
          //     //             !homeController.isuserLogin.value
          //     //             ||
          //     globalHomeController.tabIndex.value == 1 // selected training tab
          //         ? !homeController.isuserLogin.value &&
          //                 !homeController.isTraineeLogin
          //                     .value // if tab is in training and training and inspection is disabled
          //             ? pagesDefault[globalHomeController
          //                 .pageIndex.value] // show deafault pages
          //             : trainingTabPages[globalHomeController
          //                 .pageIndex.value] // show training pages
          //         : pagesDefault[globalHomeController
          //             .pageIndex.value], // show default pages
          body:homeController.isHomeLoading.value?const Center(child: CircularProgressIndicator(),): !homeController.isuserLogin.value && // inspection disabled
                  !homeController.isTraineeLogin
                      .value // training disabled (when both are disabled which means there is a fresh user)
              ? homeController.isTrainingSection.value // selected training tab
                  ? trainigPagesDefault[
                     widget.selectedIndex] // default training pages
                  : inspectionTabPages[
                      homeController.pageIndex.value] // inspection pages
              : homeController.isuserLogin.value && // inspection enabled
                      !homeController.isTraineeLogin.value // training disbled
                  ? inspectionTabPages[
                      homeController.pageIndex.value] // show inspection pages
                  : !homeController.isuserLogin.value && // inspection disabled
                          homeController
                              .isTraineeLogin.value // training enabled
                      ? trainingTabPages[
                         widget.selectedIndex] // show training pages
                      :
                      // both of the inspection and training allowed
                      homeController
                              .isTrainingSection.value // training tab clicked
                          ? trainingTabPages[ widget.selectedIndex ] // show training pages
                          : inspectionTabPages[homeController
                              .pageIndex.value], // show inspection tab pages
          // <<<<<<<<<Bottom NAV >>>>>>>>>>
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
                items: homeController.tabIndex.value == 0
                    ? !homeController.isTraineeLogin.value &&
                                homeController.isuserLogin.value ||
                            homeController.isTraineeLogin.value &&
                                homeController.isuserLogin.value ||
                            !homeController.isTraineeLogin.value &&
                                !homeController.isuserLogin.value
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
                            // if (homeController.isuserLogin.value == true)
                            //   const BottomNavigationBarItem(
                            //       icon: Icon(Icons.dashboard_customize_outlined),
                            //       activeIcon: Icon(
                            //         Icons.dashboard,
                            //         color: ColorResources.color294C73,
                            //       ),
                            //       label: 'Dashboard'),
                            BottomNavigationBarItem(
                                icon: globalHomeController.pageIndex.value == 2
                                    ? const Icon(
                                        Icons.groups_2,
                                        color: ColorResources.color294C73,
                                      )
                                    : const Icon(Icons.groups_2_outlined),
                                label: 'About Us'),
                          ]
                        : [
                            BottomNavigationBarItem(
                              icon:
                                  _getIcon(0, Icons.home, Icons.home_outlined),
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: _getIcon(1, Icons.shopping_cart,
                                  Icons.shopping_cart_outlined),
                              label: 'Cart',
                            ),
                            BottomNavigationBarItem(
                              icon: _getIcon(2, Icons.view_comfortable_rounded,
                                  Icons.view_comfortable_outlined),
                              label: 'Order',
                            ),

                            // BottomNavigationBarItem(
                            //   icon: _getIcon(3, Icons.email, Icons.email_outlined),
                            //   label: 'Contact',
                            // ),
                            // BottomNavigationBarItem(
                            //   icon: _getIcon(4, Icons.groups, Icons.groups_2_outlined),
                            //   label: 'About Us',
                            // ),
                            BottomNavigationBarItem(
                              icon:
                                  _getIcon(3, Icons.book, Icons.book_outlined),
                              label: 'Documentation',
                            ),
                            BottomNavigationBarItem(
                              icon: _getIcon(4, Icons.person_2_rounded,
                                  Icons.person_2_outlined),
                              label: 'Profile',
                            ),
                          ]
                    : homeController.isTraineeLogin.value
                        ? [
                            BottomNavigationBarItem(
                              icon:
                                  _getIcon(0, Icons.home, Icons.home_outlined),
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: _getIcon(1, Icons.shopping_cart,
                                  Icons.shopping_cart_outlined),
                              label: 'Cart',
                            ),
                            BottomNavigationBarItem(
                              icon: _getIcon(2, Icons.view_comfortable_rounded,
                                  Icons.view_comfortable_outlined),
                              label: 'Order',
                            ),

                            // BottomNavigationBarItem(
                            //   icon: _getIcon(3, Icons.email, Icons.email_outlined),
                            //   label: 'Contact',
                            // ),
                            // BottomNavigationBarItem(
                            //   icon: _getIcon(4, Icons.groups, Icons.groups_2_outlined),
                            //   label: 'About Us',
                            // ),
                            BottomNavigationBarItem(
                              icon:
                                  _getIcon(3, Icons.book, Icons.book_outlined),
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
                              icon:
                                  _getIcon(0, Icons.home, Icons.home_outlined),
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: _getIcon(1, Icons.shopping_cart,
                                  Icons.shopping_cart_outlined),
                              label: 'Cart',
                            ),
                            BottomNavigationBarItem(
                              icon: _getIcon(2, Icons.mail, Icons.mail_outline),
                              label: 'Contact',
                            ),
                            BottomNavigationBarItem(
                              icon: _getIcon(
                                  3, Icons.groups, Icons.groups_2_outlined),
                              label: 'About Us',
                            ),
                            BottomNavigationBarItem(
                              icon:
                                  _getIcon(4, Icons.book, Icons.book_outlined),
                              label: 'Documentation',
                            ),
                          ]
                //  !homeController.isTrainingSection.value ||
                //         homeController.isuserLogin.value == true &&
                //             homeController.isTraineeLogin.value == false
                //     ? [
                //         BottomNavigationBarItem(
                //             icon: homeController.pageIndex.value == 0
                //                 ? const Icon(
                //                     Icons.home,
                //                     color: ColorResources.color294C73,
                //                   )
                //                 : const Icon(Icons.home_outlined),
                //             label: 'Home'),
                //         BottomNavigationBarItem(
                //             icon: homeController.pageIndex.value == 1
                //                 ? const Icon(
                //                     Icons.mail,
                //                     color: ColorResources.color294C73,
                //                   )
                //                 : const Icon(Icons.mail_outline),
                //             label: 'Contact'),
                //         // if (homeController.isuserLogin.value == true)
                //         //   const BottomNavigationBarItem(
                //         //       icon: Icon(Icons.dashboard_customize_outlined),
                //         //       activeIcon: Icon(
                //         //         Icons.dashboard,
                //         //         color: ColorResources.color294C73,
                //         //       ),
                //         //       label: 'Dashboard'),
                //         BottomNavigationBarItem(
                //             icon: globalHomeController.pageIndex.value == 2
                //                 ? const Icon(
                //                     Icons.groups_2,
                //                     color: ColorResources.color294C73,
                //                   )
                //                 : const Icon(Icons.groups_2_outlined),
                //             label: 'About Us'),
                //       ]
                //     : globalHomeController.isTraineeLogin.value == true ||
                //             homeController.isTrainingSection.value
                //         ? !homeController.isuserLogin.value &&
                //                 !homeController.isTraineeLogin.value
                //             ? [
                //                 BottomNavigationBarItem(
                //                   icon: _getIcon(
                //                       0, Icons.home, Icons.home_outlined),
                //                   label: 'Home',
                //                 ),
                //                 BottomNavigationBarItem(
                //                   icon: _getIcon(1, Icons.shopping_cart,
                //                       Icons.shopping_cart_outlined),
                //                   label: 'Cart',
                //                 ),
                //                 BottomNavigationBarItem(
                //                   icon:
                //                       _getIcon(2, Icons.mail, Icons.mail_outline),
                //                   label: 'Contact',
                //                 ),
                //                 BottomNavigationBarItem(
                //                   icon: _getIcon(
                //                       3, Icons.groups, Icons.groups_2_outlined),
                //                   label: 'About Us',
                //                 ),
                //                 BottomNavigationBarItem(
                //                   icon: _getIcon(
                //                       4, Icons.book, Icons.book_outlined),
                //                   label: 'Documentation',
                //                 ),
                //               ]
                //             : [
                //                 BottomNavigationBarItem(
                //                   icon: _getIcon(
                //                       0, Icons.home, Icons.home_outlined),
                //                   label: 'Home',
                //                 ),
                //                 BottomNavigationBarItem(
                //                   icon: _getIcon(1, Icons.shopping_cart,
                //                       Icons.shopping_cart_outlined),
                //                   label: 'Cart',
                //                 ),
                //                 BottomNavigationBarItem(
                //                   icon: _getIcon(
                //                       2,
                //                       Icons.view_comfortable_rounded,
                //                       Icons.view_comfortable_outlined),
                //                   label: 'Order',
                //                 ),

                //                 // BottomNavigationBarItem(
                //                 //   icon: _getIcon(3, Icons.email, Icons.email_outlined),
                //                 //   label: 'Contact',
                //                 // ),
                //                 // BottomNavigationBarItem(
                //                 //   icon: _getIcon(4, Icons.groups, Icons.groups_2_outlined),
                //                 //   label: 'About Us',
                //                 // ),
                //                 BottomNavigationBarItem(
                //                   icon: _getIcon(
                //                       3, Icons.book, Icons.book_outlined),
                //                   label: 'Documentation',
                //                 ),
                //                 BottomNavigationBarItem(
                //                   icon: _getIcon(4, Icons.person_2_rounded,
                //                       Icons.person_2_outlined),
                //                   label: 'Profile',
                //                 ),
                //               ]
                //         : [
                //             BottomNavigationBarItem(
                //               icon: _getIcon(0, Icons.home, Icons.home_outlined),
                //               label: 'Home',
                //             ),
                //             BottomNavigationBarItem(
                //               icon: _getIcon(1, Icons.shopping_cart,
                //                   Icons.shopping_cart_outlined),
                //               label: 'Cart',
                //             ),
                //             BottomNavigationBarItem(
                //               icon: _getIcon(2, Icons.mail, Icons.mail_outline),
                //               label: 'Contact',
                //             ),
                //             BottomNavigationBarItem(
                //               icon: _getIcon(
                //                   3, Icons.groups, Icons.groups_2_outlined),
                //               label: 'About Us',
                //             ),
                //             BottomNavigationBarItem(
                //               icon: _getIcon(4, Icons.book, Icons.book_outlined),
                //               label: 'Documentation',
                //             ),
                //           ],
                ),
          ),
        ),
      ),
    );
  }
}
