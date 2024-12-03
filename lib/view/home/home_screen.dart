import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/controller/upcoming_inspections/upcoming_inspection_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/main.dart';
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
  final int? initialIndex;
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final HomeController homeController = Get.put(HomeController());
  late TabController _tabController;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    // setState(() {
    // getNotificationToken();
    //   homeController.isHomeLoading.value = true;
    // });
    bool areAnyTwoTrue = [
          homeController.isTrainingEnabled,
          homeController.isInspectionEnabled,
          homeController.isCalibrationEnabled
        ].where((element) => element).length >=
        2;
    if (homeController.isInspectionEnabled &&
        homeController.isTrainingEnabled &&
        homeController.isCalibrationEnabled) {
      print('dfwref n12');
    } else {
      print('dfwref n1255 ${homeController.isInspectionEnabled}');
      print('dfwref n1255 ${homeController.isTrainingEnabled}');
      print('dfwref n1255 ${homeController.isCalibrationEnabled}');
    }

    _tabController = TabController(
        length: homeController.isInspectionEnabled &&
                    homeController.isTrainingEnabled &&
                    homeController.isCalibrationEnabled ||
                !homeController.isInspectionEnabled &&
                    !homeController.isTrainingEnabled &&
                    !homeController.isCalibrationEnabled
            ? 3
            : areAnyTwoTrue
                ? 2
                : 1,
        vsync: this);

    if ((homeController.isTraineeLogin.value == false &&
            homeController.isuserLogin.value == false) ||
        (homeController.tabIndex.value == 1) ||
        homeController.isuserLogin.value == true) {
      if (widget.initialIndex == null) {
        _tabController.index = !homeController.isInspectionEnabled &&
                !homeController.isTrainingEnabled
            ? 0
            : homeController.isInspectionEnabled &&
                    !homeController.isTrainingEnabled
                ? 1
                : !homeController.isInspectionEnabled &&
                        homeController.isTrainingEnabled
                    ? 1
                    : homeController.isInspectionEnabled &&
                            homeController.isTrainingEnabled &&
                            homeController.isCalibrationEnabled
                        ? 2
                        : 0;
        // homeController.isuserLogin.value &&
        //             homeController.isTraineeLogin.value &&
        //             homeController.isCalibrationSection.value ||
        //         !homeController.isuserLogin.value &&
        //             !homeController.isTraineeLogin.value &&
        //             homeController.isCalibrationSection.value
        //     ? 2
        //     : 1;
      } else {
        print('hiiii 74 ${widget.initialIndex}');

        _tabController.index = widget.initialIndex ?? 0;
      }
      print('oiubib ${widget.initialIndex}');
    } else {
      print('oiubib 5${widget.initialIndex}');

      _tabController.index = 0;
    }
    if (globalHomeController.isCalibrationLogin.value ||
        !globalHomeController.isuserLogin.value &&
            globalHomeController.isCalibrationLogin.value) {
      print('dfsrfgdfweer');
    } else {
      print('dfsrfgdfweer2000 ${globalHomeController.isuserLogin.value}');
    }
    trainingController.selectedCategory.value?.duration = null;
    _tabController.addListener(_handleTabSelection);
    getData();
  }

  void _handleTabSelection() {
    try {
      setState(() {});
    } catch (e) {
      
    }
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
          homeController.isCalibrationLogin.value) {
        print('erioioertniogtng');
        homeController.isCalibrationSection.value = true;
      }
    } catch (e) {}
    return Stack(
      children: [
        SafeArea(
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
                          flexibleSpace: !homeController.isUserLoggedIn
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
                                          borderColor:
                                              ColorResources.colorFF0950A0,
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
                              : homeController.isUserLoggedIn
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 24.h, right: 8.w),
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
                                                          CrossAxisAlignment
                                                              .start,
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
                                                          .isCalibrationSection
                                                          .value = false;
                                                      globalHomeController
                                                              .isUserLoggedIn =
                                                          false;

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
                                                Icons
                                                    .power_settings_new_rounded,
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
                                    homeController.isuserLogin.value == true &&
                                        homeController.isTraineeLogin.value ==
                                            true
                                ? false
                                : true,

                            tabAlignment: homeController.isuserLogin.value ==
                                            false &&
                                        homeController.isTraineeLogin.value ==
                                            false ||
                                    homeController.isuserLogin.value == true &&
                                        homeController.isTraineeLogin.value ==
                                            true
                                ? TabAlignment.fill
                                : TabAlignment.start,

                            onTap: (index) async {
                              // await upcomingInspectionsController
                              // .getUpComingCalibration(isFromSplash: true);
                              if (homeController.isHomeLoading.value) {
                                print('dfgswrlkkkjkhk 12343');
                              } else {}
                              if (index == 2 &&
                                  homeController.isTraineeLogin.value == true &&
                                  homeController.isuserLogin.value == false) {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.clear();
                                await homeController.isUsersignedIn();
                                loginController.logout(context);
                              }
                              print('dfgswrlkkkjkh $index');

                              homeController.tabIndex.value = index;
                              if (index == 0 &&
                                  homeController.isInspectionEnabled) {
                                print('HIJACK SUCCESS');
                              } else {
                                print(
                                    'HIJACK ${homeController.isCalibrationSection}');
                                print(
                                    'HIJACK ${homeController.isTrainingSectionnew}');
                                print(
                                    'HIJACK ${homeController.isInspectionSection}');
                              }
                              homeController.isInspectionSection.value =
                                  index == 0 &&
                                      homeController.isInspectionEnabled;

                              homeController
                                  .isTrainingSectionnew.value = index == 0 &&
                                      !homeController.isInspectionEnabled &&
                                      !homeController.isCalibrationEnabled &&
                                      homeController.isTrainingEnabled ||
                                  index == 0 &&
                                      !homeController.isInspectionEnabled &&
                                      homeController.isCalibrationEnabled &&
                                      homeController.isTrainingEnabled ||
                                  index == 1 &&
                                      homeController.isTrainingEnabled &&
                                      homeController.isInspectionEnabled;

                              homeController.isCalibrationSection.value =
                                  index == 0 &&
                                          !homeController.isInspectionEnabled &&
                                          !homeController.isTrainingEnabled ||
                                      index == 1 &&
                                          homeController.isInspectionEnabled &&
                                          !homeController.isTrainingEnabled ||
                                      index == 1 &&
                                          !homeController.isInspectionEnabled &&
                                          homeController.isTrainingEnabled ||
                                      index == 2 &&
                                          homeController.isInspectionEnabled &&
                                          homeController.isTrainingEnabled &&
                                          homeController.isCalibrationEnabled;
                              homeController.update();
                              // if (index == 0) {
                              //   globalHomeController.isTrainingSection.value =
                              //       false;
                              //   globalHomeController.isCalibrationSection.value =
                              //       false;

                              //   homeController.tabIndex.value = index;
                              // } else if (index == 2) {
                              //   print('dfsrgre 8');

                              //   globalHomeController.isTrainingSection.value =
                              //       false;
                              //   globalHomeController.isCalibrationSection.value =
                              //       true;
                              //   homeController.tabIndex.value = index;
                              // } else if (index == 1) {
                              //   print('iiiihoioihi 1');
                              //   globalHomeController.isCalibrationSection.value =
                              //       false;
                              //   if (!homeController.isuserLogin.value ||
                              //       !homeController.isTraineeLogin.value) {
                              //     print('iiiihoioihi 2');
                              //     globalHomeController.isTrainingSection.value =
                              //         false;
                              //     globalHomeController.isCalibrationSection.value =
                              //         true;
                              //   } else {
                              //     print('iiiihoioihi 3');
                              //     globalHomeController.isTrainingSection.value =
                              //         true;
                              //   }
                              //   /////////
                              //   if (homeController.isCalibrationLogin.value &&
                              //       !homeController.isTraineeLogin.value) {
                              //     print('dfsrgre 10');

                              //     globalHomeController.isTrainingSection.value =
                              //         false;
                              //     globalHomeController.isCalibrationSection.value =
                              //         true;
                              //   } else if (!homeController
                              //           .isCalibrationLogin.value &&
                              //       homeController.isTraineeLogin.value) {
                              //     print('dfsrgre 11');

                              //     globalHomeController.isTrainingSection.value =
                              //         true;
                              //     globalHomeController.isCalibrationSection.value =
                              //         false;
                              //   }

                              //   homeController.tabIndex.value = index;
                              // } else {
                              //   print('dfsrgre 9');

                              //   globalHomeController.isTrainingSection.value = true;
                              //   globalHomeController.isCalibrationSection.value =
                              //       false;
                              //   homeController.tabIndex.value = index;
                              // }
                              // print(
                              //     'dfsrgre ${homeController.isTrainingSection.value}');
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
                              // if (globalHomeController.isuserLogin.value == true ||
                              //     (globalHomeController.isuserLogin.value ==
                              //             false &&
                              //         globalHomeController.isTraineeLogin.value ==
                              //             false))
                              if (homeController.isInspectionEnabled)
                                const Tab(
                                  iconMargin: EdgeInsets.all(0),
                                  text: 'Inspection',
                                  icon: Icon(
                                    Icons.query_stats,
                                    color: ColorResources.color294C73,
                                    size: 30,
                                  ),
                                ),
                              // if (globalHomeController.isTraineeLogin.value ==
                              //         true ||
                              //     (globalHomeController.isuserLogin.value ==
                              //             false &&
                              //         globalHomeController.isTraineeLogin.value ==
                              //             false))

                              if (homeController.isTrainingEnabled)
                                const Tab(
                                  text: 'Training',
                                  iconMargin: EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.transfer_within_a_station,
                                    color: ColorResources.color294C73,
                                    size: 30,
                                  ),
                                ),
                              // if (globalHomeController.isCalibrationLogin.value ||
                              //     !globalHomeController.isuserLogin.value &&
                              //         globalHomeController
                              //             .isCalibrationLogin.value ||
                              //     !globalHomeController.isuserLogin.value &&
                              //         !globalHomeController
                              //             .isCalibrationLogin.value)
                              if (homeController.isCalibrationEnabled)
                                Tab(
                                    iconMargin: EdgeInsets.all(0),
                                    text: 'Calibration',
                                    icon: Image.asset(
                                      'assets/images/calibration.png',
                                      height: 30,
                                      width: 30,
                                    )),
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
                    // if (globalHomeController.isuserLogin.value == true ||
                    //     (globalHomeController.isuserLogin.value == false &&
                    //         globalHomeController.isTraineeLogin.value == false))
                    if (homeController.isInspectionEnabled)
                      Tab2(
                        btnText: 'Inspection',
                        imgurlList: const [
                          'https://s3-alpha-sig.figma.com/img/641b/30d6/0527f4c4463314a0e51342ca65015b8a?Expires=1701648000&Signature=b3Vf84hA3SPBQdsIYadxD69GmrohKr3CvC~q1CD57dD4NSTWzQMisHJtTaQ~NMufu9IIN2KEsnM4wcyss~flnFXyvB1xWmHLWwXrqCgvyrKDQq0tIP76lrodeGfsiE4YUm4A0IBOoihQoml9jmYxufepXFh0DhaWY-qHczbDczDEHnzzaqjqalyrhhhzbJlQGZb5RDEQOqYhk5XZ96G02DYdXRsmz~bLqfN~gZSBb47X7eRpYICs5ARKnID~0MqIWokpkb34~ZlrynYc1TglNRUy3soJoe3VM3ptaR~kCf2AsN8vAr0e5BEV45Jyzwzl~mJjjO5TcIrsk8ExdSQPRg__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4'
                        ],
                        cContainer: homeController.isUserLoggedIn
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
                                            if (!homeController
                                                .isHomeLoading.value) {
                                              homeController.focusNode
                                                  .unfocus();
                                              homeController
                                                      .functionsTrainingTab2[
                                                  index]();
                                            }
                                          },
                                          icon: GetBuilder<HomeController>(
                                              builder: (locationData) {
                                            return homeColorContainer(
                                                contentText: homeController
                                                        .contentTextTrainingTab2[
                                                    index],
                                                numberText: index == 0
                                                    ? homeController
                                                        .inspectionHomeCount[
                                                            'Location_Count']
                                                        .toString()
                                                    : index == 1
                                                        ? homeController
                                                            .inspectionHomeCount[
                                                                'Equipment_Count']
                                                            .toString()
                                                        : index == 2
                                                            ? homeController
                                                                .inspectionHomeCount[
                                                                    'Exp_Equipment_Count']
                                                                .toString()
                                                            : index == 3
                                                                ? homeController
                                                                    .inspectionHomeCount[
                                                                        'Task_Count']
                                                                    .toString()
                                                                : '0',
                                                //  index == 0
                                                //     ? homeController
                                                //         .customerLocations
                                                //         .length
                                                //         .toString()
                                                //     : index == 1
                                                //         ? homeController
                                                //             .customerEquipmentData
                                                //             .length
                                                //             .toString()
                                                //         : index == 2
                                                //             ? homeController
                                                //                 .customerEquipmentExpiringData
                                                //                 .length
                                                //                 .toString()
                                                //             : index == 3
                                                //                 ? upcomingInspectionsController
                                                //                     .upcomingInspectionListData
                                                //                     .length
                                                //                     .toString()
                                                //                 : '0',
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
                    // if (globalHomeController.isTraineeLogin.value == true ||
                    //     (globalHomeController.isuserLogin.value == false &&
                    //         globalHomeController.isTraineeLogin.value == false))
                    if (homeController.isTrainingEnabled)
                      const TrainingHomeScreen(),
                    // Calibration
                    if (homeController.isCalibrationEnabled)
                      // if (globalHomeController.isCalibrationLogin.value == true ||
                      //     (globalHomeController.isuserLogin.value == false &&
                      //         globalHomeController.isCalibrationLogin.value ==
                      //             true) ||
                      //     (globalHomeController.isuserLogin.value == false &&
                      //         globalHomeController.isCalibrationLogin.value ==
                      //             false))
                      Tab2(
                        btnText: 'Calibration',
                        imgurlList: const [
                          'https://s3-alpha-sig.figma.com/img/641b/30d6/0527f4c4463314a0e51342ca65015b8a?Expires=1701648000&Signature=b3Vf84hA3SPBQdsIYadxD69GmrohKr3CvC~q1CD57dD4NSTWzQMisHJtTaQ~NMufu9IIN2KEsnM4wcyss~flnFXyvB1xWmHLWwXrqCgvyrKDQq0tIP76lrodeGfsiE4YUm4A0IBOoihQoml9jmYxufepXFh0DhaWY-qHczbDczDEHnzzaqjqalyrhhhzbJlQGZb5RDEQOqYhk5XZ96G02DYdXRsmz~bLqfN~gZSBb47X7eRpYICs5ARKnID~0MqIWokpkb34~ZlrynYc1TglNRUy3soJoe3VM3ptaR~kCf2AsN8vAr0e5BEV45Jyzwzl~mJjjO5TcIrsk8ExdSQPRg__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4'
                        ],
                        cContainer: homeController.isUserLoggedIn
                            ? Wrap(
                                spacing: Get.width > 615 ? 30.w : 10.w,
                                runSpacing: Get.width > 615 ? 30.w : 10.w,
                                children: List.generate(
                                    homeController
                                        .contentTextTrainingTab2.length,
                                    (index) => IconButton(
                                          padding: const EdgeInsets.all(2),
                                          onPressed: () {
                                            if (!homeController
                                                .isHomeLoading.value) {
                                              homeController.focusNode
                                                  .unfocus();
                                              homeController
                                                      .functionsTrainingTab2[
                                                  index]();
                                            }
                                          },
                                          icon: GetBuilder<HomeController>(
                                              builder: (locationData) {
                                            return homeColorContainer(
                                                contentText: homeController
                                                        .contentTextTrainingTab2Calibration[
                                                    index],
                                                numberText: index == 0
                                                    ? homeController
                                                        .calibrationHomeCount[
                                                            'Location_Count']
                                                        .toString()
                                                    : index == 1
                                                        ? homeController
                                                            .calibrationHomeCount[
                                                                'Equipment_Count']
                                                            .toString()
                                                        : index == 2
                                                            ? homeController
                                                                .calibrationHomeCount[
                                                                    'Exp_Equipment_Count']
                                                                .toString()
                                                            : index == 3
                                                                ? homeController
                                                                    .calibrationHomeCount[
                                                                        'Task_Count']
                                                                    .toString()
                                                                : '0',
                                                //  index == 0
                                                //     ? homeController
                                                //         .customerLocations
                                                //         .length
                                                //         .toString()
                                                //     : index == 1
                                                //         ? homeController
                                                //             .customerEquipmentDataCalibration
                                                //             .length
                                                //             .toString()
                                                //         : index == 2
                                                //             ? homeController
                                                //                 .customerEquipmentExpiringDataCalibration
                                                //                 .length
                                                //                 .toString()
                                                //             : index == 3
                                                //                 ? upcomingInspectionsController
                                                //                     .upcomingInspectionListDataCalibration
                                                //                     .length
                                                //                     .toString()
                                                //                 : '0',
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
                            text: 'We\'re ready for',
                            style: GoogleFonts.roboto(
                                color: ColorResources.color294C73,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: ' Calibration',
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
                  ],
                ),
              ),
            );
          }),
        ),
        if (isLoading)
          Container(
            height: double.infinity,
            color: Colors.black.withAlpha(20),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
