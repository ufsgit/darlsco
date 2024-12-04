import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/controller/upcoming_inspections/upcoming_inspection_controller.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/training/task_page.dart';
import 'package:darlsco/view/training/training_screen.dart';
import 'package:darlsco/view/training/widgets/bottom_navigation_widget.dart';
import 'package:darlsco/view/up_coming_inspectons/up_coming_inspections_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controller/login/login_controller.dart';
import '../../core/constants/color_resources.dart';

class TrainingInspectionScreen extends StatefulWidget {
  const TrainingInspectionScreen({super.key, this.selectedIndex = 0});
  final int selectedIndex;
  @override
  State<TrainingInspectionScreen> createState() =>
      _TrainingInspectionScreenState();
}

class _TrainingInspectionScreenState extends State<TrainingInspectionScreen> {
  final upcomingInspectionsController =
      Get.put(UpcomingInspectionsController());
      bool isLoading =false;
  // final TrainingControllerHomee trainingControllerHomee =
  //     Get.put(TrainingControllerHomee());
  // final TrainingController tcontroller = Get.put(TrainingController());
  // final TrainingControllerHomee trainingHomeController =
  //     Get.put(TrainingControllerHomee());
  @override
  void initState() {
    getData();

    //  homeController.getAllusers();
// print('dfnojwenfoiw ${homeController.isInspectionSection.value}');
// print('dfnojwenfoiw ${homeController.isTrainingSectionnew.value}');
    try {} finally {}
    print('dfnojwenfoiw ${upcomingInspectionsController.isLoading.value}');

    super.initState();
  }

  getData() async {
    try {
      await upcomingInspectionsController.taskInitFunction(context);
    } finally {
      upcomingInspectionsController.isLoading.value = false;
    }
  }

  bool areAnyTwoTrue = [
        homeController.isTrainingEnabled,
        homeController.isInspectionEnabled,
        homeController.isCalibrationEnabled
      ].where((element) => element).length >=
      2;

  @override
  Widget build(BuildContext context) {
    print('homeC ${homeController.isCalibrationSection.value}');

    return GetBuilder<HomeController>(builder: (loginData) {
      return DefaultTabController(
        initialIndex: widget.selectedIndex,
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
        child: PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: MediaQuery.of(context).size.width > 600 &&
                      MediaQuery.of(context).size.width < 1440
                  ? Size(390.w, 100.h)
                  : Size(390.w, 150.h),
              child: commonBackgroundLinearColorCart(
                childWidget: AppBar(
                  leading: Container(),
                  backgroundColor: ColorResources.colorTransparent,
                  // leading: Builder(builder: (ctx) {
                  //   return customDrawerIcon(context: ctx);
                  // }),
                  actions: [
                    // TextButton(
                    //     onPressed: () {
                    //       var data = {"type": "new_trainer"};
                    //       homeController.isCalibrationSection.value = homeController.isCalibrationEnabled && data['type'] == 'Calibration_Task';
                    //       homeController.isInspectionSection.value = homeController.isInspectionEnabled && data['type'] == 'Inspection_Task';
                    //       homeController.isTrainingSectionnew.value =
                    //           homeController.isTrainingEnabled && data['type'] == 'new_trainer' || homeController.isTrainingEnabled && data['type'] == 'Exam';

                    //       Get.offAll(
                    //         TrainingInspectionScreen(
                    //           selectedIndex: homeController.isInspectionSection.value
                    //               ? 0
                    //               : homeController.isTrainingSectionnew.value
                    //                   ? homeController.isInspectionEnabled
                    //                       ? 1
                    //                       : 0
                    //                   : homeController.isCalibrationSection.value
                    //                       ? !homeController.isInspectionEnabled && !homeController.isTrainingEnabled
                    //                           ? 0
                    //                           : !homeController.isInspectionEnabled && homeController.isTrainingEnabled ||
                    //                                   homeController.isInspectionEnabled && !homeController.isTrainingEnabled
                    //                               ? 1
                    //                               : homeController.isInspectionEnabled && homeController.isTrainingEnabled && homeController.isCalibrationEnabled
                    //                                   ? 2
                    //                                   : 0
                    //                       : 0,
                    //         ),
                    //       );
                    //     },
                    //     child: Text('gjbi')),
                    Container(
                      // alignment: Alignment.centerRight,

                      child: InkWell(
                          onTap: () {
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
                                        const Text("Are you sure to logout?")
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
                                      await loginController.logout(context);
                                      // await Get.to(
                                      //     () => BottomNavigationWidget());
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor: ColorResources.whiteColor,
                              child: Center(
                                  child: Icon(
                                size: 18.sp,
                                Icons.power_settings_new_rounded,
                                color: Colors.black,
                              )))),
                    ),
                    SizedBox(
                      width: 10.w,
                    )
                  ],

                  bottom: TabBar(
                    onTap: (index) async {
                      homeController.mainTabIndex = index;
                      homeController.isInspectionSection.value =
                          index == 0 && homeController.isInspectionEnabled;
                      homeController.isTrainingSectionnew.value =
                          index == 0 && !homeController.isInspectionEnabled ||
                              index == 1 &&
                                  homeController.isTrainingEnabled &&
                                  homeController.isInspectionEnabled;

                      homeController.isCalibrationSection.value = index == 0 &&
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
                      homeController.isInspectionSection.value =
                          index == 0 && homeController.isInspectionEnabled;
                      homeController.isTrainingSectionnew.value =
                          index == 0 && !homeController.isInspectionEnabled ||
                              index == 1 &&
                                  homeController.isTrainingEnabled &&
                                  homeController.isInspectionEnabled;

                      homeController.isCalibrationSection.value = index == 0 &&
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
                      upcomingInspectionsController.taskInitFunction(context);
                    },
                    tabAlignment: TabAlignment.fill,
                    // isScrollable: true,
                    indicatorColor: ColorResources.colorE5AA17,
                    unselectedLabelColor: ColorResources.color294C73,
                    dividerHeight: 0,
                    labelColor: ColorResources.color294C73,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 64.h),
                    indicatorWeight: 3.5,
                    labelStyle: GoogleFonts.dmSans(
                      color: ColorResources.color294C73,
                      fontSize: 16.sp.h,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: [
                      // if (loginData.isuserLogin.value == true)
                      if (homeController.isInspectionEnabled)
                        const Tab(
                            iconMargin: EdgeInsets.all(0),
                            text: 'Inspection',
                            icon: Icon(Icons.query_stats,
                                color: ColorResources.color294C73, size: 30)),
                      // if (loginData.isTraineeLogin.value == true)

                      if (homeController.isTrainingEnabled)
                        const Tab(
                            text: 'Training',
                            iconMargin: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.transfer_within_a_station,
                              color: ColorResources.color294C73,
                              size: 30,
                            )),
                      // if (globalHomeController.isCalibrationLogin.value ||
                      //         !globalHomeController.isuserLogin.value &&
                      //             globalHomeController
                      //                 .isCalibrationLogin.value ||
                      //         !globalHomeController.isuserLogin.value &&
                      //             !globalHomeController
                      //                 .isCalibrationLogin.value)
                      if (homeController.isCalibrationEnabled)
                        Tab(
                            text: 'Calibration',
                            iconMargin: EdgeInsets.all(0),
                            icon: Image.asset(
                              'assets/images/calibration.png',
                              height: 30,
                              width: 30,
                            )),

                      // Tab(
                      //     iconMargin: const EdgeInsets.all(0),
                      //     text: 'Calibration',
                      //     icon: Icon(Icons.settings,
                      //         color: ColorResources.color294C73, size: 30))
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // if (loginData.isuserLogin.value == true)
                if (homeController.isInspectionEnabled)
                  commonBackgroundLinearColorHome(
                    childWidget: DefaultTabController(
                      initialIndex: 1,
                      length: 4,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: PreferredSize(
                          preferredSize: Size(70.w, 70.h),
                          child: AppBar(
                            centerTitle: true,
                            leading: Container(),
                            backgroundColor: Colors.transparent,
                            title: Text(
                              "Task Details",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorResources.color294C73,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            bottom: TabBar(
                              onTap: (index) async {
                                upcomingInspectionsController
                                    .selectDateTaskListData
                                    .clear();
                                upcomingInspectionsController
                                    .selectDateTaskListDataCalibration
                                    .clear();
                                upcomingInspectionsController.update();
                                upcomingInspectionsController
                                    .startDatePickController
                                    .clear();
                                upcomingInspectionsController
                                    .endDatePickController
                                    .clear();

                                upcomingInspectionsController
                                    .selectDateTaskListData
                                    .clear();
                                upcomingInspectionsController
                                    .selectDateTaskListDataCalibration
                                    .clear();

                                upcomingInspectionsController
                                    .update(['date_picker_in']);

                                await upcomingInspectionsController
                                    .taskInitFunction(context);
                                print(index);
                              },
                              tabAlignment: TabAlignment.fill,
                              isScrollable: false,
                              indicatorColor: ColorResources.colorE5AA17,
                              unselectedLabelColor: ColorResources.color294C73,
                              labelColor: ColorResources.color294C73,
                              tabs: [
                                Text(
                                  "Yesterday",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.color294C73,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Today",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.color294C73,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Tomorrow",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.color294C73,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Filter",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.color294C73,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        body: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              RefreshIndicator(
                                onRefresh: () async {
                                  await upcomingInspectionsController
                                      .taskInitFunction(context);
                                },
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child:
                                      GetBuilder<UpcomingInspectionsController>(
                                          builder: (yesterdayData) {
                                    return Container(
                                      padding: EdgeInsets.all(15.sp),
                                      child: yesterdayData.isLoading.value
                                          ? SizedBox(
                                              height: 500.h,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : yesterdayData
                                                  .yesterdayTaskListData.isEmpty
                                              ? SizedBox(
                                                  height: 500.h,
                                                  child: const Center(
                                                    child:
                                                        Text('Task not found!'),
                                                  ),
                                                )
                                              : taskListTileData(
                                                  taskListData: yesterdayData
                                                      .yesterdayTaskListData),
                                    );
                                  }),
                                ),
                              ),
                              RefreshIndicator(
                                onRefresh: () async {
                                  await upcomingInspectionsController
                                      .taskInitFunction(context);
                                },
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child:
                                      GetBuilder<UpcomingInspectionsController>(
                                          builder: (todayData) {
                                    return Container(
                                      padding: EdgeInsets.all(15.sp),
                                      child: todayData.isLoading.value
                                          ? SizedBox(
                                              height: 500.h,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : todayData.todayTaskListData.isEmpty
                                              ? SizedBox(
                                                  height: 500.h,
                                                  child: const Center(
                                                    child:
                                                        Text('Task not found!'),
                                                  ),
                                                )
                                              : taskListTileData(
                                                  taskListData: todayData
                                                      .todayTaskListData),
                                    );
                                  }),
                                ),
                              ),
                              RefreshIndicator(
                                onRefresh: () async {
                                  await upcomingInspectionsController
                                      .taskInitFunction(context);
                                },
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child:
                                      GetBuilder<UpcomingInspectionsController>(
                                          builder: (tommorowData) {
                                    return Container(
                                      child: tommorowData.isLoading.value
                                          ? SizedBox(
                                              height: 500.h,
                                              child: const Center(
                                                child: Text('Task not found!'),
                                              ),
                                            )
                                          : tommorowData
                                                  .tommorowTaskListData.isEmpty
                                              ? SizedBox(
                                                  height: 500.h,
                                                  child: const Center(
                                                    child:
                                                        Text('Task not found!'),
                                                  ),
                                                )
                                              : taskListTileData(
                                                  taskListData: tommorowData
                                                      .tommorowTaskListData),
                                    );
                                  }),
                                ),
                              ),
                            
                              Container(
                                padding: EdgeInsets.all(15.sp),
                                // color: Colors.amber,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: Get.width,
                                        // height: 227.h,
                                        padding: EdgeInsets.all(15.sp),
                                        margin: EdgeInsets.only(top: 20.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: ColorResources.whiteColor,
                                        ),
                                        child: Column(
                                          children: [
                                            Wrap(
                                              alignment: WrapAlignment.start,
                                              runSpacing:
                                                  Get.width < 615 ? 5.h : 15.h,
                                              spacing:
                                                  Get.width < 615 ? 5.w : 15.w,
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                datepickerWidget(
                                                    context: context,
                                                    datePickController:
                                                        upcomingInspectionsController
                                                            .startDatePickController,
                                                    labelText: 'From Date',
                                                    titleText: ''),
                                                datepickerWidget(
                                                    context: context,
                                                    datePickController:
                                                        upcomingInspectionsController
                                                            .endDatePickController,
                                                    labelText: 'To Date',
                                                    titleText: ''),
                                                SizedBox(
                                                  height: 13.h,
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child:isLoading? CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ):  IconButton(
                                                onPressed: () async {
                                                  try {
                                                     setState(() {
                                                      isLoading=true;
                                                    });
                                                    if (upcomingInspectionsController
                                                          .startDatePickController
                                                          .text
                                                          .isNotEmpty &&
                                                      upcomingInspectionsController
                                                          .endDatePickController
                                                          .text
                                                          .isNotEmpty) {
                                                    if (DateFormat('dd-MM-yyyy')
                                                        .parse(upcomingInspectionsController
                                                            .startDatePickController
                                                            .text)
                                                        .isAfter(DateFormat(
                                                                'dd-MM-yyyy')
                                                            .parse(upcomingInspectionsController
                                                                .endDatePickController
                                                                .text))) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Choose valid date!')));
                                                    } else {
                                                      upcomingInspectionsController
                                                              .isDateSubmitBtnClicked =
                                                          true;
                                                      if (homeController
                                                          .isCalibrationSection
                                                          .value) {
                                                        upcomingInspectionsController
                                                                .selectDateTaskListDataCalibration =
                                                            await upcomingInspectionsController
                                                                .getuserTaskDateRange(
                                                          isInitSate: false,
                                                          startDate: DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(upcomingInspectionsController
                                                                  .startDatePickController
                                                                  .text),
                                                          endDate: DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(upcomingInspectionsController
                                                                  .endDatePickController
                                                                  .text),
                                                        );
                                                      } else {
                                                        upcomingInspectionsController
                                                                .selectDateTaskListData =
                                                            await upcomingInspectionsController
                                                                .getuserTaskDateRange(
                                                          isInitSate: false,
                                                          startDate: DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(upcomingInspectionsController
                                                                  .startDatePickController
                                                                  .text),
                                                          endDate: DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(upcomingInspectionsController
                                                                  .endDatePickController
                                                                  .text),
                                                        );
                                                      }
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'From Date and To Date is Required!')));
                                                  }
                                                  } catch (e) {
                                                    
                                                  }finally{
                                                    setState(() {
                                                      isLoading=false;
                                                    });
                                                  }
                                                },
                                                icon: Container(
                                                  width: 84.w,
                                                  height: 32.h,
                                                  decoration: BoxDecoration(
                                                      color: ColorResources
                                                          .color32C000,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              43.r)),
                                                  child: Center(
                                                      child: Text(
                                                    "Submit",
                                                    style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ColorResources
                                                          .whiteColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      GetBuilder<UpcomingInspectionsController>(
                                          id: 'date_picker_in',
                                          builder: (selectData) {
                                            return Container(
                                              child: selectData
                                                          .selectDateTaskListData
                                                          .isEmpty &&
                                                      upcomingInspectionsController
                                                          .endDatePickController
                                                          .text
                                                          .isNotEmpty &&
                                                      upcomingInspectionsController
                                                          .startDatePickController
                                                          .text
                                                          .isNotEmpty &&
                                                      upcomingInspectionsController
                                                              .isDateSubmitBtnClicked ==
                                                          true
                                                  ? const Center(
                                                      child: Text(
                                                          'Task not found!'),
                                                    )
                                                  : taskListTileData(
                                                      taskListData: selectData
                                                          .selectDateTaskListData),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                // if (loginData.isTraineeLogin.value == true)
                if (homeController.isTrainingEnabled) const TaskPage(),
                if (homeController.isCalibrationEnabled)
                  commonBackgroundLinearColorHome(
                    childWidget: DefaultTabController(
                      initialIndex: 1,
                      length: 4,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: PreferredSize(
                          preferredSize: Size(70.w, 70.h),
                          child: AppBar(
                            centerTitle: true,
                            leading: Container(),
                            backgroundColor: Colors.transparent,
                            title: Text(
                              "Task Details",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorResources.color294C73,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            bottom: TabBar(
                              onTap: (index) async {
                                upcomingInspectionsController
                                    .selectDateTaskListData
                                    .clear();
                                upcomingInspectionsController
                                    .selectDateTaskListDataCalibration
                                    .clear();
                                upcomingInspectionsController.update();
                                upcomingInspectionsController
                                    .startDatePickController
                                    .clear();
                                upcomingInspectionsController
                                    .endDatePickController
                                    .clear();

                                upcomingInspectionsController
                                    .selectDateTaskListData
                                    .clear();
                                upcomingInspectionsController
                                    .selectDateTaskListDataCalibration
                                    .clear();

                                upcomingInspectionsController
                                    .update(['date_picker_ca']);

                                await upcomingInspectionsController
                                    .taskInitFunction(context);
                                print(index);
                              },
                              tabAlignment: TabAlignment.fill,
                              isScrollable: false,
                              indicatorColor: ColorResources.colorE5AA17,
                              unselectedLabelColor: ColorResources.color294C73,
                              labelColor: ColorResources.color294C73,
                              tabs: [
                                Text(
                                  "Yesterday",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.color294C73,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Today",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.color294C73,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Tomorrow",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.color294C73,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Filter",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.color294C73,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        body: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              RefreshIndicator(
                                onRefresh: () async {
                                  await upcomingInspectionsController
                                      .taskInitFunction(context);
                                  print(
                                      'jj213483jjj ${upcomingInspectionsController.yesterdayTaskListDataCalibration}');
                                },
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child:
                                      GetBuilder<UpcomingInspectionsController>(
                                          builder: (yesterdayData) {
                                    return Container(
                                      padding: EdgeInsets.all(15.sp),
                                      child: yesterdayData.isLoading.value
                                          ? SizedBox(
                                              height: 500.h,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : yesterdayData
                                                  .yesterdayTaskListDataCalibration
                                                  .isEmpty
                                              ? SizedBox(
                                                  height: 500.h,
                                                  child: const Center(
                                                    child:
                                                        Text('Task not found!'),
                                                  ),
                                                )
                                              : taskListTileData(
                                                  taskListData: yesterdayData
                                                      .yesterdayTaskListDataCalibration),
                                    );
                                  }),
                                ),
                              ),
                              RefreshIndicator(
                                onRefresh: () async {
                                  await upcomingInspectionsController
                                      .taskInitFunction(context);
                                },
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child:
                                      GetBuilder<UpcomingInspectionsController>(
                                          builder: (todayData) {
                                    return Container(
                                      padding: EdgeInsets.all(15.sp),
                                      child: todayData.isLoading.value
                                          ? SizedBox(
                                              height: 500.h,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : todayData
                                                  .todayTaskListDataCalibration
                                                  .isEmpty
                                              ? SizedBox(
                                                  height: 500.h,
                                                  child: const Center(
                                                    child:
                                                        Text('Task not found!'),
                                                  ),
                                                )
                                              : taskListTileData(
                                                  taskListData: todayData
                                                      .todayTaskListDataCalibration),
                                    );
                                  }),
                                ),
                              ),
                              RefreshIndicator(
                                onRefresh: () async {
                                  await upcomingInspectionsController
                                      .taskInitFunction(context);
                                },
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child:
                                      GetBuilder<UpcomingInspectionsController>(
                                          builder: (tommorowData) {
                                    return Container(
                                      child: tommorowData.isLoading.value
                                          ? SizedBox(
                                              height: 500.h,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : tommorowData
                                                  .tommorowTaskListDataCalibration
                                                  .isEmpty
                                              ? SizedBox(
                                                  height: 500.h,
                                                  child: const Center(
                                                    child:
                                                        Text('Task not found!'),
                                                  ),
                                                )
                                              : taskListTileData(
                                                  taskListData: tommorowData
                                                      .tommorowTaskListDataCalibration),
                                    );
                                  }),
                                ),
                              ),
                           
                              Container(
                                padding: EdgeInsets.all(15.sp),
                                // color: Colors.amber,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: Get.width,
                                        // height: 227.h,
                                        padding: EdgeInsets.all(15.sp),
                                        margin: EdgeInsets.only(top: 20.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: ColorResources.whiteColor,
                                        ),
                                        child: Column(
                                          children: [
                                            Wrap(
                                              alignment: WrapAlignment.start,
                                              runSpacing:
                                                  Get.width < 615 ? 5.h : 15.h,
                                              spacing:
                                                  Get.width < 615 ? 5.w : 15.w,
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                datepickerWidget(
                                                    context: context,
                                                    datePickController:
                                                        upcomingInspectionsController
                                                            .startDatePickController,
                                                    labelText: 'From Date',
                                                    titleText: ''),
                                                datepickerWidget(
                                                    context: context,
                                                    datePickController:
                                                        upcomingInspectionsController
                                                            .endDatePickController,
                                                    labelText: 'To Date',
                                                    titleText: ''),
                                                SizedBox(
                                                  height: 13.h,
                                                ),
                                              ],
                                            ),
                                            
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child:isLoading? CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ): IconButton(
                                                onPressed: () async {
                                                 try {
                                                  setState(() {
                                                    isLoading=true;
                                                  }); 
                                                    if (upcomingInspectionsController
                                                          .startDatePickController
                                                          .text
                                                          .isNotEmpty &&
                                                      upcomingInspectionsController
                                                          .endDatePickController
                                                          .text
                                                          .isNotEmpty) {
                                                    if (DateFormat('dd-MM-yyyy')
                                                        .parse(upcomingInspectionsController
                                                            .startDatePickController
                                                            .text)
                                                        .isAfter(DateFormat(
                                                                'dd-MM-yyyy')
                                                            .parse(upcomingInspectionsController
                                                                .endDatePickController
                                                                .text))) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Choose valid date!')));
                                                    } else {
                                                      upcomingInspectionsController
                                                              .isDateSubmitBtnClicked =
                                                          true;
                                                      if (homeController
                                                          .isCalibrationSection
                                                          .value) {
                                                        upcomingInspectionsController
                                                                .selectDateTaskListDataCalibration =
                                                            await upcomingInspectionsController
                                                                .getCalibrationTasks(
                                                          isInitSate: false,
                                                          startDate: DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(upcomingInspectionsController
                                                                  .startDatePickController
                                                                  .text),
                                                          endDate: DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(upcomingInspectionsController
                                                                  .endDatePickController
                                                                  .text),
                                                        );
                                                      } else {
                                                        upcomingInspectionsController
                                                                .selectDateTaskListData =
                                                            await upcomingInspectionsController
                                                                .getuserTaskDateRange(
                                                          isInitSate: false,
                                                          startDate: DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(upcomingInspectionsController
                                                                  .startDatePickController
                                                                  .text),
                                                          endDate: DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(upcomingInspectionsController
                                                                  .endDatePickController
                                                                  .text),
                                                        );
                                                      }
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'From Date and To Date is Required!')));
                                                  }
                                               
                                                 } catch (e) {
                                                  
                                                 }finally{
                                                  setState(() {
                                                    isLoading=false;
                                                  }); 
                                                 }
                                                  },
                                                icon: Container(
                                                  width: 84.w,
                                                  height: 32.h,
                                                  decoration: BoxDecoration(
                                                      color: ColorResources
                                                          .color32C000,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              43.r)),
                                                  child: Center(
                                                      child: Text(
                                                    "Submit",
                                                    style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ColorResources
                                                          .whiteColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      GetBuilder<UpcomingInspectionsController>(
                                          id: 'date_picker_ca',
                                          builder: (selectData) {
                                            return Container(
                                              child: selectData
                                                          .selectDateTaskListDataCalibration
                                                          .isEmpty &&
                                                      upcomingInspectionsController
                                                          .endDatePickController
                                                          .text
                                                          .isNotEmpty &&
                                                      upcomingInspectionsController
                                                          .startDatePickController
                                                          .text
                                                          .isNotEmpty &&
                                                      upcomingInspectionsController
                                                              .isDateSubmitBtnClicked ==
                                                          true
                                                  ? const Center(
                                                      child: Text(
                                                          'Task not found!'),
                                                    )
                                                  : taskListTileData(
                                                      taskListData: selectData
                                                          .selectDateTaskListDataCalibration),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                // DummyWidget(),
              ],
            ),
            // UpgradeAlert(

            //   upgrader: Upgrader(

            //     messages: EnglishUpgradeMessages(),
            //           durationUntilAlertAgain: Duration.zero,
            //           minAppVersion: '2.0.1',),
            //       showIgnore: false,
            //       showLater: false,
            //       showReleaseNotes: false,

            //   child:
            // ),
          ),
        ),
      );
    });
  }

  SizedBox datepickerWidget(
      {required BuildContext context,
      required String labelText,
      required TextEditingController datePickController,
      required String titleText}) {
    FocusScope.of(context).unfocus();
    return SizedBox(
      width: Get.width > 615 ? 375.w : 340.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   titleText,
          //   style: TextStyle(
          //     fontFamily: "DM Sans",
          //     fontSize: 14.sp,
          //     fontWeight: FontWeight.w700,
          //     color: ColorResources.color294C73,
          //   ),
          //   textAlign: TextAlign.left,
          // ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 45.h,
            child: TextField(
              style: TextStyle(fontSize: 14.sp),
              controller: datePickController,
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    size: 18.sp,
                    color: ColorResources.color294C73,
                  ),
                  border: const OutlineInputBorder(),
                  label: Text(labelText)),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    barrierDismissible: false,
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate!);

                setState(() {
                  datePickController.text = formattedDate;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  RefreshIndicator taskListTileData({required List taskListData}) {
    return RefreshIndicator(
      onRefresh: () async {
        await upcomingInspectionsController.taskInitFunction(context);
      },
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 15.w,
          runSpacing: 15.h,
          children: List.generate(
            taskListData.length,
            (index) => InkWell(
              splashColor: ColorResources.color294C73,
              borderRadius: BorderRadius.circular(6.sp),
              onLongPress: () {},
              onTap: () {
                // upcomingInspectionsController.isScreenLoading.value = true;
                
               Get.to(()=>TrainningScreen( status: taskListData[index]['Task_Status_Name'],
                    taskId: taskListData[index]['Task_Id']));
              },
              child: Container(
                width: 367.w,
                // height: 217.h,
                margin: EdgeInsets.only(
                    top: 5.h, right: 5.w, left: 5.w, bottom: 5.w),
                padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 15.sp),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.sp)),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      color: ColorResources.color294C73.withOpacity(0.10),
                      size: 100.sp,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   equipmentListController
                        //       .equipmentListData[index]['title'],
                        //   style: TextStyle(
                        //     fontFamily: "DM Sans",
                        //     fontSize: 16.sp,
                        //     fontWeight: FontWeight.w700,
                        //     color: ColorResources.color294C73,
                        //   ),
                        //   textAlign: TextAlign.left,
                        // ),
                        // SizedBox(
                        //   height: 18.h,
                        // ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 50,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      upcomingInspectionCommonItemWidget(
                                        icon: Icons.business,
                                        valueText: taskListData[index]
                                                ['Task_Name'] ??
                                            '',
                                      ),
                                      upcomingInspectionCommonItemWidget(
                                        icon: Icons.calendar_month,
                                        valueText: DateFormat('dd-MM-yyyy')
                                            .format(DateTime.parse(
                                                taskListData[index]
                                                        ['Task_Date'] ??
                                                    '')),
                                      ),
                                      upcomingInspectionCommonItemWidget(
                                          icon: Icons.timer_outlined,
                                          valueText: taskListData[index]
                                                  ['Time'] ??
                                              ''),
                                      upcomingInspectionCommonItemWidget(
                                        icon: Icons.location_on_outlined,
                                        valueText: taskListData[index]
                                                ['Location_Name'] ??
                                            '',
                                      ),
                                      upcomingInspectionCommonItemWidget(
                                        icon: Icons.task_alt_outlined,
                                        valueText: taskListData[index]
                                                ['Task_Status_Name'] ??
                                            '',
                                      ),
                                      // upcomingInspectionCommonItemWidget(
                                      //   icon: Icons.abc,
                                      //   valueText: equipmentListController
                                      //       .equipmentListData[index]['make'],
                                      // ),
                                      //  upcomingInspectionCommonItemWidget(
                                      //   icon: Icons.abc,
                                      //   valueText: equipmentListController.equipmentListData[index]['model'],
                                      // ),
                                      //  upcomingInspectionCommonItemWidget(
                                      //   icon:  Icons.abc,
                                      //   valueText: equipmentListController.equipmentListData[index]['serial_no'],
                                      // ),
                                      //  upcomingInspectionCommonItemWidget(
                                      //   icon:  Icons.abc,
                                      //   valueText: equipmentListController.equipmentListData[index]['expiring_date'],
                                      // ),
                                    ]),
                              ),
                            ]),

                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
