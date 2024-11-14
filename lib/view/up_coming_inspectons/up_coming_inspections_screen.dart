import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controller/upcoming_inspections/upcoming_inspection_controller.dart';
import '../../core/constants/color_resources.dart';
import '../../core/constants/common_widgets.dart';
import '../re_schedule_inspections/re_schedule_inspections_screen.dart';

class UpcomingInspectionsScreen extends StatelessWidget {
  UpcomingInspectionsScreen({super.key});
  final upcomingController = Get.put(UpcomingInspectionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(70.w, 70.h),
          child: commonBackgroundLinearColor(
              childWidget: AppBar(
            leading: IconButton(
                onPressed: () {
                  homeController.inspectionDropdownValue.value = '';
                  homeController.equipmentListCustomer = {};
                  homeController.inspectionDateController.clear();
                  homeController.inspectionMessageController.clear();
                  homeController.isChooseEquipment.value = false;
                  homeController.update();
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            // Builder(builder: (ctx) {
            //   return customDrawerIcon(context: ctx);
            // }),
            backgroundColor: ColorResources.colorTransparent,
          ))),
      body: commonBackgroundLinearColorHome(
        childWidget: Container(
            padding: EdgeInsets.all(15.sp),
            width: Get.width,
            height: Get.height,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'Upcoming',
                        style: GoogleFonts.roboto(
                            color: ColorResources.color294C73,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: homeController.isCalibrationSection.value
                            ? ' Calibration'
                            : ' Inspections',
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
                    SizedBox(
                      height: 44.h,
                    ),
                    Column(
                      children: [
                        GetBuilder<UpcomingInspectionsController>(
                            builder: (customerData) {
                          return Wrap(
                            spacing: 20.w,
                            children:
                                customerData
                                        .upcomingInspectionListData.isNotEmpty
                                    ? List.generate(
                                        customerData
                                            .upcomingInspectionListData.length,
                                        (index) => Container(
                                          width:
                                              Get.width > 615 ? 390.w : 360.w,
                                          // height: 217.h,
                                          margin: EdgeInsets.only(top: 15.h),
                                          padding: EdgeInsets.only(
                                              left: 15.sp,
                                              right: 15.sp,
                                              top: 15.sp),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6.sp)),
                                          child: Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(
                                                  Icons.handyman,
                                                  color: ColorResources
                                                      .color294C73
                                                      .withOpacity(0.10),
                                                  size: 100.sp,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                    children: [
                                                      Expanded(
                                                        flex: 50,
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              upcomingInspectionCommonItemWidget(
                                                                icon: Icons
                                                                    .business,
                                                                valueText: customerData
                                                                            .upcomingInspectionListData[index]
                                                                        [
                                                                        'Task_Name'] ??
                                                                    '',
                                                              ),
                                                              upcomingInspectionCommonItemWidget(
                                                                icon: Icons
                                                                    .calendar_month,
                                                                valueText: DateFormat('dd-MM-yyyy').format(DateTime.parse((customerData.upcomingInspectionListData[index]
                                                                            [
                                                                            'Reschedule_Date'] ==
                                                                        null
                                                                    ? customerData.upcomingInspectionListData[index]
                                                                            [
                                                                            'Task_Date'] ??
                                                                        ''
                                                                    : customerData.upcomingInspectionListData[index]
                                                                            [
                                                                            'Reschedule_Date'] ??
                                                                        ""))),
                                                              ),
                                                              upcomingInspectionCommonItemWidget(
                                                                icon: Icons
                                                                    .timer_outlined,
                                                                valueText: customerData
                                                                            .upcomingInspectionListData[index]
                                                                        [
                                                                        'Time'] ??
                                                                    '',
                                                              ),
                                                              upcomingInspectionCommonItemWidget(
                                                                icon: Icons
                                                                    .location_on_outlined,
                                                                valueText: customerData
                                                                            .upcomingInspectionListData[index]
                                                                        [
                                                                        'Location_Name'] ??
                                                                    '',
                                                              ),
                                                              upcomingInspectionCommonItemWidget(
                                                                icon: Icons
                                                                    .person,
                                                                valueText: customerData
                                                                            .upcomingInspectionListData[index]
                                                                        [
                                                                        'User_Details_Name'] ??
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
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),

                                                              customerData.upcomingInspectionListData[
                                                                              index]
                                                                              [
                                                                              'Task_Status_Id']
                                                                          .toString() !=
                                                                      '7'
                                                                  ? IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (customerData.upcomingInspectionListData[index]['Task_Status_Id'].toString() !=
                                                                            '7') {
                                                                          Get.to(() =>
                                                                              ReScheduleInspectionsScreen(
                                                                                inspectionDate: DateFormat('dd-MM-yyyy').format(DateTime.parse((customerData.upcomingInspectionListData[index]['Reschedule_Date'] == null ? customerData.upcomingInspectionListData[index]['Task_Date'] ?? '' : customerData.upcomingInspectionListData[index]['Reschedule_Date'] ?? ""))),
                                                                                taskId: customerData.upcomingInspectionListData[index]['Task_Id'].toString(),
                                                                              ));
                                                                        }
                                                                      },
                                                                      icon:
                                                                          Container(
                                                                        height:
                                                                            30.h,
                                                                        width:
                                                                            100.w,
                                                                        decoration: BoxDecoration(
                                                                            border: Border.all(
                                                                              color: ColorResources.color294C73,
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(7.r)),
                                                                        child: Center(
                                                                            child: Text(
                                                                          "Re-Schedule",
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Roboto",
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                ColorResources.color294C73,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                        )),
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          30.h,
                                                                      width:
                                                                          100.w,
                                                                      decoration: BoxDecoration(
                                                                          color: ColorResources.colorBlack.withOpacity(0.2),
                                                                          border: Border.all(
                                                                            color:
                                                                                ColorResources.colorBlack.withOpacity(0.10),
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(7.r)),
                                                                      child: Center(
                                                                          child: Text(
                                                                        "Re-Schedule",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              "Roboto",
                                                                          fontSize:
                                                                              14.sp,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              ColorResources.color294C73,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                      )),
                                                                    ),

                                                              SizedBox(
                                                                height: 8.h,
                                                              ),
                                                              customerData.upcomingInspectionListData[
                                                                              index]
                                                                              [
                                                                              'Task_Status_Id']
                                                                          .toString() ==
                                                                      '7'
                                                                  ? Text(
                                                                      'Re-Schedule Requested',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              13.sp),
                                                                    )
                                                                  : Container(),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : [
                                        SizedBox(
                                          height: 500.h,
                                          child: Center(
                                            child: Text(
                                              homeController
                                                      .isCalibrationSection
                                                      .value
                                                  ? 'Currently, no calibration requests have been converted to calibration task!'
                                                  : 'Currently, no inspection requests have been converted to inspection task!',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      ],
                          );
                        }),
                      ],
                    )
                  ]),
            )),
      ),
    );
  }
}

upcomingInspectionCommonItemWidget(
    {required IconData icon, required String valueText}) {
  return Container(
    margin: EdgeInsets.only(top: 5.h),
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: ColorResources.color294C73,
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: SizedBox(
                width: 205.w,
                child: Text(
                  valueText,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "DM Sans",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.color294C73),
                ),
              ),
            ),
          ],
        ),
        // Text(
        //  valueText,
        //   style: TextStyle(
        //     fontFamily: "DM Sans",
        //     fontSize: 12.sp,
        //     fontWeight: FontWeight.w500,
        //     color: const Color(0xff51688a),
        //   ),
        //   textAlign: TextAlign.left,
        // )
      ],
    ),
  );
}
