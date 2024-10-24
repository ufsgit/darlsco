// import 'dart:math';

// import 'package:darlsco/controller/home/home_controller.dart';
// import 'package:darlsco/controller/login/login_controller.dart';
// import 'package:darlsco/core/constants/color_resources.dart';
// import 'package:darlsco/core/constants/common_widgets.dart';
// import 'package:darlsco/view/training/phone_verification_page.dart';
// import 'package:darlsco/view/training/training_home_screen.dart';
// import 'package:darlsco/view/training/widgets/training_widgets.dart';
// import 'package:darlsco/view/training_phase2/drawer_account.dart';
// import 'package:darlsco/view/widgets/dummy_widget.dart';
// import 'package:darlsco/view/home/bottom_navigation_screen.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:get/get_instance/get_instance.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:upgrader/upgrader.dart';

// import '../../controller/tainning/trainnig_controller.dart';
// import '../../controller/upcoming_inspections/upcoming_inspection_controller.dart';
// import '../login/login_screen.dart';
// import 'widgets/tab1.dart';
// import 'widgets/tab2.dart';

// class HomePage extends StatelessWidget {
//   final HomeController homeController = Get.put(HomeController());
//   HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: DefaultTabController(
//         // initialIndex: 1,
//         length: 2,
//         child: Scaffold(
//           endDrawer: SizedBox(
//               width: MediaQuery.sizeOf(context).width / 1.5,
//               child: const Drawer(child: DrawerAccount())),
//           // drawer: const Drawer(),
//           appBar: PreferredSize(
//             preferredSize: MediaQuery.of(context).size.width < 1200
//                 ? Size(390.w, 165.h)
//                 : Size(390.w, 200.h),
//             child: commonBackgroundLinearColor(
//               childWidget: SafeArea(
//                 child: GetBuilder<HomeController>(
//                   builder: (homeLoginData) => AppBar(
//                     automaticallyImplyLeading: false,
//                     backgroundColor: ColorResources.colorTransparent,
//                     actions: const [SizedBox()],
//                     // leading: Builder(builder: (ctx) {
//                     //   return customDrawerIcon(context: ctx);
//                     // }),

//                     flexibleSpace: homeLoginData.isTraineeLogin.value == false
//                         ? Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 24),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 loginBtnWidget(
//                                     onPressed: () {
//                                       homeController.isFromHome.value = true;

//                                       Get.to(
//                                           () => const PhoneVerificationPage());
//                                     },
//                                     text: 'Signup',
//                                     backgroundColor: const Color.fromARGB(
//                                         255, 155, 199, 248),
//                                     txtcolor: ColorResources.colorBlack,
//                                     borderColor: ColorResources.whiteColor),
//                                 const SizedBox(
//                                   width: 20,
//                                 ),
//                                 loginBtnWidget(
//                                     onPressed: () {
//                                       homeController.checkCountryCode();

//                                       Get.to(() => const LoginScreen());
//                                     },
//                                     text: 'Login',
//                                     backgroundColor:
//                                         ColorResources.colorFF0950A0,
//                                     txtcolor: ColorResources.whiteColor,
//                                     borderColor: ColorResources.colorFF0950A0)
//                               ],
//                             ),
//                           )
//                         : Align(
//                             alignment: Alignment.centerRight,
//                             child: IconButton(
//                                 onPressed: () {
//                                   showDialog(
//                                     barrierDismissible: false,
//                                     context: context,
//                                     builder: (ctx) => AlertDialog(
//                                       // title: const Text(
//                                       //   'Logout',
//                                       //   style: TextStyle(fontWeight: FontWeight.w800),
//                                       // ),
//                                       content: const SingleChildScrollView(
//                                         child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text("Are you sure to logout ?")
//                                             ]),
//                                       ),
//                                       actions: [
//                                         TextButton(
//                                           child: const Text('Cancel'),
//                                           onPressed: () {
//                                             Get.back();
//                                           },
//                                         ),
//                                         TextButton(
//                                           child: const Text('Logout'),
//                                           onPressed: () async {
//                                             await loginController.logout();
//                                             Get.back();
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                                 icon: CircleAvatar(
//                                     radius: 20.r,
//                                     backgroundColor: ColorResources.whiteColor,
//                                     child: Center(
//                                         child: Icon(
//                                       Icons.power_settings_new_rounded,
//                                       size: 18.sp,
//                                       color: Colors.black,
//                                     )))),
//                           ),
//                     // flexibleSpace:
//                     //     Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                     //   homeController.isuserLogin.value == false
//                     //       ? Column(
//                     //           children: [
//                     //             SizedBox(
//                     //               height: 10.w,
//                     //             ),
//                     //             Text(
//                     //               'Registered User’s',
//                     //               style: TextStyle(
//                     //                   // color: ColorResources.color294C73,
//                     //                   fontSize: 14.sp),
//                     //             ),
//                     //             SizedBox(
//                     //               height: 10.w,
//                     //             ),
//                     //             InkWell(
//                     //               onTap: () async {
//                     //                 homeController.checkCountryCode();

//                     //                 Get.to(() => const LoginScreen());
//                     //               },
//                     //               child: Container(
//                     //                 padding: EdgeInsets.all(5.w),
//                     //                 width: 100.w,
//                     //                 // height: 50.h,
//                     //                 // padding: EdgeInsets.only(
//                     //                 //     left: 17.w, right: 10.w, top: 10.h, bottom: 10.h),
//                     //                 decoration: BoxDecoration(
//                     //                     color: ColorResources.whiteColor,
//                     //                     borderRadius: BorderRadius.circular(36.sp)),
//                     //                 child: Center(
//                     //                   child: Text(
//                     //                     'Login',
//                     //                     style: TextStyle(
//                     //                         fontSize: 12.sp.h,
//                     //                         fontWeight: FontWeight.w500),
//                     //                   ),
//                     //                 ),
//                     //               ),
//                     //             ),
//                     //           ],
//                     //         )
//                     //       : IconButton(
//                     //           onPressed: () {
//                     //             showDialog(
//                     //               barrierDismissible: false,
//                     //               context: context,
//                     //               builder: (ctx) => AlertDialog(
//                     //                 // title: const Text(
//                     //                 //   'Logout',
//                     //                 //   style: TextStyle(fontWeight: FontWeight.w800),
//                     //                 // ),
//                     //                 content: const SingleChildScrollView(
//                     //                   child: Column(
//                     //                       crossAxisAlignment:
//                     //                           CrossAxisAlignment.start,
//                     //                       children: [
//                     //                         Text("Are you sure to logout ?")
//                     //                       ]),
//                     //                 ),
//                     //                 actions: [
//                     //                   TextButton(
//                     //                     child: const Text('Cancel'),
//                     //                     onPressed: () {
//                     //                       Get.back();
//                     //                     },
//                     //                   ),
//                     //                   TextButton(
//                     //                     child: const Text('Logout'),
//                     //                     onPressed: () async {
//                     //                       await loginController.logout();
//                     //                     },
//                     //                   ),
//                     //                 ],
//                     //               ),
//                     //             );
//                     //           },
//                     //           icon: CircleAvatar(
//                     //               radius: 25.r,
//                     //               backgroundColor: ColorResources.whiteColor,
//                     //               child: Center(
//                     //                   child: Icon(
//                     //                 Icons.power_settings_new_rounded,
//                     //                 size: 18.sp,
//                     //                 color: Colors.black,
//                     //               )))),
//                     //   SizedBox(
//                     //     width: 15.w,
//                     //   )
//                     // ]),

//                     bottom: TabBar(
//                       isScrollable: false,
//                       onTap: (index) async {
//                         print(index);
//                         if (index == 1 &&
//                             homeController.isTraineeLogin.value == true &&
//                             homeController.isuserLogin.value == false) {
//                           SharedPreferences sharedPreferences =
//                               await SharedPreferences.getInstance();
//                           print('inside');
//                           sharedPreferences.clear();
//                           // loginController.dispose();
//                           // tcontoller.refresh();
//                           // upcomingInspectionsController.refresh();
//                           // riskAssessmentController.dispose();

//                           await homeController.isUsersignedIn();
//                           loginController.logout();
//                           homeController.update();
//                         }
//                       },
//                       tabAlignment: TabAlignment.fill,
//                       // isScrollable: true,
//                       indicatorColor: ColorResources.colorE5AA17,
//                       unselectedLabelColor: ColorResources.color294C73,
//                       dividerHeight: 0,

//                       labelColor: ColorResources.color294C73,
//                       indicatorSize: TabBarIndicatorSize.tab,
//                       indicatorPadding: EdgeInsets.symmetric(horizontal: 24.h),
//                       indicatorWeight: 5.0,
//                       labelStyle: GoogleFonts.dmSans(
//                         color: ColorResources.color294C73,
//                         fontSize: 16.sp.h,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       tabs: const [
//                         Tab(
//                             text: 'Training',
//                             iconMargin: EdgeInsets.all(0),
//                             icon: Icon(
//                               Icons.transfer_within_a_station,
//                               color: ColorResources.color294C73,
//                               size: 30,
//                             )),
//                         Tab(
//                             iconMargin: EdgeInsets.all(0),
//                             text: 'Inspection',
//                             icon: Icon(Icons.query_stats,
//                                 color: ColorResources.color294C73, size: 30)),
//                         // Tab(
//                         //     iconMargin: const EdgeInsets.all(0),
//                         //     text: 'Calibration',
//                         //     icon: Icon(Icons.settings,
//                         //         color: ColorResources.color294C73, size: 30))
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           body: TabBarView(
//             physics: NeverScrollableScrollPhysics(),
//             children: [
//               const TrainingHomeScreen(),

//               // const Tab1(),
//               // DummyWidget(),
//               Tab2(
//                 btnText: 'Inspection',
//                 imgurlList: const [
//                   'https://s3-alpha-sig.figma.com/img/641b/30d6/0527f4c4463314a0e51342ca65015b8a?Expires=1701648000&Signature=b3Vf84hA3SPBQdsIYadxD69GmrohKr3CvC~q1CD57dD4NSTWzQMisHJtTaQ~NMufu9IIN2KEsnM4wcyss~flnFXyvB1xWmHLWwXrqCgvyrKDQq0tIP76lrodeGfsiE4YUm4A0IBOoihQoml9jmYxufepXFh0DhaWY-qHczbDczDEHnzzaqjqalyrhhhzbJlQGZb5RDEQOqYhk5XZ96G02DYdXRsmz~bLqfN~gZSBb47X7eRpYICs5ARKnID~0MqIWokpkb34~ZlrynYc1TglNRUy3soJoe3VM3ptaR~kCf2AsN8vAr0e5BEV45Jyzwzl~mJjjO5TcIrsk8ExdSQPRg__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4'
//                 ],
//                 cContainer: homeController.isuserLogin.value == true
//                     ? Wrap(
//                         spacing: Get.width > 615 ? 30.w : 10.w,
//                         runSpacing: Get.width > 615 ? 30.w : 10.w,
//                         children: List.generate(
//                             homeController.contentTextTrainingTab2.length,
//                             (index) => IconButton(
//                                   padding: const EdgeInsets.all(2),
//                                   onPressed: () {
//                                     homeController
//                                         .functionsTrainingTab2[index]();
//                                   },
//                                   icon: GetBuilder<HomeController>(
//                                       builder: (locationData) {
//                                     return homeColorContainer(
//                                         contentText: homeController
//                                             .contentTextTrainingTab2[index],
//                                         numberText: homeController
//                                             .numberTextList[index],
//                                         cBgColor: homeController
//                                             .cBgColorTrainingTab2[index],
//                                         numBgColor: homeController
//                                             .numBgColorTrainingTab2[index]);
//                                   }),
//                                 )),
//                       )
//                     : const SizedBox(),
//                 mainTitleWidget: RichText(
//                     text: TextSpan(children: [
//                   TextSpan(
//                     text: 'We\'re ready to',
//                     style: GoogleFonts.roboto(
//                         color: ColorResources.color294C73,
//                         fontSize: 40.sp,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   TextSpan(
//                     text: ' inspect',
//                     style: GoogleFonts.roboto(
//                       fontSize: 40.sp,
//                       fontWeight: FontWeight.w700,
//                       foreground: Paint()
//                         ..style = PaintingStyle.stroke
//                         ..strokeWidth = 1
//                         ..color = ColorResources.color294C73,
//                     ),
//                   ),
//                 ])),
//               ),

//               // DummyWidget(),
//               // Tab2(

//               //   btnText: 'Calibration',
//               //   imgurlList: const [
//               //     'https://s3-alpha-sig.figma.com/img/11ee/1090/40d9a8d8a23d9e88f3fba1d9a0065c08?Expires=1701648000&Signature=a6H5HoCj-VC3qdDbjqFKxin0uW3vsqBWV5WizvfH-ZUUaoA32brM~aj7K2gE4bZvM6DOhwchY9jleySTl15WzepjS92oBOkfqClIi0nLRTUVL0FTU4TgwW3S6b5~IvzzbqdUOvn~RPjMM2wucplZtXFvSi6k5~~xy6z5Rj5flV3jDrWhpYyjWjMbMvH0W0DJKHIah2VyC2ji1FFKia-DkGb-a1IEcIMcW7fkmw3gusEfbFLnXD7pGm71IX0yEFRCLZzbGRQBnvmW38-55HbZMASLYuw1fRSuBR9Bde9LVbdkOfMmlK1fp5Nh6F4kt4UjmYrbcGFaLHHAZe3mkPO0Bg__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4'
//               //   ],
//               //   cContainer:  homeController.isuserLogin.value==true? Wrap(
//               //     spacing: 15.w,
//               //     runSpacing: 15.h,
//               //     children: List.generate(
//               //         homeController.contentTextTrainingTab3.length,
//               //         (index) => homeColorContainer(
//               //             contentText:
//               //                 homeController.contentTextTrainingTab3[index],
//               //             numberText: '${index + 1}',
//               //             cBgColor: homeController.cBgColorTrainingTab3[index],
//               //             numBgColor:
//               //                 homeController.numBgColorTrainingTab3[index])),
//               //   ):SizedBox(),
//               //   mainTitleWidget: RichText(
//               //       text: TextSpan(children: [
//               //     TextSpan(
//               //       text: 'Calibration\n',
//               //       style: GoogleFonts.roboto(
//               //         fontSize: 40.sp,
//               //         fontWeight: FontWeight.w700,
//               //         foreground: Paint()
//               //           ..style = PaintingStyle.stroke
//               //           ..strokeWidth = 1
//               //           ..color = ColorResources.color294C73,
//               //       ),
//               //     ),
//               //     TextSpan(
//               //       text: 'Procedure',
//               //       style: GoogleFonts.roboto(
//               //           color: ColorResources.color294C73,
//               //           fontSize: 40.sp,
//               //           fontWeight: FontWeight.w700),
//               //     ),
//               //   ])),
//               // ),
//             ],
//           ),

//           // UpgradeAlert(
//           //   upgrader: Upgrader(
//           //     messages: EnglishUpgradeMessages(),
//           //     durationUntilAlertAgain: Duration.zero,
//           //   ),
//           //   showIgnore: false,
//           //   showLater: false,
//           //   showReleaseNotes: false,
//           //   child:
//           // ),
//         ),
//       ),
//     );
//   }
// }

import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/controller/upcoming_inspections/upcoming_inspection_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/training_home_screen.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:darlsco/view/training_phase2/drawer_account.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login_screen.dart';
import 'widgets/tab1.dart';
import 'widgets/tab2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.initialIndex});
  final int initialIndex;
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final HomeController homeController = Get.put(HomeController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   homeController.isHomeLoading.value = true;
    // });
    if (globalHomeController.isuserLogin.value == true ||
        (globalHomeController.isuserLogin.value == false &&
            globalHomeController.isTraineeLogin.value == false)) {
      print('tabIndex 2');
    } else {
      print('tabIndex 1 ${widget.initialIndex}');
    }
    _tabController = TabController(
        length: homeController.isTraineeLogin.value == false &&
                    homeController.isuserLogin.value == false ||
                homeController.isTraineeLogin.value == true &&
                    homeController.isuserLogin.value == true
            ? 2
            : 1,
        vsync: this);

    if ((homeController.isTraineeLogin.value == false &&
            homeController.isuserLogin.value == false) ||
        (homeController.tabIndex.value == 1) ||
        homeController.isuserLogin.value == true) {
      _tabController.index = widget.initialIndex;
    } else {
      _tabController.index = 0;
    }

    trainingController.selectedCategory.value?.duration = null;
    _tabController.addListener(_handleTabSelection);
    getData();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  getData() {
    print('getItemCart3');

    trainingController.getItemCart();

    if (globalHomeController.isTraineeLogin.value) {
      trainingController.getProfile();
      trainingController.getIndividualTrainee();
    }
    if (homeController.isuserLogin.value) {
      trainingController.getIndividualTrainee();
    }
    homeController.checkUserTypeChanged(context);
    // setState(() {
    //   homeController.isHomeLoading.value = false;
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (homeController.isuserLogin.value == false &&
          homeController.isTraineeLogin.value) {
        homeController.isTrainingSection.value = true;
      }
      if (homeController.isuserLogin.value == false &&
          homeController.isCalliberationLogin.value) {
        homeController.isCaliberationSection.value = true;
      }
    } catch (e) {}
    return SafeArea(
      child: GetBuilder<HomeController>(builder: (loginDatas) {
        return DefaultTabController(
          // initialIndex:widget.initialIndex,
          length: _tabController.length,
          child: Scaffold(
            endDrawer: loginDatas.isuserLogin.value == true
                ? SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: const Drawer(child: DrawerAccount()),
                  )
                : null,
            appBar: PreferredSize(
              preferredSize: MediaQuery.of(context).size.width < 1200
                  ? Size(390.w, 185.h)
                  : Size(390.w, 200.h),
              child: commonBackgroundLinearColor(
                childWidget: SafeArea(
                  child: GetBuilder<HomeController>(
                    builder: (homeLoginData) => AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: ColorResources.colorTransparent,
                      actions: const [SizedBox()],
                      flexibleSpace: homeLoginData.isuserLogin.value == false &&
                              homeLoginData.isTraineeLogin.value == false
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 28),
                              child: Row(
                                mainAxisAlignment: _tabController.index != 1
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.end,
                                children: [
                                  if (_tabController.index != 1)
                                    // loginBtnWidget(
                                    //   onPressed: () {
                                    //     homeController.isFromHome.value = true;
                                    //     Get.to(
                                    //         () => const PhoneVerificationPage());
                                    //   },
                                    //   text: 'Signup',
                                    //   backgroundColor: const Color.fromARGB(
                                    //       255, 155, 199, 248),
                                    //   txtcolor: ColorResources.colorBlack,
                                    //   borderColor: ColorResources.whiteColor,
                                    // ),
                                    const SizedBox(width: 20),
                                  Padding(
                                    padding: EdgeInsets.only(right: 16.w),
                                    child: loginBtnWidget(
                                      onPressed: () {
                                        homeController
                                            .checkCountryCode(context);

                                        Get.to(() => const LoginScreen());
                                      },
                                      text: 'Login',
                                      backgroundColor:
                                          ColorResources.whiteColor,
                                      txtcolor: ColorResources.whiteColor,
                                      borderColor: ColorResources.colorFF0950A0,
                                    ),
                                  )
                                  // : Padding(
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: 16.w),
                                  //     child: loginBtnWidget(
                                  //       onPressed: () {
                                  //         homeController.checkCountryCode();
                                  //         Get.to(() => const LoginScreen());
                                  //       },
                                  //       text: 'LogIn',
                                  //       backgroundColor:
                                  //           ColorResources.whiteColor,
                                  //       txtcolor: ColorResources.whiteColor,
                                  //       borderColor:
                                  //           ColorResources.colorFF0950A0,
                                  //     ),
                                  //   ),
                                ],
                              ),
                            )
                          : homeLoginData.isTraineeLogin.value == true ||
                                  homeLoginData.isuserLogin.value == true
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 24.h, right: 8.w),
                                    child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            // title: const Text(
                                            //   '',
                                            //   style: TextStyle(fontWeight: FontWeight.w800),
                                            // ),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    const Text(
                                                        "Are you sure to logout?")
                                                  ]),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text('Cancel'),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Logout'),
                                                onPressed: () async {
                                                  await loginController
                                                      .logout(context);
                                                  globalHomeController
                                                      .isTrainingSection
                                                      .value = false;
                                                  globalHomeController
                                                      .isCaliberationSection
                                                      .value = false;

                                                  _handleTabSelection();
                                                  Get.back();
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: CircleAvatar(
                                        radius: 20.r,
                                        backgroundColor:
                                            ColorResources.whiteColor,
                                        child: Center(
                                          child: Icon(
                                            Icons.power_settings_new_rounded,
                                            size: 18.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                      bottom: TabBar(
                              controller: _tabController,

                              isScrollable: homeController.isuserLogin.value ==
                                              false &&
                                          homeController.isTraineeLogin.value ==
                                              false ||
                                      homeController.isuserLogin.value ==
                                              true &&
                                          homeController.isTraineeLogin.value ==
                                              true
                                  ? false
                                  : true,

                              tabAlignment: homeController.isuserLogin.value ==
                                              false &&
                                          homeController.isTraineeLogin.value ==
                                              false ||
                                      homeController.isuserLogin.value ==
                                              true &&
                                          homeController.isTraineeLogin.value ==
                                              true
                                  ? TabAlignment.fill
                                  : TabAlignment.start,

                              onTap: (index) async {
                                if (index == 1 &&
                                    homeController.isTraineeLogin.value ==
                                        true &&
                                    homeController.isuserLogin.value == false) {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.clear();
                                  await homeController.isUsersignedIn();
                                  loginController.logout(context);
                                  homeController.update();
                                }
                                homeController.tabIndex.value = index;
                                if (index == 0) {
                                  globalHomeController.isTrainingSection.value =
                                      false;
                                  homeController.tabIndex.value = index;
                                } else {
                                  globalHomeController.isTrainingSection.value =
                                      true;
                                  homeController.tabIndex.value = index;
                                }
                              },
                              indicatorColor: ColorResources.colorE5AA17,
                              unselectedLabelColor: ColorResources.color294C73,
                              labelColor: ColorResources.color294C73,
                              dividerHeight: 0,
                              indicatorSize: TabBarIndicatorSize.tab,
                              // indicatorPadding: homeController.isuserLogin.value==false&& homeController.isTraineeLogin.value==false||homeController.isuserLogin.value==true&&homeController.isTraineeLogin.value==true? EdgeInsets.symmetric(horizontal: 64.h):EdgeInsets.zero,
                              indicatorWeight: 3.5,
                              labelStyle: GoogleFonts.dmSans(
                                color: ColorResources.color294C73,
                                fontSize: 16.sp.h,
                                fontWeight: FontWeight.w600,
                              ),

                              tabs: [
                                if (globalHomeController.isuserLogin.value ==
                                        true ||
                                    (globalHomeController.isuserLogin.value ==
                                            false &&
                                        globalHomeController
                                                .isTraineeLogin.value ==
                                            false))
                                  const Tab(
                                    iconMargin: EdgeInsets.all(0),
                                    text: 'Inspection',
                                    icon: Icon(
                                      Icons.query_stats,
                                      color: ColorResources.color294C73,
                                      size: 30,
                                    ),
                                  ),
                                if (globalHomeController.isTraineeLogin.value ==
                                        true ||
                                    (globalHomeController.isuserLogin.value ==
                                            false &&
                                        globalHomeController
                                                .isTraineeLogin.value ==
                                            false))
                                  const Tab(
                                    text: 'Training',
                                    iconMargin: EdgeInsets.all(0),
                                    icon: Icon(
                                      Icons.transfer_within_a_station,
                                      color: ColorResources.color294C73,
                                      size: 30,
                                    ),
                                  ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
            body: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      if (globalHomeController.isuserLogin.value == true ||
                          (globalHomeController.isuserLogin.value == false &&
                              globalHomeController.isTraineeLogin.value ==
                                  false))
                        Tab2(
                          btnText: 'Inspection',
                          imgurlList: const [
                            'https://s3-alpha-sig.figma.com/img/641b/30d6/0527f4c4463314a0e51342ca65015b8a?Expires=1701648000&Signature=b3Vf84hA3SPBQdsIYadxD69GmrohKr3CvC~q1CD57dD4NSTWzQMisHJtTaQ~NMufu9IIN2KEsnM4wcyss~flnFXyvB1xWmHLWwXrqCgvyrKDQq0tIP76lrodeGfsiE4YUm4A0IBOoihQoml9jmYxufepXFh0DhaWY-qHczbDczDEHnzzaqjqalyrhhhzbJlQGZb5RDEQOqYhk5XZ96G02DYdXRsmz~bLqfN~gZSBb47X7eRpYICs5ARKnID~0MqIWokpkb34~ZlrynYc1TglNRUy3soJoe3VM3ptaR~kCf2AsN8vAr0e5BEV45Jyzwzl~mJjjO5TcIrsk8ExdSQPRg__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4'
                          ],
                          cContainer: homeController.isuserLogin.value == true
                              ? Wrap(
                                  spacing: Get.width > 615 ? 30.w : 10.w,
                                  runSpacing: Get.width > 615 ? 30.w : 10.w,
                                  children: List.generate(
                                      homeController
                                          .contentTextTrainingTab2.length,
                                      (index) => IconButton(
                                            padding: const EdgeInsets.all(2),
                                            onPressed: () {
                                              // ScaffoldMessenger.of(context)
                                              // .showSnackBar(const SnackBar(

                                              //   content: Text('server failure')));
                                              homeController
                                                      .functionsTrainingTab2[
                                                  index]();
                                            },
                                            icon: GetBuilder<HomeController>(
                                                builder: (locationData) {
                                              return homeColorContainer(
                                                  contentText: homeController
                                                          .contentTextTrainingTab2[
                                                      index],
                                                  numberText: index == 0
                                                      ? homeController
                                                          .customerLocations
                                                          .length
                                                          .toString()
                                                      :index==1?homeController.customerEquipmentData.length.toString(): index == 2
                                                          ? homeController
                                                              .customerEquipmentExpiringData
                                                              .length
                                                              .toString()
                                                          : index == 3
                                                              ? upcomingInspectionsController
                                                                  .upcomingInspectionListData
                                                                  .length
                                                                  .toString()
                                                              : '0',
                                                  cBgColor: homeController
                                                          .cBgColorTrainingTab2[
                                                      index],
                                                  numBgColor: homeController
                                                          .numBgColorTrainingTab2[
                                                      index]);
                                            }),
                                          )),
                                )
                              : const SizedBox(),
                          mainTitleWidget: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'We\'re ready to',
                              style: GoogleFonts.roboto(
                                  color: ColorResources.color294C73,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: ' inspect',
                              style: GoogleFonts.roboto(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w700,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = ColorResources.color294C73,
                              ),
                            ),
                          ])),
                        ),
                      if (globalHomeController.isTraineeLogin.value == true ||
                          (globalHomeController.isuserLogin.value == false &&
                              globalHomeController.isTraineeLogin.value ==
                                  false))
                        const TrainingHomeScreen(),
                    ],
                  ),
          ),
        );
      }),
    );
  }
}
