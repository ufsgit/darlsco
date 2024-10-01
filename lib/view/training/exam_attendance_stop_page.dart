// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/controller/tody_task_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/model/training/get_today_task_model.dart';
import 'package:darlsco/model/training/stop_exam_model.dart';
import 'package:darlsco/view/training/task_page.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExamAttendanceStopPage extends StatefulWidget {
  final GetTodayTaskModel model;

  final int index;
  const ExamAttendanceStopPage({super.key, required this.model,required this.index});

  @override
  State<ExamAttendanceStopPage> createState() => _ExamAttendanceStopPageState();
}

class _ExamAttendanceStopPageState extends State<ExamAttendanceStopPage> {
  final trainingHomeController = Get.put(TrainingControllerHomee());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    todayTaskController.getTodayTaskList();
    });

    super.initState();
  }
  String convertTo12HourFormat(String time24) {
    if (time24.isEmpty) {
      return "";
    }
    DateTime dateTime = DateFormat("HH:mm:ss").parse(time24);

    String formattedTime = DateFormat("hh:mm a").format(dateTime);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder(
          init: trainingHomeController,
          builder: (controller) {
            return commonBackgroundLinearColorCart(
                childWidget: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.h, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            await todayTaskController.getTodayTaskList();
                            Get.back();
                          },
                          child: CircleAvatar(
                            radius: 18.h,
                            backgroundColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 30.h,
                                color: ColorResources.color294C73,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Todays",
                                style: TextStyle(
                                    fontSize: 35.sp.h,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF294C73)),
                              ),
                            ),
                            Text(
                              'Task',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35.sp.h,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 0.1
                                  ..color = Color(0xFF294C73),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.business,
                                          color: Color(0xFF294C73),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
widget.model.customerName,
                                          style: TextStyle(
                                            fontSize: 16.sp.h,
                                            color: Color(0xFF294C73),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.model.trainingCourseName,
                                      style: TextStyle(
                                        fontSize: 13.sp.h,
                                        color: Color(0xFF294C73),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Table(
                                    border: TableBorder.symmetric(
                                        outside: BorderSide(
                                            width: 0, color: Colors.white)),
                                    children: [
                                      TableRow(children: [
                                        Row(
                                          children: [
                                            Icon(Icons.category_outlined,
                                                color: Color(
                                                  0xFF294C73,
                                                ),
                                                size: 16),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('Category',
                                                style: TextStyle(
                                                    fontSize: 15.sp.h,
                                                    color: Color(
                                                      0xFF294C73,
                                                    ),
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                        Text(
                                          widget.model.categoryName,
                                          style: GoogleFonts.dmSans(
                                            color: ColorResources.colorBlack,
                                            fontSize: 15.sp.h,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Row(
                                          children: [
                                            Text(
                                              '',
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '',
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Row(
                                          children: [
                                            Icon(Icons.group_outlined,
                                                color: Color(
                                                  0xFF294C73,
                                                ),
                                                size: 16),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('Trainees',
                                                style: TextStyle(
                                                    color: Color(
                                                      0xFF294C73,
                                                    ),
                                                    fontSize: 15.sp.h,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                        Text(
                                          todayTaskController
                                              .traineeAttendanceList.length
                                              .toString()
                                              .toString(),
                                          style: GoogleFonts.dmSans(
                                            color: ColorResources.colorBlack,
                                            fontSize: 15.sp.h,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Row(
                                          children: [
                                            Text(
                                              '',
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '',
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Row(
                                          children: [
                                            Icon(Icons.location_on_outlined,
                                                color: Color(
                                                  0xFF294C73,
                                                ),
                                                size: 16),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('Location',
                                                style: TextStyle(
                                                    color: Color(
                                                      0xFF294C73,
                                                    ),
                                                    fontSize: 15.sp.h,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                        Text(
                                         widget.model.locationName,
                                          style: GoogleFonts.dmSans(
                                            color: ColorResources.colorBlack,
                                            fontSize: 16.sp.h,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Row(
                                          children: [
                                            Text(
                                              '',
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '',
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Row(
                                          children: [
                                            Icon(Icons.hourglass_top_outlined,
                                                color: Color(
                                                  0xFF294C73,
                                                ),
                                                size: 16),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                              width:150.w ,
                                              child: Text('Exam Scheduled Start Time',
                                                  style: TextStyle(
                                                      color: Color(
                                                        0xFF294C73,
                                                      ),
                                                      fontSize: 15.sp.h,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          widget.model.startTime,//actual start time expected start time from api
                                          style: GoogleFonts.dmSans(
                                            color: ColorResources.colorBlack,
                                            fontSize: 15.sp.h,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Row(
                                          children: [
                                            Text(
                                              '',
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '',
                                        ),
                                      ]),
                                      // TableRow(children: [
                                      //   Row(
                                      //     children: [
                                      //       Icon(
                                      //           Icons.hourglass_bottom_outlined,
                                      //           color: Color(
                                      //             0xFF294C73,
                                      //           ),
                                      //           size: 16),
                                      //       SizedBox(
                                      //         width: 5,
                                      //       ),
                                      //       Text('Expected End Time',
                                      //           style: TextStyle(
                                      //               color: Color(
                                      //                 0xFF294C73,
                                      //               ),
                                      //               fontSize: 15.sp.h,
                                      //               fontWeight:
                                      //                   FontWeight.w600)),
                                      //     ],
                                      //   ),
                                      //   Text(
                                      //     widget.model.actualendTime,
                                      //     style: GoogleFonts.dmSans(
                                      //       color: ColorResources.colorBlack,
                                      //       fontSize: 15.sp.h,
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ]),
                                      TableRow(children: [
                                        Row(
                                          children: [
                                            Text(
                                              '',
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '',
                                        ),
                                      ]),
                                      TableRow(children: [
                                        GetBuilder<TodayTaskController>(
                                          builder: (todayTaskData) {
                                            return Row(
                                              children: [
                                                Icon(Icons.hourglass_top_outlined,
                                                    color: Color(
                                                      0xFF294C73,
                                                    ),
                                                    size: 16),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('Actual Start Time',
                                                    style: TextStyle(
                                                        color: Color(
                                                          0xFF294C73,
                                                        ),
                                                        fontSize: 15.sp.h,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                            
                                                           
                                              ],
                                            );
                                          }
                                        ),

                                         GetBuilder<TodayTaskController>(
                                           builder: (todayTaskData) {
                                             return Text(
                                               todayTaskData.todayTasksLst[widget.index].actualSatrtTime,
                                              style: GoogleFonts.dmSans(
                                                color: ColorResources.colorBlack,
                                                fontSize: 15.sp.h,
                                                fontWeight: FontWeight.bold,
                                              ),
                                                                                     );
                                           }
                                         ),
                                        
                                      ]),
                                      TableRow(children: [
                                        Row(
                                          children: [
                                            Text(
                                              '',
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '',
                                        ),
                                      ]),
                                      // TableRow(children: [
                                      //   Row(
                                      //     children: [
                                      //       Icon(
                                      //           Icons.hourglass_bottom_outlined,
                                      //           color: Color(
                                      //             0xFF294C73,
                                      //           ),
                                      //           size: 16),
                                      //       SizedBox(
                                      //         width: 5,
                                      //       ),
                                      //       Text('Actual End Time',
                                      //           style: TextStyle(
                                      //               color: Color(
                                      //                 0xFF294C73,
                                      //               ),
                                      //               fontSize: 15.sp.h,
                                      //               fontWeight:
                                      //                   FontWeight.w600)),
                                      //     ],
                                      //   ),
                                      //   Text(
                                      //     '',
                                      //     style: GoogleFonts.dmSans(
                                      //       color: ColorResources.colorBlack,
                                      //       fontSize: 16.sp.h,
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ]),
                                      // TableRow(children: [
                                      //   Row(
                                      //     children: [
                                      //       Text(
                                      //         '',
                                      //       ),
                                      //     ],
                                      //   ),
                                      //   Text(
                                      //     '',
                                      //   ),
                                      // ]),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
          },
        ),
        bottomNavigationBar: elevatedButtonWidget(
          context: context,
          text: 'Stop',
          width: Get.width,
          backgroundColor: ColorResources.colorE5AA17,
          txtColor: ColorResources.colorBlack,
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // backgroundColor: ColorResources.whiteColor,
                  // shape: ContinuousRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15.r)),
                  // elevation: 10,
                  // shadowColor: ColorResources.color294C73,
                  content: Text(
                    'Are you sure!\nDo you want to stop this task?',
                    style: GoogleFonts.dmSans(
                      // color: ColorResources.colorBlack,
                      fontSize: 16.sp.h,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  actions: [
                    textButtonWidget(
                      text: 'Yes',
                      onPressed: () async {

                           


                        await trainingHomeController.stopExam(
                            StopExamModel(
                                examMasterId:
                                    widget.model.examMasterId.toString()),
                            context);
                        await trainingHomeController.getTraineeDetails(
                            widget.model.orderDetailsId.toString(),
                            widget.model.orderLocationId.toString(),
                            widget.model.examMasterId.toString());
                      },
                    ),
                    textButtonWidget(
                      text: 'No',
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
