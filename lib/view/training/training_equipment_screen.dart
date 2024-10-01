import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/controller/upcoming_inspections/upcoming_inspection_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/color_resources.dart';
import '../../core/constants/common_widgets.dart';
import '../risk_assessment/risk_assessment_screen.dart';

class TrainingEquipmentScreen extends StatefulWidget {
  final int taskId;
  const TrainingEquipmentScreen({super.key, required this.taskId});

  @override
  State<TrainingEquipmentScreen> createState() =>
      _TrainingEquipmentScreenState();
}

class _TrainingEquipmentScreenState extends State<TrainingEquipmentScreen>
    with SingleTickerProviderStateMixin {
  late final equipmentTabBarController = TabController(length: 3, vsync: this);
  @override
  void initState() {
    // tcontoller.searchEquipment();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Get.width < 615 ? Size(150.w, 150.h) : Size(250.w, 100.h),
          child: commonBackgroundLinearColor(
            childWidget: AppBar(
              backgroundColor: ColorResources.colorTransparent,
              leading: IconButton(
                  onPressed: () {
                    upcomingInspectionsController.getUserTaskDetails(
                        taskId: widget.taskId);

                    // upcomingInspectionsController.update();
                    // tcontoller.geofenceService.stop();
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  )),

              // Builder(builder: (ctx) {
              //   return customDrawerIcon(context: ctx);
              // }),
              bottom: TabBar(
                onTap: (index) async {
                  equipmentTabBarController.index = index;

                  // switch (index) {
                  //   case 0:

                  //     //  upcomingInspectionsController.testEquipmentSearchResult.clear();

                  //     await upcomingInspectionsController.getTestEquipment(
                  //       taskUserDetailsId: upcomingInspectionsController
                  //           .taskUserDetails[0]['Task_User_Details_Id'],
                  //       taskId: upcomingInspectionsController.taskDetailsData[0]
                  //           ['Task_Id'],
                  //     );

                  //     upcomingInspectionsController.update(['equipment_list']);

                  //     upcomingInspectionsController
                  //         .searchControllerTestEquipment
                  //         .clear();
                  //     upcomingInspectionsController.searchControllerTestPpe
                  //         .clear();
                  //     upcomingInspectionsController.searchControllerTestDocument
                  //         .clear();

                  //     break;

                  //   case 1:
                  //     upcomingInspectionsController
                  //         .searchControllerTestEquipment
                  //         .clear();
                  //     upcomingInspectionsController.searchControllerTestPpe
                  //         .clear();
                  //     upcomingInspectionsController.searchControllerTestDocument
                  //         .clear();
                  //     await upcomingInspectionsController.getTestppe(
                  //       taskUserDetailsId: upcomingInspectionsController
                  //           .taskUserDetails[0]['Task_User_Details_Id'],
                  //       taskId: upcomingInspectionsController.taskDetailsData[0]
                  //           ['Task_Id'],
                  //     );
                  //     // upcomingInspectionsController.update(['equipment_list']);

                  //     upcomingInspectionsController.update(['equipment_list']);

                  //     break;

                  //   case 2:
                  //     await upcomingInspectionsController.getTestDocument(
                  //       taskUserDetailsId: upcomingInspectionsController
                  //           .taskUserDetails[0]['Task_User_Details_Id'],
                  //       taskId: upcomingInspectionsController.taskDetailsData[0]
                  //           ['Task_Id'],
                  //     );
                  //     upcomingInspectionsController.update(['equipment_list']);

                  //     upcomingInspectionsController
                  //         .searchControllerTestEquipment
                  //         .clear();
                  //     upcomingInspectionsController.searchControllerTestPpe
                  //         .clear();
                  //     upcomingInspectionsController.searchControllerTestDocument
                  //         .clear();

                  //     break;
                  // }
                  // setState(() {});
                  // setState(() {
                  //   equipmentTabBarController.index = index;
                  // });
                  // switch (index) {
                  //   case 0:
                  //     equipmentTabBarController.index = 1;
                  //     break;
                  //   case 1:
                  //     equipmentTabBarController.index = 2;
                  //     break;
                  //   default:
                  //     equipmentTabBarController.index = 0;
                  //     break;
                  // }
                },
                controller: equipmentTabBarController,
                indicatorColor: ColorResources.colorE5AA17,
                unselectedLabelColor: ColorResources.color294C73,
                tabAlignment: TabAlignment.fill,
                // isScrollable: Get.width < 615 ? false : true,
                labelColor: ColorResources.color294C73,
                tabs: [
                  Tab(
                      text: 'Test Equipment',
                      iconMargin: const EdgeInsets.all(0),
                      icon: Icon(
                        Icons.transfer_within_a_station,
                        color: ColorResources.color294C73,
                        size: 30.sp,
                      )),
                  Tab(
                      iconMargin: const EdgeInsets.all(0),
                      text: 'PPE',
                      icon: Icon(Icons.query_stats,
                          color: ColorResources.color294C73, size: 30.sp)),
                  Tab(
                      iconMargin: const EdgeInsets.all(0),
                      text: 'Document',
                      icon: Icon(Icons.settings,
                          color: ColorResources.color294C73, size: 30.sp))
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: equipmentTabBarController,
          children: [
            tab(
              equipmentKeyId: 'Test_Equiptment_Id',
              equipmentKeyName: 'Test_Equiptment_Name',
              searchText: 'Search Test Equipment...',
              searchResultText:
                  upcomingInspectionsController.testEquipmentSearchResult,
              cWidth: 250.w,
              mainList: upcomingInspectionsController.usedEquipmentData,
              searchController:
                  upcomingInspectionsController.searchControllerTestEquipment,
            ),
            tab(
              equipmentKeyId: 'Test_PPE_Id',
              equipmentKeyName: 'Test_PPE_Name',
              searchText: 'Search PPE....',
              mainList: upcomingInspectionsController.usedTestppeData,
              searchController:
                  upcomingInspectionsController.searchControllerTestPpe,
              searchResultText:
                  upcomingInspectionsController.testPpeSearchResult,
              cWidth: 250.w,
            ),
            tab(
                equipmentKeyId: 'Test_Document_Id',
                equipmentKeyName: 'Test_Document_Name',
                searchText: 'Search Documents....',
                searchResultText:
                    upcomingInspectionsController.testDocumentSearchResult,
                cWidth: 250.w,
                mainList: upcomingInspectionsController.usedTestDocumentData,
                searchController:
                    upcomingInspectionsController.searchControllerTestDocument,
                expandFlex: 10),
          ],
        ),
        bottomNavigationBar: Container(
          height: 50.h,
          color: ColorResources.colorE5AA17,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {});
                  switch (equipmentTabBarController.index) {
                    case 0:
                      equipmentTabBarController.index = 1;
                      break;
                    case 1:
                      equipmentTabBarController.index = 2;
                      break;
                    case 2:
                      tcontoller.initialIndex.value = 1;

                      Get.to(() => const RiskAssessmentScreen());

                      break;
                    default:
                      equipmentTabBarController.index = 0;
                      break;
                  }
                },
                child: Container(
                  width: 220.w,
                  height: 60.h,
                  color: const Color(0xffFFF1CD),
                  child: Center(
                      child: Text(
                    "Skip",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.color0d0d0d,
                    ),
                  )),
                ),
              ),
              InkWell(
                splashColor: Colors.black,
                onLongPress: () {},
                onTap: () {
                  switch (equipmentTabBarController.index) {
                    case 0:
                      List emptyListCheck = upcomingInspectionsController
                          .usedEquipmentData
                          .where((e) => e['Is_Checkbox'] == true)
                          .toList();

                      if (emptyListCheck.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content:
                                Text('Select atleast one Test Equipment!')));
                      } else {
                        equipmentTabBarController.index = 1;
                      }

                      break;
                    case 1:
                      List emptyListCheck = upcomingInspectionsController
                          .usedTestppeData
                          .where((e) => e['Is_Checkbox'] == true)
                          .toList();

                      if (emptyListCheck.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Select atleast one PPE!')));
                      } else {
                        equipmentTabBarController.index = 2;
                      }

                      break;
                    case 2:
                      List emptyListCheck = upcomingInspectionsController
                          .usedTestDocumentData
                          .where((e) => e['Is_Checkbox'] == true)
                          .toList();

                      if (emptyListCheck.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Select atleast one Document!')));
                      } else {
                        // equipmentTabBarController.index = 0;
                        upcomingInspectionsController.saveTaskTest(
                            context: context);
                      }

                      break;
                    default:
                      // equipmentTabBarController.index = 0;
                      break;
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5.sp),
                  width: Get.width > 615 ? 600.w : 160.w,
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorResources.color0d0d0d,
                        height: 14.9767427444458 / 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container tab(
      {required String searchText,
      required List searchResultText,
      required List mainList,
      required TextEditingController searchController,
      required double? cWidth,
      required String equipmentKeyId,
      required String equipmentKeyName,
      int expandFlex = 30}) {
    searchController.clear();
    return commonBackgroundLinearColorHome(
        childWidget: GetBuilder<UpcomingInspectionsController>(
            id: 'equipment_list',
            builder: (data) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: Get.width > 615 ? 450.w : 238.w,
                          // height: 40,
                          child: TextFormField(
                            controller: searchController,
                            scrollPadding: const EdgeInsets.all(0),
                            style: TextStyle(fontSize: 16.sp),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              hintText: searchText,
                              contentPadding: EdgeInsets.all(10.sp),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r)),
                              suffixIcon: Icon(
                                Icons.search,
                                size: 16.sp,
                                color: ColorResources.color294C73,
                              ),
                            ),
                            onChanged: (value) async {
                              searchResultText =
                                  await upcomingInspectionsController
                                      .equipmentSearch(
                                          nameKey: equipmentKeyName,
                                          value: value,
                                          mainList: mainList,
                                          searchResultList: searchResultText);
                              upcomingInspectionsController
                                  .update(['equipment_list']);
                              tcontoller.update();
                              // upcomingInspectionsController.getTestEquipment(
                              //     taskId: upcomingInspectionsController.taskDetailsData[0]
                              //         ['Task_Id'],
                              //     searchValue: value);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Wrap(
                          runSpacing: 20.h,
                          spacing: 20.w,
                          children: List.generate(
                              searchResultText.length,
                              (index) => SizedBox(
                                    width: cWidth?.w,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 10,
                                          child: Checkbox(
                                            splashRadius: 0,
                                            value: searchResultText[index]
                                                ['Is_Checkbox'],
                                            onChanged: (value) {
                                              searchResultText[index]
                                                  ['Is_Checkbox'] = value;
                                              mainList
                                                      .where((element) =>
                                                          element[
                                                              equipmentKeyId] ==
                                                          searchResultText[
                                                                  index]
                                                              [equipmentKeyId])
                                                      .toList()[0]
                                                  ['Is_Checkbox'] = value;
                                              upcomingInspectionsController
                                                  .update(['equipment_list']);
                                            },
                                          ),
                                        ),
                                        // Expanded(
                                        //   flex: 20,
                                        //   child: SizedBox(
                                        //     width: 15.w,
                                        //   ),
                                        // ),
                                        Expanded(
                                          flex: 50,
                                          child: SizedBox(
                                              // padding:
                                              //     EdgeInsets.only(right: 10.w),
                                              width: Get.width * 0.77,
                                              child: Text(
                                                searchResultText[index]
                                                    [equipmentKeyName],
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorResources
                                                      .color0d0d0d,
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  )),
                        )
                      ]),
                ),
              );
            }));
  }
}
