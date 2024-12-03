import 'package:darlsco/controller/upcoming_inspections/upcoming_inspection_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/risk_assessment/risk_assessment_stop_screen.dart';
import 'package:darlsco/view/training/training_screen_mobile.dart';
import 'package:darlsco/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/tainning/trainnig_controller.dart';
import '../../core/constants/common_widgets.dart';
import 'training_equipment_screen.dart';

class TrainningScreenTab extends StatefulWidget {
  const TrainningScreenTab({super.key});

  @override
  State<TrainningScreenTab> createState() => _TrainningScreenTabState();
}

class _TrainningScreenTabState extends State<TrainningScreenTab> {
  final UpcomingInspectionsController upcomingInspectionsController =
      Get.put(UpcomingInspectionsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(390.w, 60.h),
        child: commonBackgroundLinearColor(
          childWidget: AppBar(
            backgroundColor: ColorResources.colorTransparent,
            leading: IconButton(
                onPressed: () {
                  upcomingInspectionsController.selectDateTaskListData.clear();
                  upcomingInspectionsController
                      .selectDateTaskListDataCalibration
                      .clear();
                  upcomingInspectionsController.taskInitFunction(context);

                  Get.back();
                  upcomingInspectionsController.update();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                )),

            // Builder(builder: (ctx) {
            //   return customDrawerIcon(context: ctx);
            // }),
          ),
        ),
      ),
      bottomNavigationBar: commonBottomButton(context),
      body: commonBackgroundLinearColorHome(
        childWidget: Container(
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                  width: 800.w,
                  // height: 435.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: GetBuilder<UpcomingInspectionsController>(
                      builder: (data) {
                    var eqData = homeController.isCalibrationSection.value
                        ? upcomingInspectionsController
                            .taskUserDetailsCalibration
                        : upcomingInspectionsController.taskUserDetails;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),

                        if (!homeController.isCalibrationSection.value &&
                                eqData[0]['Role_Id'].toString() == '38' &&
                                eqData[0]['Task_Status_Id'].toString() == '1' ||
                            homeController.isCalibrationSection.value &&
                                eqData[0]['Role_Id'].toString() == '38' &&
                                eqData[0]['Task_Status_Id'].toString() == '15')
                          tcontoller.isTaskStarted.value == false
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      homeController.getAllusers();
                                    },
                                    icon: Container(
                                      height: 30.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                          color: ColorResources.color294C73,
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                      child: Center(
                                        child: Text(
                                          'Update Team',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        SizedBox(
                          height: 20.h,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.business,
                                  color: ColorResources.color294C73,
                                  size: 21.sp,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  width: 290.w,
                                  child: Text(
                                    'Customer Name',
                                    style: TextStyle(
                                      fontFamily: "DM Sans",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: ColorResources.color294C73,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Container(
                            //   width: 143.w,
                            //   height: 32.h,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(43.r),
                            //       color: ColorResources.colorF2ccff),
                            //   child: Center(
                            //       child: Text(
                            //     'visual,periodic',
                            //     style: TextStyle(
                            //       fontFamily: "Roboto",
                            //       fontSize: 14.sp,
                            //       fontWeight: FontWeight.w500,
                            //       color: ColorResources.color0d0d0d,
                            //     ),
                            //   )),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),

                        Text(
                          homeController.isCalibrationSection.value
                              ? data.taskDetailsDataCalibration[0]
                                      ['Customer_Name'] ??
                                  ''
                              : data.taskDetailsData[0]['Customer_Name'] ?? '',
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),

                        Row(
                          children: [
                            Icon(
                              Icons.work,
                              color: ColorResources.color294C73,
                              size: 21.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Job Order No',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorResources.color294C73,
                              ),
                            )
                          ],
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 10.w),
                          // margin: EdgeInsets.only(left:Get.width>615? 35.w:0),
                          child: Text(
                            homeController.isCalibrationSection.value
                                ? data.taskDetailsDataCalibration[0]
                                        ['Work_Code'] ??
                                    ''
                                : data.taskDetailsData[0]['Work_Code'] ?? '',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorResources.color0d0d0d,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15.h,
                        ),

                        Row(
                          children: [
                            Icon(
                              Icons.task,
                              color: ColorResources.color294C73,
                              size: 21.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Task Name',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorResources.color294C73,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.w),
                          // margin: EdgeInsets.only(left:Get.width>615? 35.w:0),
                          child: Text(
                            homeController.isCalibrationSection.value
                                ? data.taskDetailsDataCalibration[0]
                                        ['Task_Name'] ??
                                    ''
                                : data.taskDetailsData[0]['Task_Name'] ?? '',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorResources.color0d0d0d,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 15.h,
                        // ),
                        // Text(
                        //   data.taskUserDetails[0]['Start_Notes'] ?? '',
                        //   style: TextStyle(
                        //     fontFamily: "Roboto",
                        //     fontSize: 13.sp,
                        //     fontWeight: FontWeight.w400,
                        //     color: ColorResources.color0d0d0d,
                        //   ),
                        // ),
                        SizedBox(
                          height: 15.h,
                        ),

                        //          if(upcomingInspectionsController.taskUserDetails[0]['Role_Id'].toString()=='38')     SizedBox(
                        //         height: 25.h,
                        //       ),
                        // if(upcomingInspectionsController.taskUserDetails[0]['Role_Id'].toString()=='38')       GetBuilder<HomeController>(builder: (data) {

                        //               return DropdownButtonFormField(
                        //                   value: data.inspectionDropdownValue.value ==
                        //                           ''
                        //                       ? null
                        //                       : data.inspectionDropdownValue.value,
                        //                   decoration: const InputDecoration(
                        //                       // hintText: data.inspectionDropdownValue.value
                        //                       //     .isEmpty? 'Location':'',
                        //                       border: OutlineInputBorder()),
                        //                   onChanged: (value) {
                        //                     data.getAllUsersList.clear();
                        //                     data.equipmentCheckValue.clear();
                        //                     data.inspectionDropdownValue.value =
                        //                         value.toString();
                        //                   },
                        //                   hint: Text('Users'),
                        //                   items: data.getAllUsersList
                        //                       .map((e) => DropdownMenuItem(
                        //                             value: e['User_Details_Name'].toString(),
                        //                             child: Text( e['User_Details_Name'].toString()),
                        //                           ))
                        //                       .toList());
                        //             }),

                        Wrap(
                          runSpacing: 15.h,
                          spacing: 15.w,
                          children: List.generate(
                            tcontoller.commonGridTexts.length,
                            (index) => trainningGridWidget(
                                cWidth: tcontoller.commonGridTexts[index]
                                            ['title'] ==
                                        'Equipment List'
                                    ? 400
                                    : 230,
                                titleText: tcontoller.commonGridTexts[index]
                                    ['title'],
                                subTitle: tcontoller.commonGridTexts[index]
                                    ['sub_title'],
                                icon: tcontoller.commonGridTexts[index]['icon'],
                                border: (index + 1) % 3 != 0 &&
                                        index !=
                                            tcontoller.commonGridTexts.length -
                                                1
                                    ? const BorderSide(
                                        color: ColorResources.colorD1D1D1)
                                    : BorderSide.none),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),

                        Obx(
                          () => Container(
                            child: tcontoller.othersChecked.value
                                ? TextFormField(
                                    controller:
                                        tcontoller.otherEqupmentNotecntrlr,
                                    maxLines: 3,
                                    maxLength: 500,
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.chat_bubble_outline),
                                        labelText: 'Additional Equipment Name',
                                        border: OutlineInputBorder()),
                                  )
                                : Container(),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.note,
                              color: ColorResources.color294C73,
                              size: 21.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            SizedBox(
                              width: 290.w,
                              child: Text(
                                'Task Description',
                                style: TextStyle(
                                  fontFamily: "DM Sans",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: ColorResources.color294C73,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        commonNoteWidget(
                            isReadOnly: true,
                            data: homeController.isCalibrationSection.value
                                ? upcomingInspectionsController
                                            .taskDetailsDataCalibration[0]
                                        ['Task_Note'] ??
                                    ''
                                : upcomingInspectionsController
                                        .taskDetailsData[0]['Task_Note'] ??
                                    ''),

                        if (!homeController.isCalibrationSection.value &&
                            upcomingInspectionsController.taskUserDetails[0]
                                        ['Role_Id']
                                    .toString() ==
                                '38')
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.edit_document,
                                    color: ColorResources.color294C73,
                                    size: 21.sp,
                                  ),
                                  Text(
                                    'Task Type',
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w800,
                                      color: ColorResources.color294C73,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Wrap(
                                children: [
                                  SizedBox(
                                    width: 105.w,
                                    child: Row(
                                      children: [
                                        Obx(() => Checkbox(
                                            value: tcontoller.visualCheck.value,
                                            onChanged: (value) {
                                              print(value);
                                              tcontoller.visualCheck.value =
                                                  value!;
                                              homeController.isStartBtnClicked
                                                  .value = false;

                                              // tcontoller.update();
                                            })),
                                        Text('Visual',
                                            style: TextStyle(fontSize: 12.sp))
                                      ],
                                    ),
                                  ),

                                  // SizedBox(
                                  //   width: 105,
                                  //   child: selectTaskTypeCheckBox(
                                  //       checkBoxName: 'Visual',
                                  //       checkValue: tcontoller.visualCheck),
                                  // ),

                                  SizedBox(
                                    width: 105.w,
                                    child: Row(
                                      children: [
                                        Obx(() => Checkbox(
                                            value:
                                                tcontoller.periodicCheck.value,
                                            onChanged: (value) {
                                              tcontoller.periodicCheck.value =
                                                  value!;
                                              print(
                                                  'periodic value ${tcontoller.periodicCheck.value}');
                                              homeController.isStartBtnClicked
                                                  .value = false;

                                              //  tcontroller.update();
                                            })),
                                        Text('Periodic',
                                            style: TextStyle(fontSize: 12.sp))
                                      ],
                                    ),
                                  ),

                                  // SizedBox(
                                  //   width: 105,
                                  //   child: selectTaskTypeCheckBox(
                                  //       checkBoxName: 'Periodic',
                                  //       checkValue: tcontroller.periodicCheck),
                                  // ),
                                  SizedBox(
                                    width: 105.w,
                                    child: Row(
                                      children: [
                                        Obx(() => Checkbox(
                                            value: tcontoller.majorCheck.value,
                                            onChanged: (value) {
                                              tcontoller.majorCheck.value =
                                                  value!;
                                              homeController.isStartBtnClicked
                                                  .value = false;
                                              //  tcontroller.update();
                                            })),
                                        Text('Major',
                                            style: TextStyle(fontSize: 12.sp))
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    width: 105.w,
                                    child: Row(
                                      children: [
                                        Obx(() => Checkbox(
                                            value:
                                                tcontoller.inServiceCheck.value,
                                            onChanged: (value) {
                                              tcontoller.inServiceCheck.value =
                                                  value!;
                                              homeController.isStartBtnClicked
                                                  .value = false;

                                              //  tcontoller.update();
                                            })),
                                        Text('In-Service',
                                            style: TextStyle(fontSize: 12.sp))
                                      ],
                                    ),
                                  ),

                                  // SizedBox(
                                  //   width: 105,
                                  //   child: selectTaskTypeCheckBox(
                                  //       checkBoxName: 'Thorough',
                                  //       checkValue: tcontroller.thoroughCheck),
                                  // ),

                                  SizedBox(
                                    width: 105.w,
                                    child: Row(
                                      children: [
                                        Obx(() => Checkbox(
                                            value:
                                                tcontoller.thoroughCheck.value,
                                            onChanged: (value) {
                                              tcontoller.thoroughCheck.value =
                                                  value!;
                                              homeController.isStartBtnClicked
                                                  .value = false;

                                              //  tcontoller.update();
                                            })),
                                        Text('Thorough',
                                            style: TextStyle(fontSize: 12.sp))
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    width: 200.w,
                                    child: Row(
                                      children: [
                                        Obx(() => Checkbox(
                                            value: tcontoller
                                                .independentCheck.value,
                                            onChanged: (value) {
                                              tcontoller.independentCheck
                                                  .value = value!;
                                              homeController.isStartBtnClicked
                                                  .value = false;

                                              //  tcontoller.update();
                                            })),
                                        Text('Independent',
                                            style: TextStyle(fontSize: 12.sp))
                                      ],
                                    ),
                                  ),

                                  // SizedBox(
                                  //   width: 105.w,
                                  //   child: Row(
                                  //     children: [
                                  //       Obx(() => Checkbox(
                                  //           value:
                                  //               tcontoller.thoroughCheck.value,
                                  //           onChanged: (value) {
                                  //             tcontoller.thoroughCheck.value =
                                  //                 value!;
                                  //             homeController.isStartBtnClicked
                                  //                 .value = false;

                                  //             //  tcontoller.update();
                                  //           })),
                                  //       Text('Independent')
                                  //     ],
                                  //   ),
                                  // ),

                                  SizedBox(
                                    width: 200.w,
                                    child: Row(
                                      children: [
                                        Obx(() => Checkbox(
                                            value: tcontoller
                                                .examinationCheck.value,
                                            onChanged: (value) {
                                              tcontoller.examinationCheck
                                                  .value = value!;
                                              homeController.isStartBtnClicked
                                                  .value = false;

                                              //  tcontoller.update();
                                            })),
                                        Text('Initial Examination',
                                            style: TextStyle(fontSize: 12.sp))
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 105.w,
                                  //   child: selectTaskTypeCheckBox(
                                  //       checkBoxName: 'Major',
                                  //       checkValue: tcontroller.majorCheck),
                                  // )
                                ],
                              ),
                            ],
                          ),
                      ],
                    );
                  }),
                ),
                SizedBox(
                  height: 5.h,
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 20.w),
                //   child: Text(
                //     "Enter Notes",
                //     style: TextStyle(
                //       fontFamily: "Roboto",
                //       fontSize: 14.sp,
                //       fontWeight: FontWeight.w400,
                //       color: const Color(0xff000000),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

commonBottomButton(BuildContext context) {
  print('periodic value ${tcontoller.periodicCheck.value}');
  if (homeController.isCalibrationSection.value) {
    return upcomingInspectionsController.taskUserDetailsCalibration[0]
                        ['Task_Status_Id']
                    .toString() ==
                '4' ||
            upcomingInspectionsController.taskUserDetailsCalibration[0]
                        ['Task_Status_Id']
                    .toString() ==
                '15'
        ?

        // return

        InkWell(
            splashColor: ColorResources.color294C73,
            borderRadius: BorderRadius.circular(6.sp),
            onLongPress: () {},
            onTap: () async {
              // await upcomingInspectionsController.saveTaskUserStart();
              final equipmentCheck = upcomingInspectionsController
                  .taskEquipmentListDataCalibration
                  .where((element) => element['Checked'].toString() == '1')
                  .toList();
              print('equipmenkeoeioeiot list $equipmentCheck');

              if (equipmentCheck.isNotEmpty) {
                if (upcomingInspectionsController
                            .taskEquipmentListDataCalibration.last['Checked']
                            .toString() ==
                        '1' &&
                    upcomingInspectionsController
                            .taskEquipmentListDataCalibration
                            .last['Equipment_Name']
                            .toString() ==
                        'Other' &&
                    tcontoller.otherEqupmentNotecntrlr.text.isEmpty) {
                  ScaffoldMessenger.of(Get.context!).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Enter Additional Equipment Name Recieved!')));
                } else {
                  if (upcomingInspectionsController
                          .taskUserDetailsCalibration[0]['Role_Id']
                          .toString() ==
                      '38') {
                    // if (tcontoller.visualCheck.value == true ||
                    //     tcontoller.periodicCheck.value == true ||
                    //     tcontoller.thoroughCheck.value == true ||
                    //     tcontoller.inServiceCheck.value == true ||
                    //     tcontoller.examinationCheck.value == true ||
                    //     tcontoller.independentCheck.value == true ||
                    //     tcontoller.majorCheck.value == true) {

                    final userEnter = await tcontoller.geofenceLocation(
                      fenceLatitude: upcomingInspectionsController
                              .taskDetailsDataCalibration.isEmpty
                          ? 10.005548201562277
                          : double.parse(upcomingInspectionsController
                              .taskDetailsDataCalibration[0]['Latitude']
                              .toString()),
                      fenceLongitude: upcomingInspectionsController
                              .taskDetailsDataCalibration.isEmpty
                          ? 76.37540812327876
                          : double.parse(upcomingInspectionsController
                              .taskDetailsDataCalibration[0]['Longitude']
                              .toString()),
                    );

                    if (userEnter == 'inside') {
                      if (tcontoller.isTaskStarted.value == true) {
                        // await upcomingInspectionsController.getTestEquipment(
                        //   taskUserDetailsId: upcomingInspectionsController
                        //           .taskUserDetailsCalibration[0]
                        //       ['Task_User_Details_Id'],
                        //   taskId: upcomingInspectionsController
                        //       .taskDetailsDataCalibration[0]['Task_Id'],
                        // );
                        // // await upcomingInspectionsController.getUserTaskDetails(taskId: upcomingInspectionsController
                        // //       .taskDetailsData[0]['Task_Id']); // need to change
                        // await upcomingInspectionsController.getTestppe(
                        //   taskUserDetailsId: upcomingInspectionsController
                        //           .taskUserDetailsCalibration[0]
                        //       ['Task_User_Details_Id'],
                        //   taskId: upcomingInspectionsController
                        //       .taskDetailsDataCalibration[0]['Task_Id'],
                        // );
                        // await upcomingInspectionsController.getTestDocument(
                        //   taskUserDetailsId: upcomingInspectionsController
                        //           .taskUserDetailsCalibration[0]
                        //       ['Task_User_Details_Id'],
                        //   taskId: upcomingInspectionsController
                        //       .taskDetailsDataCalibration[0]['Task_Id'],
                        // );

                        // Get.to(() => TrainingEquipmentScreen(
                        //       taskId: int.parse(upcomingInspectionsController
                        //           .taskDetailsDataCalibration[0]['Task_Id']
                        //           .toString()),
                        //     ));
                      } else {
                        showDialog(
                          barrierDismissible: false,
                          context: Get.context!,
                          builder: (ctx) => AlertDialog(
                            // title: const Text(
                            //   'Logout',
                            //   style: TextStyle(fontWeight: FontWeight.w800),
                            // ),
                            content: const SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Are you sure you want to start? Please confirm your equipment selection in the equipment list. Once you start your task, you won't be able to change it again.")
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
                                child: const Text('Continue'),
                                onPressed: () async {
                                  Get.back();
                                  // await upcomingInspectionsController
                                  //     .getTestEquipment(
                                  //   taskUserDetailsId:
                                  //       upcomingInspectionsController
                                  //               .taskUserDetailsCalibration[
                                  //           0]['Task_User_Details_Id'],
                                  //   taskId: upcomingInspectionsController
                                  //           .taskDetailsDataCalibration[0]
                                  //       ['Task_Id'],
                                  // );
                                  // await upcomingInspectionsController
                                  //     .getTestppe(
                                  //   taskUserDetailsId:
                                  //       upcomingInspectionsController
                                  //               .taskUserDetailsCalibration[
                                  //           0]['Task_User_Details_Id'],
                                  //   taskId: upcomingInspectionsController
                                  //           .taskDetailsDataCalibration[0]
                                  //       ['Task_Id'],
                                  // );
                                  // await upcomingInspectionsController
                                  //     .getTestDocument(
                                  //   taskUserDetailsId:
                                  //       upcomingInspectionsController
                                  //               .taskUserDetailsCalibration[
                                  //           0]['Task_User_Details_Id'],
                                  //   taskId: upcomingInspectionsController
                                  //           .taskDetailsDataCalibration[0]
                                  //       ['Task_Id'],
                                  // );
                                  await upcomingInspectionsController
                                      .saveTaskUserStart();
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(Get.context!).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Your current location doesn't match the task location. You won't be able to start the task!")));
                    }

                    //  } else {
                    //   if (homeController.isStartBtnClicked.value == false) {
                    //     ScaffoldMessenger.of(Get.context!).showSnackBar(
                    //         const SnackBar(content: Text('Select Task Type')));
                    //   }
                    //   homeController.isStartBtnClicked.value = true;
                    // }
                  } else {
                    print(upcomingInspectionsController
                        .taskDetailsDataCalibration.isEmpty);
                    print(upcomingInspectionsController
                        .taskDetailsDataCalibration[0]['Latitude']);
                    print(upcomingInspectionsController
                        .taskDetailsDataCalibration[0]['Longitude']);
                    final userEnter = await tcontoller.geofenceLocation(
                      fenceLatitude: upcomingInspectionsController
                              .taskDetailsDataCalibration.isEmpty
                          ? 10.005548201562277
                          : double.parse(upcomingInspectionsController
                              .taskDetailsDataCalibration[0]['Latitude']
                              .toString()),
                      fenceLongitude: upcomingInspectionsController
                              .taskDetailsDataCalibration.isEmpty
                          ? 76.37540812327876
                          : double.parse(upcomingInspectionsController
                              .taskDetailsDataCalibration[0]['Longitude']
                              .toString()),
                    );

                    if (userEnter == 'inside') {
                      //  await upcomingInspectionsController.saveTaskUserStart();
                      // await upcomingInspectionsController.getTestEquipment(
                      //   taskUserDetailsId: upcomingInspectionsController
                      //       .taskUserDetails[0]['Task_User_Details_Id'],
                      //   taskId: upcomingInspectionsController.taskDetailsData[0]
                      //       ['Task_Id'],
                      // );
                      // await upcomingInspectionsController.getTestppe(
                      //   taskUserDetailsId: upcomingInspectionsController
                      //       .taskUserDetails[0]['Task_User_Details_Id'],
                      //   taskId: upcomingInspectionsController.taskDetailsData[0]
                      //       ['Task_Id'],
                      // );
                      // await upcomingInspectionsController.getTestDocument(
                      //   taskUserDetailsId: upcomingInspectionsController
                      //       .taskUserDetails[0]['Task_User_Details_Id'],
                      //   taskId: upcomingInspectionsController.taskDetailsData[0]
                      //       ['Task_Id'],
                      // );

                      if (tcontoller.isTaskStarted.value == true) {
                        Get.to(() => const RiskAssesmentStopScreen());
                      } else {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (ctx) => AlertDialog(
                            // title: const Text(
                            //   'Logout',
                            //   style: TextStyle(fontWeight: FontWeight.w800),
                            // ),
                            content: const SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Are you sure you want to start? Please confirm your equipment selection in the equipment list. Once you start your task, you won't be able to change it again.")
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
                                child: const Text('Continue'),
                                onPressed: () async {
                                  Get.back();

                                  await upcomingInspectionsController
                                      .saveTaskUserStart();
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(Get.context!).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Your current location doesn't match the task location. You won't be able to start the task!")));
                    }

                    // if (tcontoller.isTaskStarted.value == false) {
                    //        tcontoller.geofenceService
                    //       .addGeofenceStatusChangeListener(tcontoller.onGeofenceStatusChanged);
                    //   tcontoller.geofenceService
                    //       .addLocationChangeListener(tcontoller.onLocationChanged);
                    //   tcontoller.geofenceService.addLocationServicesStatusChangeListener(
                    //       tcontoller.onLocationServicesStatusChanged);
                    //   tcontoller.geofenceService
                    //       .addActivityChangeListener(tcontoller.onActivityChanged);
                    //   tcontoller.geofenceService.addStreamErrorListener(tcontoller.onError);
                    //   tcontoller.geofenceService
                    //       .start(tcontoller.geofenceList)
                    //       .catchError(tcontoller.onError);
                    //   // await upcomingInspectionsController.saveTaskUserStart();
                    // } else {
                    //   Get.to(() => const RiskAssesmentStopScreen());
                    // }
                  }
                }
              } else {
                ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
                    content: Text("Select atleast one equipment!")));
              }
            },
            child: Container(
              height: 50.h,
              color: ColorResources.colorE5AA17,
              child: Center(
                  child: Obx(
                () => Text(
                  tcontoller.isTaskStarted.value == false
                      ? "Start"
                      : 'View Details',
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorResources.color0d0d0d,
                    height: 14.9767427444458 / 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
            ),
          )
        : const SizedBox();
  } else {
    return upcomingInspectionsController.taskUserDetails[0]['Task_Status_Id']
                    .toString() ==
                '4' ||
            upcomingInspectionsController.taskUserDetails[0]['Task_Status_Id']
                    .toString() ==
                '1'
        ?

        // return

        InkWell(
            splashColor: ColorResources.color294C73,
            borderRadius: BorderRadius.circular(6.sp),
            onLongPress: () {},
            onTap: () async {
              // await upcomingInspectionsController.saveTaskUserStart();

              final equipmentCheck = upcomingInspectionsController
                  .taskEquipmentListData
                  .where((element) => element['Checked'].toString() == '1')
                  .toList();
              print(
                  'equipment list ${upcomingInspectionsController.taskEquipmentListData}');

              if (equipmentCheck.isNotEmpty) {
                if (upcomingInspectionsController
                            .taskEquipmentListData.last['Checked']
                            .toString() ==
                        '1' &&
                    upcomingInspectionsController
                            .taskEquipmentListData.last['Equipment_Name']
                            .toString() ==
                        'Other' &&
                    tcontoller.otherEqupmentNotecntrlr.text.isEmpty) {
                  ScaffoldMessenger.of(Get.context!).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Enter Additional Equipment Name Recieved!')));
                } else {
                  if (upcomingInspectionsController.taskUserDetails[0]
                              ['Role_Id']
                          .toString() ==
                      '38') {
                    print(' visual check     ${tcontoller.visualCheck.value}');
                    print(
                        ' periodicCheck    ${tcontoller.periodicCheck.value}');

                    print(
                        'thoroughCheck     ${tcontoller.thoroughCheck.value}');

                    print(' majorCheck    ${tcontoller.majorCheck.value}');

                    if (tcontoller.visualCheck.value == true ||
                        tcontoller.periodicCheck.value == true ||
                        tcontoller.thoroughCheck.value == true ||
                        tcontoller.inServiceCheck.value == true ||
                        tcontoller.examinationCheck.value == true ||
                        tcontoller.independentCheck.value == true ||
                        tcontoller.majorCheck.value == true) {
                      final userEnter = await tcontoller.geofenceLocation(
                        fenceLatitude: upcomingInspectionsController
                                .taskDetailsData.isEmpty
                            ? 10.005548201562277
                            : double.parse(upcomingInspectionsController
                                .taskDetailsData[0]['Latitude']
                                .toString()),
                        fenceLongitude: upcomingInspectionsController
                                .taskDetailsData.isEmpty
                            ? 76.37540812327876
                            : double.parse(upcomingInspectionsController
                                .taskDetailsData[0]['Longitude']
                                .toString()),
                      );

                      if (userEnter == 'inside') {
                        if (tcontoller.isTaskStarted.value == true) {
                          await upcomingInspectionsController.getTestEquipment(
                            taskUserDetailsId: upcomingInspectionsController
                                .taskUserDetails[0]['Task_User_Details_Id'],
                            taskId: upcomingInspectionsController
                                .taskDetailsData[0]['Task_Id'],
                          );
                          // await upcomingInspectionsController.getUserTaskDetails(taskId: upcomingInspectionsController
                          //       .taskDetailsData[0]['Task_Id']); // need to change
                          await upcomingInspectionsController.getTestppe(
                            taskUserDetailsId: upcomingInspectionsController
                                .taskUserDetails[0]['Task_User_Details_Id'],
                            taskId: upcomingInspectionsController
                                .taskDetailsData[0]['Task_Id'],
                          );
                          await upcomingInspectionsController.getTestDocument(
                            taskUserDetailsId: upcomingInspectionsController
                                .taskUserDetails[0]['Task_User_Details_Id'],
                            taskId: upcomingInspectionsController
                                .taskDetailsData[0]['Task_Id'],
                          );

                          Get.to(() => TrainingEquipmentScreen(
                                taskId: int.parse(upcomingInspectionsController
                                    .taskDetailsData[0]['Task_Id']
                                    .toString()),
                              ));
                        } else {
                          showDialog(
                            barrierDismissible: false,
                            context: Get.context!,
                            builder: (ctx) => AlertDialog(
                              // title: const Text(
                              //   'Logout',
                              //   style: TextStyle(fontWeight: FontWeight.w800),
                              // ),
                              content: const SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Are you sure you want to start? Please confirm your equipment selection in the equipment list. Once you start your task, you won't be able to change it again.")
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
                                  child: const Text('Continue'),
                                  onPressed: () async {
                                    Get.back();
                                    await upcomingInspectionsController
                                        .getTestEquipment(
                                      taskUserDetailsId:
                                          upcomingInspectionsController
                                                  .taskUserDetails[0]
                                              ['Task_User_Details_Id'],
                                      taskId: upcomingInspectionsController
                                          .taskDetailsData[0]['Task_Id'],
                                    );
                                    await upcomingInspectionsController
                                        .getTestppe(
                                      taskUserDetailsId:
                                          upcomingInspectionsController
                                                  .taskUserDetails[0]
                                              ['Task_User_Details_Id'],
                                      taskId: upcomingInspectionsController
                                          .taskDetailsData[0]['Task_Id'],
                                    );
                                    await upcomingInspectionsController
                                        .getTestDocument(
                                      taskUserDetailsId:
                                          upcomingInspectionsController
                                                  .taskUserDetails[0]
                                              ['Task_User_Details_Id'],
                                      taskId: upcomingInspectionsController
                                          .taskDetailsData[0]['Task_Id'],
                                    );
                                    await upcomingInspectionsController
                                        .saveTaskUserStart();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(Get.context!).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Your current location doesn't match the task location. You won't be able to start the task!")));
                      }

                      // if (tcontoller.isTaskStarted.value == false) {
                      //         tcontoller.geofenceService
                      //       .addGeofenceStatusChangeListener(tcontoller.onGeofenceStatusChanged);
                      //   tcontoller.geofenceService
                      //       .addLocationChangeListener(tcontoller.onLocationChanged);
                      //   tcontoller.geofenceService.addLocationServicesStatusChangeListener(
                      //       tcontoller.onLocationServicesStatusChanged);
                      //   tcontoller.geofenceService
                      //       .addActivityChangeListener(tcontoller.onActivityChanged);
                      //   tcontoller.geofenceService.addStreamErrorListener(tcontoller.onError);
                      //   tcontoller.geofenceService
                      //       .start(tcontoller.geofenceList)
                      //       .catchError(tcontoller.onError);
                      //   // await upcomingInspectionsController.saveTaskUserStart();
                      // } else {
                      //   Get.to(() => const TrainingEquipmentScreen());
                      // }

                      // await upcomingInspectionsController.saveTaskUserStart();
                    } else {
                      if (homeController.isStartBtnClicked.value == false) {
                        ScaffoldMessenger.of(Get.context!).showSnackBar(
                            const SnackBar(content: Text('Select Task Type')));
                      }
                      homeController.isStartBtnClicked.value = true;
                    }
                  } else {
                    final userEnter = await tcontoller.geofenceLocation(
                      fenceLatitude:
                          upcomingInspectionsController.taskDetailsData.isEmpty
                              ? 10.005548201562277
                              : double.parse(upcomingInspectionsController
                                  .taskDetailsData[0]['Latitude']
                                  .toString()),
                      fenceLongitude:
                          upcomingInspectionsController.taskDetailsData.isEmpty
                              ? 76.37540812327876
                              : double.parse(upcomingInspectionsController
                                  .taskDetailsData[0]['Longitude']
                                  .toString()),
                    );

                    if (userEnter == 'inside') {
                      //  await upcomingInspectionsController.saveTaskUserStart();
                      // await upcomingInspectionsController.getTestEquipment(
                      //   taskUserDetailsId: upcomingInspectionsController
                      //       .taskUserDetails[0]['Task_User_Details_Id'],
                      //   taskId: upcomingInspectionsController.taskDetailsData[0]
                      //       ['Task_Id'],
                      // );
                      // await upcomingInspectionsController.getTestppe(
                      //   taskUserDetailsId: upcomingInspectionsController
                      //       .taskUserDetails[0]['Task_User_Details_Id'],
                      //   taskId: upcomingInspectionsController.taskDetailsData[0]
                      //       ['Task_Id'],
                      // );
                      // await upcomingInspectionsController.getTestDocument(
                      //   taskUserDetailsId: upcomingInspectionsController
                      //       .taskUserDetails[0]['Task_User_Details_Id'],
                      //   taskId: upcomingInspectionsController.taskDetailsData[0]
                      //       ['Task_Id'],
                      // );

                      if (tcontoller.isTaskStarted.value == true) {
                        Get.to(() => const RiskAssesmentStopScreen());
                      } else {
                        showDialog(
                          barrierDismissible: false,
                          context: Get.context!,
                          builder: (ctx) => AlertDialog(
                            // title: const Text(
                            //   'Logout',
                            //   style: TextStyle(fontWeight: FontWeight.w800),
                            // ),
                            content: const SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Are you sure you want to start? Please confirm your equipment selection in the equipment list. Once you start your task, you won't be able to change it again.")
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
                                child: const Text('Continue'),
                                onPressed: () async {
                                  Get.back();

                                  await upcomingInspectionsController
                                      .saveTaskUserStart();
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(Get.context!).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Your current location doesn't match the task location. You won't be able to start the task!")));
                    }

                    // if (tcontoller.isTaskStarted.value == false) {
                    //        tcontoller.geofenceService
                    //       .addGeofenceStatusChangeListener(tcontoller.onGeofenceStatusChanged);
                    //   tcontoller.geofenceService
                    //       .addLocationChangeListener(tcontoller.onLocationChanged);
                    //   tcontoller.geofenceService.addLocationServicesStatusChangeListener(
                    //       tcontoller.onLocationServicesStatusChanged);
                    //   tcontoller.geofenceService
                    //       .addActivityChangeListener(tcontoller.onActivityChanged);
                    //   tcontoller.geofenceService.addStreamErrorListener(tcontoller.onError);
                    //   tcontoller.geofenceService
                    //       .start(tcontoller.geofenceList)
                    //       .catchError(tcontoller.onError);
                    //   // await upcomingInspectionsController.saveTaskUserStart();
                    // } else {
                    //   Get.to(() => const RiskAssesmentStopScreen());
                    // }
                  }
                }
              } else {
                ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
                    content: Text("Select atleast one equipment!")));
              }
            },
            child: Container(
              height: 50.h,
              color: ColorResources.colorE5AA17,
              child: Center(
                  child: Obx(
                () => Text(
                  tcontoller.isTaskStarted.value == false
                      ? "Start"
                      : 'View Details',
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorResources.color0d0d0d,
                    height: 14.9767427444458 / 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
            ),
          )
        : const SizedBox();
  }
}

Container trainningGridWidget(
    {required String titleText,
    required String subTitle,
    BorderSide border = BorderSide.none,
    double cWidth = 230,
    required IconData icon}) {
  print(cWidth);
  return Container(
    margin: EdgeInsets.only(top: 20.h),
    width: Get.width > 615 && titleText == 'Equipment List' ? 500.w : cWidth.w,
    decoration: BoxDecoration(
      border: Border(
        right: border,
      ),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Icon(
            icon,
            color: ColorResources.color294C73,
            size: 21.sp,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            titleText,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ColorResources.color294C73,
            ),
          )
        ],
      ),
      if (subTitle.isNotEmpty)
        SizedBox(
          height: 15.h,
        ),
      if (subTitle.isNotEmpty)
        titleText == 'Equipment List'
            ? Container(
                // margin: EdgeInsets.only(left: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      runSpacing: 10.w,
                      spacing: Get.width > 615 ? 30.w : 10.w,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          homeController.isCalibrationSection.value
                              ? upcomingInspectionsController
                                  .taskEquipmentListDataCalibration.length
                              : upcomingInspectionsController
                                  .taskEquipmentListData.length, (index) {
                        //    'fiiurreoiu ${upcomingInspectionsController.taskEquipmentListDataCalibration.length}');
                        return GetBuilder<UpcomingInspectionsController>(
                            builder: (eqpmentListData) {
                          return SizedBox(
                              width: Get.width > 615 ? 200.w : 300.w,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: !homeController.isCalibrationSection
                                                    .value &&
                                                eqpmentListData
                                                        .taskEquipmentListData[
                                                            index]['Checked']
                                                        .toString() ==
                                                    '1' ||
                                            homeController.isCalibrationSection
                                                    .value &&
                                                eqpmentListData
                                                        .taskEquipmentListDataCalibration[
                                                            index]['Checked']
                                                        .toString() ==
                                                    '1'
                                        ? true
                                        : false,
                                    onChanged: (value) {
                                      print(value);

                                      if (homeController
                                          .isCalibrationSection.value) {
                                        if (upcomingInspectionsController
                                                    .taskEquipmentListDataCalibration[
                                                index]['Equipment_Name'] !=
                                            'Other') {
                                          upcomingInspectionsController
                                                  .taskEquipmentListDataCalibration[
                                              index]['Checked'] = value ==
                                                  true
                                              ? 1
                                              : 0;
                                        } else {
                                          upcomingInspectionsController
                                                  .taskEquipmentListDataCalibration[
                                              index]['Checked'] = value ==
                                                  true
                                              ? 1
                                              : 0;
                                          if (upcomingInspectionsController
                                                  .taskEquipmentListDataCalibration[
                                                      index]['Checked']
                                                  .toString() ==
                                              '1') {
                                            tcontoller.othersChecked.value =
                                                true;
                                          } else {
                                            tcontoller.othersChecked.value =
                                                false;
                                          }
                                        }
                                      } else {
                                        if (upcomingInspectionsController
                                                    .taskEquipmentListData[
                                                index]['Equipment_Name'] !=
                                            'Other') {
                                          upcomingInspectionsController
                                                  .taskEquipmentListData[index]
                                              ['Checked'] = value ==
                                                  true
                                              ? 1
                                              : 0;
                                        } else {
                                          upcomingInspectionsController
                                                  .taskEquipmentListData[index]
                                              ['Checked'] = value ==
                                                  true
                                              ? 1
                                              : 0;
                                          if (upcomingInspectionsController
                                                  .taskEquipmentListData[index]
                                                      ['Checked']
                                                  .toString() ==
                                              '1') {
                                            tcontoller.othersChecked.value =
                                                true;
                                          } else {
                                            tcontoller.othersChecked.value =
                                                false;
                                          }
                                        }
                                      }

                                      upcomingInspectionsController.update();
                                    },
                                  ),
                                  SizedBox(
                                      width: 8
                                          .w), // Add some space between the checkbox and the text
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        homeController
                                                .isCalibrationSection.value
                                            ? ' ${upcomingInspectionsController.taskEquipmentListDataCalibration[index]['Equipment_Name']}'
                                            : ' ${upcomingInspectionsController.taskEquipmentListData[index]['Equipment_Name']}',
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ColorResources.color0d0d0d,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        });
                      }),
                    ),
                  ],
                ),
              )
            : Container(
                margin: titleText == 'Task Date & Time' ||
                        titleText == 'Started Date & Time' ||
                        titleText == 'Ended Date & Time'
                    ? EdgeInsets.only(left: Get.width > 615 ? 35.w : 3.w)
                    : const EdgeInsets.all(0),
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                    border: titleText == 'Task Date & Time' ||
                            titleText == 'Started Date & Time' ||
                            titleText == 'Ended Date & Time'
                        ? Border.all(color: ColorResources.color294C73)
                        : const Border()),
                child: Text(
                  subTitle,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorResources.color0d0d0d,
                  ),
                ),
              ),
    ]),
  );
}
