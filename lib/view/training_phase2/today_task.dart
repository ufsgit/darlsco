import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/controller/tody_task_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/attendance_page.dart';
import 'package:darlsco/view/training/eligible_exam_page.dart';
import 'package:darlsco/view/training/exam_attendance_stop_page.dart';
import 'package:darlsco/view/training/trainee_view_page.dart';
import 'package:darlsco/view/training_phase2/todaytask_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controller/upcoming_inspections/upcoming_inspection_controller.dart';
import '../../model/training/get_today_task_model.dart';
import 'trainer_exam_reschedule_screen.dart';

class TodayTask extends StatefulWidget {
  const TodayTask({super.key, required this.todyasTask});

  @override
  State<TodayTask> createState() => _TodayTaskState();

  final List<GetTodayTaskModel> todyasTask;
}

class _TodayTaskState extends State<TodayTask> {
  final upcomingInspectionsController =
      Get.put(UpcomingInspectionsController());
  final TrainingControllerHomee trainingController =
      Get.put(TrainingControllerHomee());
  final TodayTaskController todayTaskAttendanceController =
      Get.put(TodayTaskController());
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     dropdownValues = List.generate(
  //         trainingController.traineeDetails.length, (index) => itemsList.first);
  // trainingController.getTodayTask();
  //   });
  // }
  bool isLoading = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      await todayTaskAttendanceController.getTodayTaskList();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String convertTo12HourFormat(String time24) {
    // Parse the 24-hour format time
    DateTime dateTime = DateFormat("HH:mm").parse(time24);

    // Format the DateTime object to 12-hour format
    String formattedTime = DateFormat("hh:mm a").format(dateTime);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: commonBackgroundLinearColorCart(
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
                      // InkWell(
                      //   onTap: () {
                      //     Get.back();
                      //   },
                      //   child: CircleAvatar(
                      //     radius: 18.h,
                      //     backgroundColor: ColorResources.whiteColor,
                      //     child:
                      //         const Icon(Icons.dashboard_customize_outlined),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
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
                                  color: const Color(0xFF294C73)),
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
                                ..color = const Color(0xFF294C73),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      GetBuilder(
                          init: todayTaskAttendanceController,
                          builder: (todaysdata) {
                            print('rebuild ff${todaysdata.todayTasksLst}');
                            return Column(
                              children: isLoading
                                  ? [
                                      SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                3,
                                        width: MediaQuery.sizeOf(context).width,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    ]
                                  : todaysdata.todayTasksLst.isEmpty
                                      ? [
                                          const Center(
                                            child: Text('No task in here'),
                                          )
                                        ]
                                      : List.generate(
                                          todaysdata.todayTasksLst.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                // boxShadow: const [
                                                //   BoxShadow(
                                                //       blurRadius: 10,
                                                //       color: Color.fromARGB(255, 24, 24, 24))
                                                // ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child:
                                                  todaysdata
                                                              .todayTasksLst[
                                                                  index]
                                                              .type ==
                                                          'Training'
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .business,
                                                                          color:
                                                                              Color(0xFF294C73),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              250.w,
                                                                          child:
                                                                              Text(
                                                                            todaysdata.todayTasksLst[index].customerName,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 18.sp.h,
                                                                              color: const Color(0xFF294C73),
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          8.h,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                300.w,
                                                                            child:
                                                                                Text(
                                                                              '${todaysdata.todayTasksLst[index].trainingCourseName} - ${todaysdata.todayTasksLst[index].type}',
                                                                              style: TextStyle(
                                                                                fontSize: 16.sp.h,
                                                                                color: const Color(0xFF294C73),
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          16.h,
                                                                    ),
                                                                    Table(
                                                                      border: const TableBorder
                                                                          .symmetric(
                                                                          outside: BorderSide(
                                                                              width: 0,
                                                                              color: Colors.white)),
                                                                      children: [
                                                                        TableRow(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const Icon(Icons.category_outlined,
                                                                                      color: Color(
                                                                                        0xFF294C73,
                                                                                      ),
                                                                                      size: 16),
                                                                                  const SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Text('Category',
                                                                                      style: TextStyle(
                                                                                          color: const Color(
                                                                                            0xFF294C73,
                                                                                          ),
                                                                                          fontSize: 15.sp.h,
                                                                                          fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Text(
                                                                                todaysdata.todayTasksLst[index].categoryName,
                                                                                style: GoogleFonts.dmSans(
                                                                                  color: ColorResources.colorBlack,
                                                                                  fontSize: 15.sp.h,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                        const TableRow(
                                                                            children: [
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
                                                                        TableRow(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const Icon(Icons.location_on_outlined,
                                                                                      color: Color(
                                                                                        0xFF294C73,
                                                                                      ),
                                                                                      size: 16),
                                                                                  const SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Text('Location',
                                                                                      style: TextStyle(
                                                                                          color: const Color(
                                                                                            0xFF294C73,
                                                                                          ),
                                                                                          fontSize: 15.sp.h,
                                                                                          fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Text(
                                                                                todaysdata.todayTasksLst[index].locationName,
                                                                                style: GoogleFonts.dmSans(
                                                                                  color: ColorResources.colorBlack,
                                                                                  fontSize: 15.sp.h,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                        const TableRow(
                                                                            children: [
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
                                                                        TableRow(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const Icon(Icons.hourglass_top_outlined,
                                                                                      color: Color(
                                                                                        0xFF294C73,
                                                                                      ),
                                                                                      size: 16),
                                                                                  const SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Text('Start Training Time',
                                                                                      style: TextStyle(
                                                                                          color: const Color(
                                                                                            0xFF294C73,
                                                                                          ),
                                                                                          fontSize: 15.sp.h,
                                                                                          fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Text(
                                                                                todaysdata.todayTasksLst[index].startTime.toUpperCase(),
                                                                                style: GoogleFonts.dmSans(
                                                                                  color: ColorResources.colorBlack,
                                                                                  fontSize: 15.sp.h,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                        const TableRow(
                                                                            children: [
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
                                                                        TableRow(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const Icon(Icons.hourglass_bottom_outlined,
                                                                                      color: Color(
                                                                                        0xFF294C73,
                                                                                      ),
                                                                                      size: 16),
                                                                                  const SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Text('End Training Time',
                                                                                      style: TextStyle(
                                                                                          color: const Color(
                                                                                            0xFF294C73,
                                                                                          ),
                                                                                          fontSize: 15.sp.h,
                                                                                          fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Text(
                                                                                todaysdata.todayTasksLst[index].endTime.toUpperCase(),
                                                                                style: GoogleFonts.dmSans(
                                                                                  color: ColorResources.colorBlack,
                                                                                  fontSize: 15.sp.h,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                        const TableRow(
                                                                            children: [
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
                                                                        TableRow(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const Icon(Icons.watch_later_outlined,
                                                                                      color: Color(
                                                                                        0xFF294C73,
                                                                                      ),
                                                                                      size: 16),
                                                                                  const SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Text('Total duration',
                                                                                      style: TextStyle(
                                                                                          color: const Color(
                                                                                            0xFF294C73,
                                                                                          ),
                                                                                          fontSize: 15.sp.h,
                                                                                          fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Text(
                                                                                '${todaysdata.todayTasksLst[index].duration} Hrs',
                                                                                style: GoogleFonts.dmSans(
                                                                                  color: ColorResources.colorBlack,
                                                                                  fontSize: 15.sp.h,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                        const TableRow(
                                                                            children: [
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
                                                                        TableRow(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  const Icon(Icons.watch_later_outlined,
                                                                                      color: Color(
                                                                                        0xFF294C73,
                                                                                      ),
                                                                                      size: 16),
                                                                                  const SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Text('Current Status',
                                                                                      style: TextStyle(
                                                                                          color: const Color(
                                                                                            0xFF294C73,
                                                                                          ),
                                                                                          fontSize: 15.sp.h,
                                                                                          fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Text(
                                                                                todaysdata.todayTasksLst[index].statusName,
                                                                                style: GoogleFonts.dmSans(
                                                                                  color: ColorResources.colorBlack,
                                                                                  fontSize: 15.sp.h,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                        const TableRow(
                                                                            children: [
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
                                                                        //       const Icon(
                                                                        //           Icons
                                                                        //               .calendar_month_outlined,
                                                                        //           color:
                                                                        //               Color(
                                                                        //             0xFF294C73,
                                                                        //           ),
                                                                        //           size: 16),
                                                                        //       const SizedBox(
                                                                        //         width: 5,
                                                                        //       ),
                                                                        //       Text(
                                                                        //           'Remaining days',
                                                                        //           style: TextStyle(
                                                                        //               color: const Color(
                                                                        //                 0xFF294C73,
                                                                        //               ),
                                                                        //               fontSize: 15.sp.h,
                                                                        //               fontWeight: FontWeight.w600)),
                                                                        //     ],
                                                                        //   ),
                                                                        //   Text(
                                                                        //     "${todaysdata.todayTasksLst[index].remainingDaysCount} days",
                                                                        //     style: GoogleFonts
                                                                        //         .dmSans(
                                                                        //       color: ColorResources
                                                                        //           .colorBlack,
                                                                        //       fontSize:
                                                                        //           15.sp.h,
                                                                        //       fontWeight:
                                                                        //           FontWeight
                                                                        //               .w700,
                                                                        //     ),
                                                                        //   ),
                                                                        // ]),
                                                                        // TableRow(children: [
                                                                        //   Row(
                                                                        //     children: [
                                                                        //       const SizedBox(
                                                                        //         width: 20,
                                                                        //       ),
                                                                        //       Text('count',
                                                                        //           style: TextStyle(
                                                                        //               color: const Color(
                                                                        //                 0xFF294C73,
                                                                        //               ),
                                                                        //               fontSize: 15.sp.h,
                                                                        //               fontWeight: FontWeight.w600)),
                                                                        //     ],
                                                                        //   ),
                                                                        //   Text('',
                                                                        //       style: TextStyle(
                                                                        //           fontSize:
                                                                        //               16.sp)),
                                                                        // ]),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15.h,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child: OutlinedButton(
                                                                              style: OutlinedButton.styleFrom(
                                                                                side: const BorderSide(color: Color(0xFFE5AA17)),
                                                                                backgroundColor: Colors.amber[100],
                                                                              ),
                                                                              onPressed: () {
                                                                                Get.to(() => TraineeViewPage(
                                                                                      data: todaysdata.todayTasksLst[index],
                                                                                    ));
                                                                              },
                                                                              child: Text(
                                                                                "View",
                                                                                style: GoogleFonts.dmSans(
                                                                                  color: ColorResources.colorBlack,
                                                                                  fontSize: 15.sp.h,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                              )),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor: const Color(0xFFE5AA17),
                                                                              ),
                                                                              onPressed: () async {
                                                                                await todaysdata.getTraineeAttendanceDetails(todaysdata.todayTasksLst[index].orderDetailsId.toString(), todaysdata.todayTasksLst[index].orderLocationId.toString(), todaysdata.todayTasksLst[index].examMasterId.toString());
                                                                                //start api for updating inprogrss status

                                                                                if (todaysdata.todayTasksLst[index].statusId == '2') {
                                                                                  await todaysdata.getTraineeAttendanceDetails(todaysdata.todayTasksLst[index].orderDetailsId.toString(), todaysdata.todayTasksLst[index].orderLocationId.toString(), todaysdata.todayTasksLst[index].examMasterId.toString());
                                                                                  Get.to(() => AttendancePage(
                                                                                        data: todaysdata.todayTasksLst[index],
                                                                                        index: index,
                                                                                      ));
                                                                                } else if (todaysdata.todayTasksLst[index].statusId == '7') {
                                                                                  Get.to(() => TodayTaskView(
                                                                                        model: todaysdata.todayTasksLst[index],
                                                                                        index: index,
                                                                                      ));
                                                                                } else if (todaysdata.todayTasksLst[index].statusId == '1') {
                                                                                  var s = await tcontoller.geofenceLocation(fenceLatitude: double.parse(todaysdata.todayTasksLst[index].lat.toString()), fenceLongitude: double.parse(todaysdata.todayTasksLst[index].long.toString()));
                                                                                  if (s == "outside") {
                                                                                    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text("Your current location doesn't match the task location. You won't be able to start the task!")));

                                                                                    return;
                                                                                  } else {
                                                                                    await todaysdata.startExamOrTrainging(
                                                                                      examMasterId: todaysdata.todayTasksLst[index].examMasterId.toString(),
                                                                                      orderDetailsSubId: todaysdata.todayTasksLst[index].orderDetailsSubId.toString(),
                                                                                    );
                                                                                    Get.to(() => AttendancePage(
                                                                                          data: todaysdata.todayTasksLst[index],
                                                                                          index: index,
                                                                                        ));
                                                                                  }
                                                                                } else if (todaysdata.todayTasksLst[index].statusId == '3') {
                                                                                  print('kjbilu ${todaysdata.todayTasksLst[index].eligibilityMarked}');

                                                                                  if (todaysdata.todayTasksLst[index].eligibilityMarked == '0') {
                                                                                    // print('lknjiji ${}');
                                                                                    trainingController.getTraineeDetails(
                                                                                      todaysdata.todayTasksLst[index].orderDetailsId.toString(),
                                                                                      todaysdata.todayTasksLst[index].orderLocationId.toString(),
                                                                                      todaysdata.todayTasksLst[index].examMasterId.toString(),
                                                                                    );
                                                                                    Get.to(() => EligibleExamPage(model: todaysdata.todayTasksLst[index]));
                                                                                  }
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                todaysdata.todayTasksLst[index].statusId != '1' ? 'Started' : "Start",
                                                                                style: GoogleFonts.dmSans(
                                                                                  color: ColorResources.colorBlack,
                                                                                  fontSize: 15.sp.h,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              // Padding(
                                                              //   padding:
                                                              //       const EdgeInsets.all(8.0),
                                                              //   child: Column(
                                                              //     crossAxisAlignment:
                                                              //         CrossAxisAlignment
                                                              //             .start,
                                                              //     children: [
                                                              //       Padding(
                                                              //         padding:
                                                              //             const EdgeInsets
                                                              //                 .all(8.0),
                                                              //         child: Row(
                                                              //           children: [
                                                              //             const Icon(
                                                              //               Icons.business,
                                                              //               color: Color(
                                                              //                   0xFF294C73),
                                                              //             ),
                                                              //             const SizedBox(
                                                              //               width: 5,
                                                              //             ),
                                                              //             Text(
                                                              //               todaysdata
                                                              //                   .todayTasksLst[
                                                              //                       index]
                                                              //                   .customerName,
                                                              //               style: TextStyle(
                                                              //                 fontSize:
                                                              //                     18.sp.h,
                                                              //                 color: const Color(
                                                              //                     0xFF294C73),
                                                              //                 fontWeight:
                                                              //                     FontWeight
                                                              //                         .bold,
                                                              //               ),
                                                              //             ),
                                                              //           ],
                                                              //         ),
                                                              //       ),
                                                              //       SizedBox(
                                                              //         height: 8.h,
                                                              //       ),
                                                              //       Padding(
                                                              //         padding:
                                                              //             const EdgeInsets
                                                              //                 .all(8.0),
                                                              //         child: Text(
                                                              //           '${todaysdata.todayTasksLst[index].trainingCourseName} - ${todaysdata.todayTasksLst[index].type}',
                                                              //           style: TextStyle(
                                                              //             fontSize: 16.sp.h,
                                                              //             color: const Color(
                                                              //                 0xFF294C73),
                                                              //             fontWeight:
                                                              //                 FontWeight.w600,
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //       SizedBox(
                                                              //         height: 16.h,
                                                              //       ),
                                                              //       Table(
                                                              //         border: TableBorder.symmetric(
                                                              //             outside:
                                                              //                 const BorderSide(
                                                              //                     width: 0,
                                                              //                     color: Colors
                                                              //                         .white)),
                                                              //         children: [
                                                              //           TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 const Icon(
                                                              //                     Icons
                                                              //                         .category_outlined,
                                                              //                     color:
                                                              //                         Color(
                                                              //                       0xFF294C73,
                                                              //                     ),
                                                              //                     size: 16),
                                                              //                 const SizedBox(
                                                              //                   width: 5,
                                                              //                 ),
                                                              //                 Text('Category',
                                                              //                     style: TextStyle(
                                                              //                         color: const Color(
                                                              //                           0xFF294C73,
                                                              //                         ),
                                                              //                         fontSize: 15.sp.h,
                                                              //                         fontWeight: FontWeight.w600)),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               todaysdata
                                                              //                   .todayTasksLst[
                                                              //                       index]
                                                              //                   .categoryName,
                                                              //               style: GoogleFonts
                                                              //                   .dmSans(
                                                              //                 color: ColorResources
                                                              //                     .colorBlack,
                                                              //                 fontSize:
                                                              //                     15.sp.h,
                                                              //                 fontWeight:
                                                              //                     FontWeight
                                                              //                         .w700,
                                                              //               ),
                                                              //             ),
                                                              //           ]),
                                                              //           const TableRow(
                                                              //               children: [
                                                              //                 Row(
                                                              //                   children: [
                                                              //                     Text(
                                                              //                       '',
                                                              //                     ),
                                                              //                   ],
                                                              //                 ),
                                                              //                 Text(
                                                              //                   '',
                                                              //                 ),
                                                              //               ]),
                                                              //           TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 const Icon(
                                                              //                     Icons
                                                              //                         .location_on_outlined,
                                                              //                     color:
                                                              //                         Color(
                                                              //                       0xFF294C73,
                                                              //                     ),
                                                              //                     size: 16),
                                                              //                 const SizedBox(
                                                              //                   width: 5,
                                                              //                 ),
                                                              //                 Text('Location',
                                                              //                     style: TextStyle(
                                                              //                         color: const Color(
                                                              //                           0xFF294C73,
                                                              //                         ),
                                                              //                         fontSize: 15.sp.h,
                                                              //                         fontWeight: FontWeight.w600)),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               todaysdata
                                                              //                   .todayTasksLst[
                                                              //                       index]
                                                              //                   .locationName,
                                                              //               style: GoogleFonts
                                                              //                   .dmSans(
                                                              //                 color: ColorResources
                                                              //                     .colorBlack,
                                                              //                 fontSize:
                                                              //                     15.sp.h,
                                                              //                 fontWeight:
                                                              //                     FontWeight
                                                              //                         .w700,
                                                              //               ),
                                                              //             ),
                                                              //           ]),
                                                              //           const TableRow(
                                                              //               children: [
                                                              //                 Row(
                                                              //                   children: [
                                                              //                     Text(
                                                              //                       '',
                                                              //                     ),
                                                              //                   ],
                                                              //                 ),
                                                              //                 Text(
                                                              //                   '',
                                                              //                 ),
                                                              //               ]),
                                                              //           TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 const Icon(
                                                              //                     Icons
                                                              //                         .hourglass_top_outlined,
                                                              //                     color:
                                                              //                         Color(
                                                              //                       0xFF294C73,
                                                              //                     ),
                                                              //                     size: 16),
                                                              //                 const SizedBox(
                                                              //                   width: 5,
                                                              //                 ),
                                                              //                 Text(
                                                              //                     'Start Time',
                                                              //                     style: TextStyle(
                                                              //                         color: const Color(
                                                              //                           0xFF294C73,
                                                              //                         ),
                                                              //                         fontSize: 15.sp.h,
                                                              //                         fontWeight: FontWeight.w600)),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               todaysdata
                                                              //                   .todayTasksLst[
                                                              //                       index]
                                                              //                   .satrtTime,
                                                              //               style: GoogleFonts
                                                              //                   .dmSans(
                                                              //                 color: ColorResources
                                                              //                     .colorBlack,
                                                              //                 fontSize:
                                                              //                     15.sp.h,
                                                              //                 fontWeight:
                                                              //                     FontWeight
                                                              //                         .w700,
                                                              //               ),
                                                              //             ),
                                                              //           ]),
                                                              //         ],
                                                              //       ),
                                                              //       SizedBox(
                                                              //         height: 15.h,
                                                              //       ),
                                                              //       Row(
                                                              //         children: [
                                                              //           Padding(
                                                              //             padding:
                                                              //                 const EdgeInsets
                                                              //                     .all(8.0),
                                                              //             child:
                                                              //                 OutlinedButton(
                                                              //                     style: OutlinedButton
                                                              //                         .styleFrom(
                                                              //                       side: const BorderSide(
                                                              //                           color:
                                                              //                               Color(0xFFE5AA17)),
                                                              //                       backgroundColor:
                                                              //                           Colors
                                                              //                               .amber[100],
                                                              //                     ),
                                                              //                     onPressed:
                                                              //                         () {
                                                              //                       print(
                                                              //                           'clicked${todaysdata.todayTasksLst[index].examMasterId}');
                                                              //                       Get.to(() =>
                                                              //                           TraineeViewPage(
                                                              //                             data:
                                                              //                                 todaysdata.todayTasksLst[index],
                                                              //                           ));
                                                              //                     },
                                                              //                     child: Text(
                                                              //                       "View",
                                                              //                       style: GoogleFonts
                                                              //                           .dmSans(
                                                              //                         color: ColorResources
                                                              //                             .colorBlack,
                                                              //                         fontSize: 15
                                                              //                             .sp
                                                              //                             .h,
                                                              //                         fontWeight:
                                                              //                             FontWeight.w700,
                                                              //                       ),
                                                              //                     )),
                                                              //           ),
                                                              //           Padding(
                                                              //             padding:
                                                              //                 const EdgeInsets
                                                              //                     .all(7.0),
                                                              //             child:
                                                              //                 ElevatedButton(
                                                              //                     style: ElevatedButton
                                                              //                         .styleFrom(
                                                              //                       backgroundColor:
                                                              //                           const Color(
                                                              //                               0xFFE5AA17),
                                                              //                     ),
                                                              //                     onPressed: todaysdata.todayTasksLst[index].statusId ==
                                                              //                             '5'
                                                              //                         ? null
                                                              //                         : () async {
                                                              //                             Get.to(() =>
                                                              //                                 TrainerExamRescheduleScreen(
                                                              //                                   todaysTaskDetails: todaysdata.todayTasksLst[index],
                                                              //                                 ));

                                                              //                             // await trainingController.getTraineeDetails(
                                                              //                             //     widget
                                                              //                             //         .todyasTask[
                                                              //                             //             index]
                                                              //                             //         .orderDetailsId
                                                              //                             //         .toString(),
                                                              //                             //     widget
                                                              //                             //         .todyasTask[
                                                              //                             //             index]
                                                              //                             //         .orderLocationId
                                                              //                             //         .toString(),
                                                              //                             //     widget
                                                              //                             //         .todyasTask[index]
                                                              //                             //         .examMasterId
                                                              //                             //         .toString());
                                                              //                           },
                                                              //                     child: Text(
                                                              //                       "Reschedule",
                                                              //                       style: GoogleFonts
                                                              //                           .dmSans(
                                                              //                         color: ColorResources
                                                              //                             .colorBlack,
                                                              //                         fontSize: 15
                                                              //                             .sp
                                                              //                             .h,
                                                              //                         fontWeight:
                                                              //                             FontWeight.w700,
                                                              //                       ),
                                                              //                     )),
                                                              //           ),
                                                              //           Padding(
                                                              //             padding:
                                                              //                 const EdgeInsets
                                                              //                     .all(8.0),
                                                              //             child:
                                                              //                 ElevatedButton(
                                                              //                     style: ElevatedButton
                                                              //                         .styleFrom(
                                                              //                       backgroundColor:
                                                              //                           const Color(
                                                              //                               0xFFE5AA17),
                                                              //                     ),
                                                              //                     onPressed:
                                                              //                         () async {
                                                              //                       await todayTaskAttendanceController
                                                              //                           .getTraineeAttendanceDetails(
                                                              //                         todaysdata
                                                              //                             .todayTasksLst[index]
                                                              //                             .orderDetailsId
                                                              //                             .toString(),
                                                              //                         todaysdata
                                                              //                             .todayTasksLst[index]
                                                              //                             .orderLocationId
                                                              //                             .toString(),
                                                              //                         todaysdata
                                                              //                             .todayTasksLst[index]
                                                              //                             .examMasterId
                                                              //                             .toString(),
                                                              //                       );

                                                              //                       await Get.to(
                                                              //                           () =>
                                                              //                               AttendancePage(
                                                              //                                 data: todaysdata.todayTasksLst[index],
                                                              //                                 index: index,
                                                              //                               ));
                                                              //                     },
                                                              //                     child: Text(
                                                              //                       "Start",
                                                              //                       style: GoogleFonts
                                                              //                           .dmSans(
                                                              //                         color: ColorResources
                                                              //                             .colorBlack,
                                                              //                         fontSize: 15
                                                              //                             .sp
                                                              //                             .h,
                                                              //                         fontWeight:
                                                              //                             FontWeight.w700,
                                                              //                       ),
                                                              //                     )),
                                                              //           ),
                                                              //           SizedBox(
                                                              //             height: 8,
                                                              //           ),
                                                              //         ],
                                                              //       ),
                                                              //       todaysdata
                                                              //                   .todayTasksLst[
                                                              //                       index]
                                                              //                   .statusId ==
                                                              //               '5'
                                                              //           ? Text(
                                                              //               todaysdata
                                                              //                   .todayTasksLst[
                                                              //                       index]
                                                              //                   .statusName,
                                                              //               style: TextStyle(
                                                              //                   color: Colors
                                                              //                       .red,
                                                              //                   fontSize:
                                                              //                       12.sp),
                                                              //             )
                                                              //           : Container(),
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                              // SizedBox(
                                                              //   height: 8.h,
                                                              // ),
                                                              //       Padding(
                                                              //         padding:
                                                              //             const EdgeInsets.all(8.0),
                                                              //         child: Text(
                                                              //           '${todaysdata.todayTasksLst[index].trainingCourseName} - ${todaysdata.todayTasksLst[index].type}',
                                                              //           style: TextStyle(
                                                              //             fontSize: 16.sp.h,
                                                              //             color: const Color(
                                                              //                 0xFF294C73),
                                                              //             fontWeight:
                                                              //                 FontWeight.w600,
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //       SizedBox(
                                                              //         height: 16.h,
                                                              //       ),
                                                              //       Table(
                                                              //         border: TableBorder.symmetric(
                                                              //             outside: const BorderSide(
                                                              //                 width: 0,
                                                              //                 color: Colors.white)),
                                                              //         children: [
                                                              //           TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 const Icon(
                                                              //                     Icons
                                                              //                         .category_outlined,
                                                              //                     color: Color(
                                                              //                       0xFF294C73,
                                                              //                     ),
                                                              //                     size: 16),
                                                              //                 const SizedBox(
                                                              //                   width: 5,
                                                              //                 ),
                                                              //                 Text('Category',
                                                              //                     style: TextStyle(
                                                              //                         color:
                                                              //                             const Color(
                                                              //                           0xFF294C73,
                                                              //                         ),
                                                              //                         fontSize:
                                                              //                             15.sp.h,
                                                              //                         fontWeight:
                                                              //                             FontWeight
                                                              //                                 .w600)),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               todaysdata
                                                              //                   .todayTasksLst[
                                                              //                       index]
                                                              //                   .categoryName,
                                                              //               style:
                                                              //                   GoogleFonts.dmSans(
                                                              //                 color: ColorResources
                                                              //                     .colorBlack,
                                                              //                 fontSize: 15.sp.h,
                                                              //                 fontWeight:
                                                              //                     FontWeight.w700,
                                                              //               ),
                                                              //             ),
                                                              //           ]),
                                                              //           const TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 Text(
                                                              //                   '',
                                                              //                 ),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               '',
                                                              //             ),
                                                              //           ]),
                                                              //           TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 const Icon(
                                                              //                     Icons
                                                              //                         .location_on_outlined,
                                                              //                     color: Color(
                                                              //                       0xFF294C73,
                                                              //                     ),
                                                              //                     size: 16),
                                                              //                 const SizedBox(
                                                              //                   width: 5,
                                                              //                 ),
                                                              //                 Text('Location',
                                                              //                     style: TextStyle(
                                                              //                         color:
                                                              //                             const Color(
                                                              //                           0xFF294C73,
                                                              //                         ),
                                                              //                         fontSize:
                                                              //                             15.sp.h,
                                                              //                         fontWeight:
                                                              //                             FontWeight
                                                              //                                 .w600)),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               todaysdata
                                                              //                   .todayTasksLst[
                                                              //                       index]
                                                              //                   .locationName,
                                                              //               style:
                                                              //                   GoogleFonts.dmSans(
                                                              //                 color: ColorResources
                                                              //                     .colorBlack,
                                                              //                 fontSize: 15.sp.h,
                                                              //                 fontWeight:
                                                              //                     FontWeight.w700,
                                                              //               ),
                                                              //             ),
                                                              //           ]),
                                                              //           const TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 Text(
                                                              //                   '',
                                                              //                 ),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               '',
                                                              //             ),
                                                              //           ]),
                                                              //           TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 const Icon(
                                                              //                     Icons
                                                              //                         .hourglass_top_outlined,
                                                              //                     color: Color(
                                                              //                       0xFF294C73,
                                                              //                     ),
                                                              //                     size: 16),
                                                              //                 const SizedBox(
                                                              //                   width: 5,
                                                              //                 ),
                                                              //                 Text('Start Time',
                                                              //                     style: TextStyle(
                                                              //                         color:
                                                              //                             const Color(
                                                              //                           0xFF294C73,
                                                              //                         ),
                                                              //                         fontSize:
                                                              //                             15.sp.h,
                                                              //                         fontWeight:
                                                              //                             FontWeight
                                                              //                                 .w600)),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               convertTo12HourFormat(
                                                              //                   todaysdata
                                                              //                       .todayTasksLst[
                                                              //                           index]
                                                              //                       .satrtTime),
                                                              //               style:
                                                              //                   GoogleFonts.dmSans(
                                                              //                 color: ColorResources
                                                              //                     .colorBlack,
                                                              //                 fontSize: 15.sp.h,
                                                              //                 fontWeight:
                                                              //                     FontWeight.w700,
                                                              //               ),
                                                              //             ),
                                                              //           ]),
                                                              //           const TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 Text(
                                                              //                   '',
                                                              //                 ),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               '',
                                                              //             ),
                                                              //           ]),
                                                              //           TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 const Icon(
                                                              //                     Icons
                                                              //                         .hourglass_bottom_outlined,
                                                              //                     color: Color(
                                                              //                       0xFF294C73,
                                                              //                     ),
                                                              //                     size: 16),
                                                              //                 const SizedBox(
                                                              //                   width: 5,
                                                              //                 ),
                                                              //                 Text('End Time',
                                                              //                     style: TextStyle(
                                                              //                         color:
                                                              //                             const Color(
                                                              //                           0xFF294C73,
                                                              //                         ),
                                                              //                         fontSize:
                                                              //                             15.sp.h,
                                                              //                         fontWeight:
                                                              //                             FontWeight
                                                              //                                 .w600)),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               convertTo12HourFormat(
                                                              //                   widget
                                                              //                       .todyasTask[
                                                              //                           index]
                                                              //                       .endTime),
                                                              //               style:
                                                              //                   GoogleFonts.dmSans(
                                                              //                 color: ColorResources
                                                              //                     .colorBlack,
                                                              //                 fontSize: 15.sp.h,
                                                              //                 fontWeight:
                                                              //                     FontWeight.w700,
                                                              //               ),
                                                              //             ),
                                                              //           ]),
                                                              //           const TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 Text(
                                                              //                   '',
                                                              //                 ),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               '',
                                                              //             ),
                                                              //           ]),
                                                              //           TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 const Icon(
                                                              //                     Icons
                                                              //                         .watch_later_outlined,
                                                              //                     color: Color(
                                                              //                       0xFF294C73,
                                                              //                     ),
                                                              //                     size: 16),
                                                              //                 const SizedBox(
                                                              //                   width: 5,
                                                              //                 ),
                                                              //                 Text('Total duration',
                                                              //                     style: TextStyle(
                                                              //                         color:
                                                              //                             const Color(
                                                              //                           0xFF294C73,
                                                              //                         ),
                                                              //                         fontSize:
                                                              //                             15.sp.h,
                                                              //                         fontWeight:
                                                              //                             FontWeight
                                                              //                                 .w600)),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               '${todaysdata.todayTasksLst[index].duration} days',
                                                              //               style:
                                                              //                   GoogleFonts.dmSans(
                                                              //                 color: ColorResources
                                                              //                     .colorBlack,
                                                              //                 fontSize: 15.sp.h,
                                                              //                 fontWeight:
                                                              //                     FontWeight.w700,
                                                              //               ),
                                                              //             ),
                                                              //           ]),
                                                              //           const TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 Text(
                                                              //                   '',
                                                              //                 ),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               '',
                                                              //             ),
                                                              //           ]),
                                                              //           TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 const Icon(
                                                              //                     Icons
                                                              //                         .calendar_month_outlined,
                                                              //                     color: Color(
                                                              //                       0xFF294C73,
                                                              //                     ),
                                                              //                     size: 16),
                                                              //                 const SizedBox(
                                                              //                   width: 5,
                                                              //                 ),
                                                              //                 Text('Remaining days',
                                                              //                     style: TextStyle(
                                                              //                         color:
                                                              //                             const Color(
                                                              //                           0xFF294C73,
                                                              //                         ),
                                                              //                         fontSize:
                                                              //                             15.sp.h,
                                                              //                         fontWeight:
                                                              //                             FontWeight
                                                              //                                 .w600)),
                                                              //               ],
                                                              //             ),
                                                              //             Text(
                                                              //               "${todaysdata.todayTasksLst[index].remainingDaysCount} days",
                                                              //               style:
                                                              //                   GoogleFonts.dmSans(
                                                              //                 color: ColorResources
                                                              //                     .colorBlack,
                                                              //                 fontSize: 15.sp.h,
                                                              //                 fontWeight:
                                                              //                     FontWeight.w700,
                                                              //               ),
                                                              //             ),
                                                              //           ]),
                                                              //           TableRow(children: [
                                                              //             Row(
                                                              //               children: [
                                                              //                 const SizedBox(
                                                              //                   width: 20,
                                                              //                 ),
                                                              //                 Text('count',
                                                              //                     style: TextStyle(
                                                              //                         color:
                                                              //                             const Color(
                                                              //                           0xFF294C73,
                                                              //                         ),
                                                              //                         fontSize:
                                                              //                             15.sp.h,
                                                              //                         fontWeight:
                                                              //                             FontWeight
                                                              //                                 .w600)),
                                                              //               ],
                                                              //             ),
                                                              //             Text('',
                                                              //                 style: TextStyle(
                                                              //                     fontSize: 16.sp)),
                                                              //           ]),
                                                              //         ],
                                                              //       ),
                                                              //       SizedBox(
                                                              //         height: 15.h,
                                                              //       ),
                                                              //       Row(
                                                              //         children: [
                                                              //           Padding(
                                                              //             padding:
                                                              //                 const EdgeInsets.all(
                                                              //                     8.0),
                                                              //             child: OutlinedButton(
                                                              //                 style: OutlinedButton
                                                              //                     .styleFrom(
                                                              //                   side: const BorderSide(
                                                              //                       color: Color(
                                                              //                           0xFFE5AA17)),
                                                              //                   backgroundColor:
                                                              //                       Colors
                                                              //                           .amber[100],
                                                              //                 ),
                                                              //                 onPressed: () {
                                                              //                   Get.to(() =>
                                                              //                       TraineeViewPage(
                                                              //                         data: todaysdata
                                                              //                                 .todayTasksLst[
                                                              //                             index],
                                                              //                       ));
                                                              //                 },
                                                              //                 child: Text(
                                                              //                   "View",
                                                              //                   style: GoogleFonts
                                                              //                       .dmSans(
                                                              //                     color:
                                                              //                         ColorResources
                                                              //                             .colorBlack,
                                                              //                     fontSize: 15.sp.h,
                                                              //                     fontWeight:
                                                              //                         FontWeight
                                                              //                             .w700,
                                                              //                   ),
                                                              //                 )),
                                                              //           ),
                                                              //           Padding(
                                                              //             padding:
                                                              //                 const EdgeInsets.all(
                                                              //                     8.0),
                                                              //             child: ElevatedButton(
                                                              //                 style: ElevatedButton
                                                              //                     .styleFrom(
                                                              //                   backgroundColor:
                                                              //                       const Color(
                                                              //                           0xFFE5AA17),
                                                              //                 ),
                                                              //                 onPressed: () async {
                                                              //                   showDialog(
                                                              //                     context: context,
                                                              //                     builder:
                                                              //                         (context) {
                                                              //                       return AlertDialog(
                                                              //                         backgroundColor:
                                                              //                             ColorResources
                                                              //                                 .whiteColor,
                                                              //                         shape: ContinuousRectangleBorder(
                                                              //                             borderRadius:
                                                              //                                 BorderRadius.circular(
                                                              //                                     15.r)),
                                                              //                         elevation: 10,
                                                              //                         shadowColor:
                                                              //                             ColorResources
                                                              //                                 .color294C73,
                                                              //                         content: Text(
                                                              //                           'Are you sure!\nDo you want to start this task?',
                                                              //                           style: GoogleFonts
                                                              //                               .dmSans(
                                                              //                             color: ColorResources
                                                              //                                 .colorBlack,
                                                              //                             fontSize:
                                                              //                                 16.sp.h,
                                                              //                             fontWeight:
                                                              //                                 FontWeight
                                                              //                                     .w700,
                                                              //                           ),
                                                              //                         ),
                                                              //                         actions: [
                                                              //                           textButtonWidget(
                                                              //                             text:
                                                              //                                 'Yes',
                                                              //                             onPressed:
                                                              //                                 () async {
                                                              //                               Get.back();
                                                              //                               await todaysdata.getTraineeAttendanceDetails(
                                                              //                                   todaysdata.todayTasksLst[index].orderDetailsId.toString(),
                                                              //                                   todaysdata.todayTasksLst[index].orderLocationId.toString(),
                                                              //                                   todaysdata.todayTasksLst[index].examMasterId.toString());
                                                              //                               Get.to(() =>
                                                              //                                   AttendancePage(
                                                              //                                     data: todaysdata.todayTasksLst[index],
                                                              //                                     index: index,
                                                              //                                   ));
                                                              //                             },
                                                              //                           ),
                                                              //                           textButtonWidget(
                                                              //                             text:
                                                              //                                 'No',
                                                              //                             onPressed:
                                                              //                                 () {
                                                              //                               Get.back();
                                                              //                             },
                                                              //                           )
                                                              //                         ],
                                                              //                       );
                                                              //                     },
                                                              //                   );
                                                              //                 },
                                                              //                 child: Text(
                                                              //                   "Start",
                                                              //                   style: GoogleFonts
                                                              //                       .dmSans(
                                                              //                     color:
                                                              //                         ColorResources
                                                              //                             .colorBlack,
                                                              //                     fontSize: 15.sp.h,
                                                              //                     fontWeight:
                                                              //                         FontWeight
                                                              //                             .w700,
                                                              //                   ),
                                                              //                 )),
                                                              //           ),
                                                              //         ],
                                                              //       )
                                                              //     ],
                                                              //   ),
                                                              // )
                                                            ],
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .business,
                                                                      color: Color(
                                                                          0xFF294C73),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          250.w,
                                                                      child:
                                                                          Text(
                                                                        todaysdata
                                                                            .todayTasksLst[index]
                                                                            .customerName,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize: 18
                                                                              .sp
                                                                              .h,
                                                                          color:
                                                                              const Color(0xFF294C73),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8.h,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  '${todaysdata.todayTasksLst[index].trainingCourseName} - ${todaysdata.todayTasksLst[index].type}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.sp.h,
                                                                    color: const Color(
                                                                        0xFF294C73),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 16.h,
                                                              ),
                                                              Table(
                                                                border: const TableBorder
                                                                    .symmetric(
                                                                    outside: BorderSide(
                                                                        width:
                                                                            0,
                                                                        color: Colors
                                                                            .white)),
                                                                children: [
                                                                  TableRow(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            const Icon(Icons.category_outlined,
                                                                                color: Color(
                                                                                  0xFF294C73,
                                                                                ),
                                                                                size: 16),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text('Category',
                                                                                style: TextStyle(
                                                                                    color: const Color(
                                                                                      0xFF294C73,
                                                                                    ),
                                                                                    fontSize: 15.sp.h,
                                                                                    fontWeight: FontWeight.w600)),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          todaysdata
                                                                              .todayTasksLst[index]
                                                                              .categoryName,
                                                                          style:
                                                                              GoogleFonts.dmSans(
                                                                            color:
                                                                                ColorResources.colorBlack,
                                                                            fontSize:
                                                                                15.sp.h,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                      ]),
                                                                  const TableRow(
                                                                      children: [
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
                                                                  TableRow(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            const Icon(Icons.location_on_outlined,
                                                                                color: Color(
                                                                                  0xFF294C73,
                                                                                ),
                                                                                size: 16),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text('Location',
                                                                                style: TextStyle(
                                                                                    color: const Color(
                                                                                      0xFF294C73,
                                                                                    ),
                                                                                    fontSize: 15.sp.h,
                                                                                    fontWeight: FontWeight.w600)),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          todaysdata
                                                                              .todayTasksLst[index]
                                                                              .locationName,
                                                                          style:
                                                                              GoogleFonts.dmSans(
                                                                            color:
                                                                                ColorResources.colorBlack,
                                                                            fontSize:
                                                                                15.sp.h,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                      ]),
                                                                  const TableRow(
                                                                      children: [
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
                                                                  TableRow(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            const Icon(Icons.hourglass_top_outlined,
                                                                                color: Color(
                                                                                  0xFF294C73,
                                                                                ),
                                                                                size: 16),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text('Start Exam Time',
                                                                                style: TextStyle(
                                                                                    color: const Color(
                                                                                      0xFF294C73,
                                                                                    ),
                                                                                    fontSize: 15.sp.h,
                                                                                    fontWeight: FontWeight.w600)),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          todaysdata
                                                                              .todayTasksLst[index]
                                                                              .startTime
                                                                              .toUpperCase(),
                                                                          style:
                                                                              GoogleFonts.dmSans(
                                                                            color:
                                                                                ColorResources.colorBlack,
                                                                            fontSize:
                                                                                15.sp.h,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                      ]),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 15.h,
                                                              ),
                                                              GetBuilder<
                                                                      TodayTaskController>(
                                                                  builder:
                                                                      (todayTaskDatas) {
                                                                return Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child: OutlinedButton(
                                                                          style: OutlinedButton.styleFrom(
                                                                            side:
                                                                                const BorderSide(color: Color(0xFFE5AA17)),
                                                                            backgroundColor:
                                                                                Colors.amber[100],
                                                                          ),
                                                                          onPressed: () {
                                                                            print('clicked${todaysdata.todayTasksLst[index].examMasterId}');
                                                                            Get.to(() =>
                                                                                TraineeViewPage(
                                                                                  data: todayTaskDatas.todayTasksLst[index],
                                                                                ));
                                                                          },
                                                                          child: Text(
                                                                            "View",
                                                                            style:
                                                                                GoogleFonts.dmSans(
                                                                              color: ColorResources.colorBlack,
                                                                              fontSize: 15.sp.h,
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                    // todayTaskDatas.todayTasksLst[index].statusId == '5' || todayTaskDatas.todayTasksLst[index].statusId != '1'
                                                                    //     ? const SizedBox()
                                                                    //     : Padding(
                                                                    //         padding: const EdgeInsets.all(7.0),
                                                                    //         child: ElevatedButton(
                                                                    //             style: ElevatedButton.styleFrom(
                                                                    //               backgroundColor: const Color(0xFFE5AA17),
                                                                    //             ),
                                                                    //             onPressed: () async {
                                                                    //               Get.to(() => TrainerExamRescheduleScreen(
                                                                    //                     setState: setState,
                                                                    //                     todaysTaskDetails: todayTaskDatas.todayTasksLst[index],
                                                                    //                   ))?.whenComplete(() {
                                                                    //                 todayTaskAttendanceController.getTodayTaskList();
                                                                    //               });

                                                                    //               // await trainingController.getTraineeDetails(
                                                                    //               //     widget
                                                                    //               //         .todyasTask[
                                                                    //               //             index]
                                                                    //               //         .orderDetailsId
                                                                    //               //         .toString(),
                                                                    //               //     widget
                                                                    //               //         .todyasTask[
                                                                    //               //             index]
                                                                    //               //         .orderLocationId
                                                                    //               //         .toString(),
                                                                    //               //     widget
                                                                    //               //         .todyasTask[index]
                                                                    //               //         .examMasterId
                                                                    //               //         .toString());
                                                                    //             },
                                                                    //             child: Text(
                                                                    //               "Reschedule",
                                                                    //               style: GoogleFonts.dmSans(
                                                                    //                 color: ColorResources.colorBlack,
                                                                    //                 fontSize: 15.sp.h,
                                                                    //                 fontWeight: FontWeight.w700,
                                                                    //               ),
                                                                    //             )),
                                                                    //       ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                const Color(0xFFE5AA17),
                                                                          ),
                                                                          onPressed: todaysdata.todayTasksLst[index].statusId == '5'
                                                                              ? null
                                                                              : () async {
                                                                                  print('task status id  ${todaysdata.todayTasksLst[index].statusId}');

                                                                                  if (todayTaskDatas.todayTasksLst[index].statusName == 'In Progress') {
                                                                                    await todayTaskDatas.getTraineeAttendanceDetails(todayTaskDatas.todayTasksLst[index].orderDetailsId.toString(), todayTaskDatas.todayTasksLst[index].orderLocationId.toString(), todayTaskDatas.todayTasksLst[index].examMasterId.toString());
                                                                                    Get.to(() => AttendancePage(
                                                                                              data: todayTaskDatas.todayTasksLst[index],
                                                                                              index: index,
                                                                                            ))!
                                                                                        .whenComplete(() {
                                                                                      todayTaskAttendanceController.getTodayTaskList();
                                                                                    });
                                                                                  } else if (todayTaskDatas.todayTasksLst[index].statusId == '7') {
                                                                                    await todayTaskAttendanceController.getTraineeAttendanceDetails(
                                                                                      todayTaskDatas.todayTasksLst[index].orderDetailsId.toString(),
                                                                                      todayTaskDatas.todayTasksLst[index].orderLocationId.toString(),
                                                                                      todayTaskDatas.todayTasksLst[index].examMasterId.toString(),
                                                                                    );

                                                                                    // await todayTaskDatas.startExamOrTrainging(
                                                                                    //     examMasterId: todayTaskDatas
                                                                                    //         .todayTasksLst[
                                                                                    //             index]
                                                                                    //         .examMasterId
                                                                                    //         .toString(),
                                                                                    //     orderDetailsSubId: todaysdata
                                                                                    //         .todayTasksLst[
                                                                                    //             index]
                                                                                    //         .orderDetailsSubId
                                                                                    //         .toString());
                                                                                    Get.to(() => ExamAttendanceStopPage(
                                                                                          model: todayTaskDatas.todayTasksLst[index],
                                                                                          index: index,
                                                                                        ));
                                                                                  } else {
                                                                                    await todayTaskDatas.startExamOrTrainging(examMasterId: todayTaskDatas.todayTasksLst[index].examMasterId.toString(), orderDetailsSubId: todaysdata.todayTasksLst[index].orderDetailsSubId.toString());

                                                                                    await todayTaskAttendanceController.getTraineeAttendanceDetails(
                                                                                      todaysdata.todayTasksLst[index].orderDetailsId.toString(),
                                                                                      todaysdata.todayTasksLst[index].orderLocationId.toString(),
                                                                                      todaysdata.todayTasksLst[index].examMasterId.toString(),
                                                                                    );

                                                                                    await Get.to(() => AttendancePage(
                                                                                          data: todaysdata.todayTasksLst[index],
                                                                                          index: index,
                                                                                        ));
                                                                                  }
                                                                                },
                                                                          child: Text(
                                                                            todaysdata.todayTasksLst[index].statusName == 'In Progress' || todaysdata.todayTasksLst[index].statusName == 'Attendance Marked'
                                                                                ? 'Started'
                                                                                : "Start",
                                                                            style:
                                                                                GoogleFonts.dmSans(
                                                                              color: ColorResources.colorBlack,
                                                                              fontSize: 15.sp.h,
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ],
                                                                );
                                                              }),
                                                              todaysdata.todayTasksLst[index]
                                                                          .statusId ==
                                                                      '5'
                                                                  ? Text(
                                                                      todaysdata
                                                                          .todayTasksLst[
                                                                              index]
                                                                          .statusName,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              12.sp),
                                                                    )
                                                                  : Container(),
                                                              // Text('reschedule requested'),
                                                            ],
                                                          ),
                                                        ),
                                            ),
                                          ),
                                        ),
                            );

                            // ListView.separated(
                            //   separatorBuilder: (context, index) => SizedBox(),
                            //   shrinkWrap: true,
                            //   physics: const ClampingScrollPhysics(),
                            //   itemCount: todaysdata.todayTasksLst.length,
                            //   itemBuilder: (context, index) {
                            //     return
                            //   },
                            // );
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
