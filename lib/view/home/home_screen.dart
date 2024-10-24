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
    bool areAnyTwoTrue = [
          homeController.isTraineeLogin.value,
          homeController.isuserLogin.value,
          homeController.isCalliberationLogin.value
        ].where((element) => element).length >=
        2;
    if ( homeController.isTraineeLogin.value == false &&
                    homeController.isuserLogin.value == false &&
                    homeController.isCalliberationLogin.value == false ||
                homeController.isTraineeLogin.value == true &&
                    homeController.isuserLogin.value == true &&
                    homeController.isCalliberationLogin.value == true) {
      print('tabIndex 3');
    } else if(areAnyTwoTrue){
            print('tabIndex 2');

    } else{
      print('tabIndex ${homeController.isCalliberationLogin.value }');
      print('tabIndex 1 ${widget.initialIndex}');
    }
    _tabController = TabController(
        length: homeController.isTraineeLogin.value == false &&
                    homeController.isuserLogin.value == false &&
                    homeController.isCalliberationLogin.value == false ||
                homeController.isTraineeLogin.value == true &&
                    homeController.isuserLogin.value == true &&
                    homeController.isCalliberationLogin.value == true
            ? 3
            : areAnyTwoTrue
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
                                homeController.isuserLogin.value == true &&
                                    homeController.isTraineeLogin.value == true
                            ? false
                            : true,

                        tabAlignment: homeController.isuserLogin.value ==
                                        false &&
                                    homeController.isTraineeLogin.value ==
                                        false ||
                                homeController.isuserLogin.value == true &&
                                    homeController.isTraineeLogin.value == true
                            ? TabAlignment.fill
                            : TabAlignment.start,

                        onTap: (index) async {
                          if (index == 1 &&
                              homeController.isTraineeLogin.value == true &&
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
                          } else if (index == 2) {
                             globalHomeController.isTrainingSection.value =
                                false;
                            globalHomeController.isCaliberationSection.value =
                                true;
                            homeController.tabIndex.value = index;
                          }else
                          {
                            globalHomeController.isTrainingSection.value = true;
                            globalHomeController.isCaliberationSection.value =
                                false;
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
                          if (globalHomeController.isuserLogin.value == true ||
                              (globalHomeController.isuserLogin.value ==
                                      false &&
                                  globalHomeController.isTraineeLogin.value ==
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
                                  globalHomeController.isTraineeLogin.value ==
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
                            if(globalHomeController.isCalliberationLogin.value||!globalHomeController.isuserLogin.value&&!globalHomeController.isCalliberationLogin.value)
                             const Tab(
                              iconMargin: EdgeInsets.all(0),
                              text: 'Calliberation',
                              icon: Icon(
                                Icons.settings,
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
                        globalHomeController.isTraineeLogin.value == false))
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
                                homeController.contentTextTrainingTab2.length,
                                (index) => IconButton(
                                      padding: const EdgeInsets.all(2),
                                      onPressed: () {
                                        // ScaffoldMessenger.of(context)
                                        // .showSnackBar(const SnackBar(

                                        //   content: Text('server failure')));
                                        homeController
                                            .functionsTrainingTab2[index]();
                                      },
                                      icon: GetBuilder<HomeController>(
                                          builder: (locationData) {
                                        return homeColorContainer(
                                            contentText: homeController
                                                .contentTextTrainingTab2[index],
                                            numberText: index == 0
                                                ? homeController
                                                    .customerLocations.length
                                                    .toString()
                                                : index == 1
                                                    ? homeController
                                                        .customerEquipmentData
                                                        .length
                                                        .toString()
                                                    : index == 2
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
                                                .cBgColorTrainingTab2[index],
                                            numBgColor: homeController
                                                .numBgColorTrainingTab2[index]);
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
                  // CALLIBERATION
                if (globalHomeController.isTraineeLogin.value == true ||
                    (globalHomeController.isuserLogin.value == false &&
                        globalHomeController.isTraineeLogin.value == false))
                  const TrainingHomeScreen(),
                 if (globalHomeController.isCalliberationLogin.value == true ||
                    (globalHomeController.isuserLogin.value == false &&
                        globalHomeController.isCalliberationLogin.value == false))
                  Tab2(
                    btnText: 'Calliberation',
                    imgurlList: const [
                      'https://s3-alpha-sig.figma.com/img/641b/30d6/0527f4c4463314a0e51342ca65015b8a?Expires=1701648000&Signature=b3Vf84hA3SPBQdsIYadxD69GmrohKr3CvC~q1CD57dD4NSTWzQMisHJtTaQ~NMufu9IIN2KEsnM4wcyss~flnFXyvB1xWmHLWwXrqCgvyrKDQq0tIP76lrodeGfsiE4YUm4A0IBOoihQoml9jmYxufepXFh0DhaWY-qHczbDczDEHnzzaqjqalyrhhhzbJlQGZb5RDEQOqYhk5XZ96G02DYdXRsmz~bLqfN~gZSBb47X7eRpYICs5ARKnID~0MqIWokpkb34~ZlrynYc1TglNRUy3soJoe3VM3ptaR~kCf2AsN8vAr0e5BEV45Jyzwzl~mJjjO5TcIrsk8ExdSQPRg__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4'
                    ],
                    cContainer: homeController.isuserLogin.value == true
                        ? Wrap(
                            spacing: Get.width > 615 ? 30.w : 10.w,
                            runSpacing: Get.width > 615 ? 30.w : 10.w,
                            children: List.generate(
                                homeController.contentTextTrainingTab2.length,
                                (index) => IconButton(
                                      padding: const EdgeInsets.all(2),
                                      onPressed: () {
                                        // ScaffoldMessenger.of(context)
                                        // .showSnackBar(const SnackBar(

                                        //   content: Text('server failure')));
                                        homeController
                                            .functionsTrainingTab2[index]();
                                      },
                                      icon: GetBuilder<HomeController>(
                                          builder: (locationData) {
                                        return homeColorContainer(
                                            contentText: homeController
                                                .contentTextTrainingTab2[index],
                                            numberText: index == 0
                                                ? homeController
                                                    .customerLocations.length
                                                    .toString()
                                                : index == 1
                                                    ? homeController
                                                        .customerEquipmentData
                                                        .length
                                                        .toString()
                                                    : index == 2
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
                                                .cBgColorTrainingTab2[index],
                                            numBgColor: homeController
                                                .numBgColorTrainingTab2[index]);
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
              ],
            ),
          ),
        );
      }),
    );
  }
}
