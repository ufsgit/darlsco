import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/view/home/contact_us_screen.dart';
import 'package:darlsco/view/home/home_screen.dart';
import 'package:darlsco/view/training/order_page.dart';
import 'package:darlsco/view/training/widgets/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

import '../../controller/tainning/trainnig_controller.dart';
import '../../controller/upcoming_inspections/upcoming_inspection_controller.dart';
import 'widgets/about_us_screen.dart';

HomeController homeController = Get.put(HomeController());

class EnglishUpgradeMessages extends UpgraderMessages {
  /// Override the message function to provide custom language localization.
  @override
  String? message(UpgraderMessage messageKey) {
    if (languageCode == 'en') {
      switch (messageKey) {
        case UpgraderMessage.body:
          return 'An improved version of the Darlsco App is now available. Please update to enjoy the latest features!';
        case UpgraderMessage.buttonTitleIgnore:
          return 'Ignore';
        case UpgraderMessage.buttonTitleLater:
          return 'Later';
        case UpgraderMessage.buttonTitleUpdate:
          return 'Update';
        case UpgraderMessage.prompt:
          return null;
        case UpgraderMessage.releaseNotes:
          return 'Release Notes';
        case UpgraderMessage.title:
          return 'Darlsco Update?';
        default:
          return super.message(messageKey)!;
      }
    }
    // Messages that are not provided above can still use the default values.
    return super.message(messageKey)!;
  }
}

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key, this.bottomNavigationIndex = 0});
  final int bottomNavigationIndex;

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final homecontroller = Get.put(HomeController());
  final UpcomingInspectionsController upcomingInspectionsController =
      Get.put(UpcomingInspectionsController());

  final TrainingController tcontroller = Get.put(TrainingController());
  // final TrainingControllerHomee trainingHomeController =
  //     Get.put(TrainingControllerHomee());

  final pages = [
    const HomePage(initialIndex: 0 ),
    const ContactUs(),
    const OrderPage(),

    // globalHomeController.tabIndex.value == 0 ? OrderPage() : Container(),

    // if (homeController.isuserLogin.value == true)
    //   const ExpiringEquipmentScreen(),
    // const AboutScreen(),
    const AboutUsScreen(),
  ];
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
homecontroller.dispose();
  }
  @override
  void initState() {
    homecontroller.numberTextList = ['0', '0', '0', '0'];
    // if (homecontroller.isuserLogin.value||homecontroller.isTraineeLogin.value) {
    homecontroller.initfunction();
    // trainingController.fetchTrainingHomeData();
    // }

    // homecontroller.initfunction();

    // homecontroller.messagingToken = FirebaseMessaging.instance;
    // homecontroller.messagingToken.getToken().then((value) {});

    // FirebaseMessaging.onMessage.listen((RemoteMessage event) {});
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: PopScope(
          canPop: false,
          child: Scaffold(
            body: pages[homeController.pageIndex.value],
            // UpgradeAlert(
            //   dialogStyle: UpgradeDialogStyle.material,
            //   upgrader: Upgrader(
            //       messages: EnglishUpgradeMessages(),
            //       durationUntilAlertAgain: Duration.zero,
            //       minAppVersion: '2.0.1'),
            //   showIgnore: false,
            //   showLater: false,
            //   showReleaseNotes: false,
            //   child:
            // ),
            bottomNavigationBar:
            
            
            
            
             BottomNavigationWidget(
              selectedIndex: widget.bottomNavigationIndex,
            ),
            // bottomNavigationBar: Obx(
            // ()=> BottomNavigationBar(
            //       onTap: (index) {
            //         homeController.inspectionDropdownValue.value = '';
            //         homeController.equipmentListCustomer = {};
            //         homeController.inspectionDateController.clear();
            //         homeController.inspectionMessageController.clear();
            //         homeController.isChooseEquipment.value = false;

            //         homeController.pageIndex.value = index;
            //       },
            //       selectedItemColor: ColorResources.color294C73,
            //       unselectedItemColor: ColorResources.color294C73,
            //       currentIndex: homeController.pageIndex.value,
            //       items:  [
            //         const BottomNavigationBarItem(
            //             icon: Icon(Icons.home_outlined),
            //             activeIcon: Icon(
            //               Icons.home,
            //               color: ColorResources.color294C73,
            //             ),
            //             label: 'Home'),
            //         const BottomNavigationBarItem(
            //             icon: Icon(Icons.mail_outline),
            //             activeIcon: Icon(
            //               Icons.mail,
            //               color: ColorResources.color294C73,
            //             ),
            //             label: 'Contact'),
            //              if(homecontroller.tabIndex.value==0)   const BottomNavigationBarItem(
            //             icon: Icon(Icons.groups_2_outlined),
            //             activeIcon: Icon(
            //               Icons.groups_2,
            //               color: ColorResources.color294C73,
            //             ),
            //             label: 'My Order'),
            //         // if (homeController.isuserLogin.value == true)
            //         //   const BottomNavigationBarItem(
            //         //       icon: Icon(Icons.dashboard_customize_outlined),
            //         //       activeIcon: Icon(
            //         //         Icons.dashboard,
            //         //         color: ColorResources.color294C73,
            //         //       ),
            //         //       label: 'Dashboard'),
            //       if(homecontroller.tabIndex.value==0)   const BottomNavigationBarItem(
            //             icon: Icon(Icons.groups_2_outlined),
            //             activeIcon: Icon(
            //               Icons.groups_2,
            //               color: ColorResources.color294C73,
            //             ),
            //             label: 'Account'),

            //         const BottomNavigationBarItem(
            //             icon: Icon(Icons.groups_2_outlined),
            //             activeIcon: Icon(
            //               Icons.groups_2,
            //               color: ColorResources.color294C73,
            //             ),
            //             label: 'About Us'),
            //       ]),
            //   ),
          ),
        ),
      ),
    );
  }
}
