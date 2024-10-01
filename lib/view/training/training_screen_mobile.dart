import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/tainning/trainnig_controller.dart';
import '../../controller/upcoming_inspections/upcoming_inspection_controller.dart';
import '../../core/constants/color_resources.dart';
import '../../core/constants/common_widgets.dart';
import 'training_screen_tab.dart';

class TrainingScreenMobile extends StatefulWidget {
  const TrainingScreenMobile({super.key});

  @override
  State<TrainingScreenMobile> createState() => _TrainingScreenMobileState();
}

class _TrainingScreenMobileState extends State<TrainingScreenMobile> {
  final UpcomingInspectionsController upcomingInspectionsController =
      Get.put(UpcomingInspectionsController());

  final TrainingController tcontroller = Get.put(TrainingController());
  @override
  void initState() {
    // homeController.getAllusers();
    //  tcontoller.othersChecked.value = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {
        upcomingInspectionsController.selectDateTaskListData.clear();
        upcomingInspectionsController.taskInitFunction(context);

        if (upcomingInspectionsController
                .startDatePickController.text.isNotEmpty &&
            upcomingInspectionsController
                .endDatePickController.text.isNotEmpty) {
          upcomingInspectionsController.selectDateTaskListData =
              await upcomingInspectionsController.getuserTaskDateRange(
            isInitSate: false,
            startDate: DateFormat('dd-MM-yyyy').parse(
                upcomingInspectionsController.startDatePickController.text),
            endDate: DateFormat('dd-MM-yyyy').parse(
                upcomingInspectionsController.endDatePickController.text),
          );
          upcomingInspectionsController.update();
          upcomingInspectionsController.update(['date_picker']);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(70.w, 70.h),
          child: commonBackgroundLinearColor(
            childWidget: AppBar(
              backgroundColor: ColorResources.colorTransparent,
              leading: IconButton(
                  onPressed: () async {
                    upcomingInspectionsController.selectDateTaskListData
                        .clear();
                    upcomingInspectionsController.taskInitFunction(context);

                    if (upcomingInspectionsController
                            .startDatePickController.text.isNotEmpty &&
                        upcomingInspectionsController
                            .endDatePickController.text.isNotEmpty) {
                      upcomingInspectionsController.selectDateTaskListData =
                          await upcomingInspectionsController
                              .getuserTaskDateRange(
                        isInitSate: false,
                        startDate: DateFormat('dd-MM-yyyy').parse(
                            upcomingInspectionsController
                                .startDatePickController.text),
                        endDate: DateFormat('dd-MM-yyyy').parse(
                            upcomingInspectionsController
                                .endDatePickController.text),
                      );
                      upcomingInspectionsController.update();
                      upcomingInspectionsController.update(['date_picker']);
                    }

                    Get.back();
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
        bottomNavigationBar: commonBottomButton(),
        body: commonBackgroundLinearColorHome(
          childWidget: Container(
            height: Get.height,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SingleChildScrollView(
              child: GetBuilder<UpcomingInspectionsController>(builder: (data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 18.h),
                      width: 367.w,
                      // height: 435.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (upcomingInspectionsController.taskUserDetails[0]
                                          ['Role_Id']
                                      .toString() ==
                                  '38' &&
                              upcomingInspectionsController.taskUserDetails[0]
                                          ['Task_Status_Id']
                                      .toString() ==
                                  '1')
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                         

                          SizedBox(
                            width: 290.w,
                            child: Text(
                              data.taskDetailsData[0]['Customer_Name'] ?? '',
                              style: TextStyle(
                                fontFamily: "DM Sans",
                                fontSize: 14.sp,
                              ),
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
                            data.taskDetailsData[0]['Work_Code'] ?? '',
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

                          SizedBox(
                            height: 10.h,
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 3.w),
                            child: Text(
                              data.taskDetailsData[0]['Task_Name'] ?? '',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: ColorResources.color0d0d0d,
                              ),
                            ),
                          ),
                          // if (data.taskUserDetails[0]['Start_Notes'] != null ||
                          //     data.taskUserDetails[0]['Start_Notes'] != '')
                          //   SizedBox(
                          //     height: 15.h,
                          //   ),
                          // Text(
                          //   data.taskUserDetails[0]['Start_Notes'] ?? '',
                          //   style: TextStyle(
                          //     fontFamily: "Roboto",
                          //     fontSize: 13.sp,
                          //     fontWeight: FontWeight.w400,
                          //     color: const Color.fromARGB(255, 107, 36, 36),
                          //   ),
                          // ),
                          //   if(upcomingInspectionsController.taskUserDetails[0]['Role_Id'].toString()=='38')     SizedBox(
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
                          //
                          //
                          if (data.taskUserDetails[0]['Start_Notes'] != null ||
                              data.taskUserDetails[0]['Start_Notes'] != '')
                            SizedBox(
                              height: 15.h,
                            ),
                          // SizedBox(
                          //   height: 25.h,
                          // ),
                          Column(
                            children: List.generate(
                              tcontoller.commonGridTexts.length,
                              (index) => trainningGridWidget(
                                  cWidth: Get.width,
                                  titleText: tcontoller.commonGridTexts[index]
                                      ['title'],
                                  subTitle: tcontoller.commonGridTexts[index]
                                      ['sub_title'],
                                  icon: tcontoller.commonGridTexts[index]
                                      ['icon'],
                                  border: BorderSide.none),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          // Row(
                          //   children: [
                          //     Icon(
                          //       Icons.message,
                          //       color: ColorResources.color294C73,
                          //       size: 21.sp,
                          //     ),
                          //     SizedBox(
                          //       width: 10.w,
                          //     ),
                          //     Text(
                          //       ' Notes',
                          //       style: TextStyle(
                          //         fontFamily: "DM Sans",
                          //         fontSize: 16.sp,
                          //         fontWeight: FontWeight.w700,
                          //         color: ColorResources.color294C73,
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          // Text(
                          //  ,
                          //   style: TextStyle(
                          //     fontFamily: "Roboto",
                          //     fontSize: 13.sp,
                          //     fontWeight: FontWeight.w400,
                          //     color: ColorResources.color0d0d0d,
                          //   ),
                          //   textAlign: TextAlign.justify,
                          // ),
                          // SizedBox(
                          //   height: 25.h,
                          // ),

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
                              data: upcomingInspectionsController
                                      .taskDetailsData[0]['Task_Note'] ??
                                  ''),

                          if (upcomingInspectionsController.taskUserDetails[0]
                                      ['Role_Id']
                                  .toString() ==
                              '38')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                              value:
                                                  tcontoller.visualCheck.value,
                                              onChanged: (value) {
                                                print(value);
                                                tcontoller.visualCheck.value =
                                                    value!;
                                                // tcontoller.update();
                                              })),
                                          Text('Visual',style
                                        :TextStyle(fontSize: 12.sp))
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
                                      width: 112.w,
                                      child: Row(
                                        children: [
                                          Obx(() => Checkbox(
                                              value: tcontoller
                                                  .periodicCheck.value,
                                              onChanged: (value) {
                                                tcontoller.periodicCheck.value =
                                                    value!;
                                                print(
                                                    'periodic value ${tcontoller.periodicCheck.value}');
                                                //  tcontroller.update();
                                              })),
                                          Text('Periodic',style
                                        :TextStyle(fontSize: 12.sp))
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      width: 105.w,
                                      child: Row(
                                        children: [
                                          Obx(() => Checkbox(
                                              value:
                                                  tcontoller.majorCheck.value,
                                              onChanged: (value) {
                                                tcontoller.majorCheck.value =
                                                    value!;
                                                //  tcontroller.update();
                                              })),
                                          Text('Major',style
                                        :TextStyle(fontSize: 12.sp))
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      width: 120.w,
                                      child: Row(
                                        children: [
                                          Obx(() => Checkbox(
                                              value: tcontoller
                                                  .inServiceCheck.value,
                                              onChanged: (value) {
                                                tcontoller.inServiceCheck
                                                    .value = value!;
                                                homeController.isStartBtnClicked
                                                    .value = false;

                                                //  tcontoller.update();
                                              })),
                                          Text('In-Service',style
                                        :TextStyle(fontSize: 12.sp))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                    width: 130.w,
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
                                        Text('Independent',style
                                        :TextStyle(fontSize: 12.sp))
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
                                      width: 130.w,
                                      child: Row(
                                        children: [
                                          Obx(() => Checkbox(
                                              value: tcontoller
                                                  .thoroughCheck.value,
                                              onChanged: (value) {
                                                tcontoller.thoroughCheck.value =
                                                    value!;
                                                //  tcontoller.update();
                                              })),
                                          Text('Thorough',style
                                        :TextStyle(fontSize: 12.sp))
                                        ],
                                      ),
                                    ),
                                     
                                    SizedBox(
                                      width: 180.w,
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
                                          Text('Initial Examination',style
                                        :TextStyle(fontSize: 12.sp))
                                        ],
                                      ),
                                    ),

                                    // SizedBox(
                                    //   width: 105,
                                    //   child: selectTaskTypeCheckBox(
                                    //       checkBoxName: 'Thorough',
                                    //       checkValue: tcontroller.thoroughCheck),
                                    // ),

                                    // SizedBox(
                                    //   width: 105.w,
                                    //   child: selectTaskTypeCheckBox(
                                    //       checkBoxName: 'Major',
                                    //       checkValue: tcontroller.majorCheck),
                                    // )
                                  ],
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox selectTaskTypeCheckBox(
      {required checkBoxName, required RxBool checkValue}) {
    return SizedBox(
      width: 105.w,
      child: Row(
        children: [
          Obx(() => Checkbox(
              value: checkValue.value,
              onChanged: (value) {
                print(value);
                checkValue.value = value!;
              })),
          Text(checkBoxName)
        ],
      ),
    );
  }
}

SizedBox commonNoteWidget(
    {bool isbtton = true, data = '', bool isReadOnly = false}) {
  tcontoller.addNoteController.text = data;

  return SizedBox(
    child: Column(children: [
      TextFormField(
        readOnly: isReadOnly,
        controller: tcontoller.addNoteController,
        maxLines: 6,
        maxLength: isReadOnly ? null : 250,
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          focusColor: Colors.grey,
          hintText: isReadOnly ? '' : 'Enter Comments',
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(3.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
      ),
      SizedBox(
        height: 15.h,
      ),
      // if(isbtton)    Align(
      //       alignment: Alignment.bottomRight,
      //       child: IconButton(
      //         onPressed: () {
      //           //need to add  (add note function)
      //         },
      //         icon: Container(
      //           width: 103.w,
      //           height: 40.h,
      //           decoration: BoxDecoration(
      //               border: Border.all(color: Colors.grey),
      //               borderRadius: BorderRadius.circular(5.r),
      //               color: Colors.black.withOpacity(0.08)),
      //           child: Center(
      //             child: Text(
      //               "Add Note",
      //               style: TextStyle(
      //                 fontFamily: "Roboto",
      //                 fontSize: 14.sp,
      //                 fontWeight: FontWeight.w400,
      //                 color: Colors.black,
      //               ),
      //               textAlign: TextAlign.center,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
    ]),
  );
}
