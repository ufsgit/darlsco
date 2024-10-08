import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TotalTrainingAttendedPage extends StatefulWidget {
  const TotalTrainingAttendedPage({
    super.key,
  });

  @override
  State<TotalTrainingAttendedPage> createState() =>
      _TotalTrainingAttendedPageState();
}

class _TotalTrainingAttendedPageState extends State<TotalTrainingAttendedPage> {
  late bool dataLoaded = false;
  final TrainingControllerHomee trainingHomeController =
      Get.put(TrainingControllerHomee());
  @override
  void initState() {
    trainingHomeController.getTotalTraining();

    super.initState();
  }

  // String convertTo12HourFormat(String time24) {
  //   // Parse the 24-hour format time
  //   DateTime dateTime = DateFormat("HH:mm:ss").parse(time24);

  //   // Format the DateTime object to 12-hour format
  //   String formattedTime = DateFormat("hh:mm a").format(dateTime);

  //   return formattedTime;
  // }

  @override
  Widget build(BuildContext context) {
    String formatDateString(String dateString) {


      final DateTime parsedDate = DateTime.parse(dateString);
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(parsedDate);
    }

    return SafeArea(
      child: Scaffold(
        body: commonBackgroundLinearColorCart(
          childWidget: SizedBox(
            height: Get.height,
            width: Get.width,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 8.h),
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
                      //     child: const Icon(
                      //         Icons.dashboard_customize_outlined),
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
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Total Task",
                              style: TextStyle(
                                fontSize: 35.sp.h,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF294C73),
                              ),
                            ),
                          ),
                          Text(
                            'Taken',
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

                      GetBuilder<TrainingControllerHomee>(
                          init: trainingHomeController,
                          builder: (cntrl) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: cntrl.totalTrainingData.length,
                              itemBuilder: (context, index) {
                                String formatTime(String startTime) {
                                  DateTime parsedTime =
                                      DateFormat("HH:mm:ss").parse(startTime);
                                  String formattedTime =
                                      DateFormat("hh:mm a").format(parsedTime);

                                  return formattedTime;
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.r),
                                      // boxShadow: [
                                      //   // BoxShadow(
                                      //   //     blurRadius: 10,
                                      //   //     color: ColorResources.color294C73
                                      //   //         .withOpacity(.5))
                                      // ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.business,
                                                  color: Color(0xFF294C73),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                
                                                  child: Text(
                                                    trainingHomeController
                                                        .totalTrainingData[index]
                                                        .customerName,
                                                    style: TextStyle(
                                                      fontSize: 17.sp.h,
                                                      color: ColorResources
                                                          .colorBlack,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 200.w,
                                                  child: Text(
                                                    cntrl.totalTrainingData[index]
                                                        .trainingCourseName,
                                                    style: TextStyle(
                                                      fontSize: 15.sp.h,
                                                      color: const Color(0xFF294C73),
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 40.w,),


                                              Text(
                                                      trainingHomeController
                                                          .totalTrainingData[index]
                                                          .trainingType,
                                                      style: TextStyle(
                                                        fontSize: 17.sp.h,
                                                        color: ColorResources
                                                            .colorBlack,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Table(
                                            border:    TableBorder.symmetric(
                                                outside: BorderSide(
                                                    width: 0,
                                                    color: Colors.white)),
                                            children: [
                                              TableRow(children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.category_outlined,
                                                        color: Color(
                                                          0xFF294C73,
                                                        ),
                                                        size: 16),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text('Category',
                                                        style: TextStyle(
                                                            color: const Color(
                                                              0xFF294C73,
                                                            ),
                                                            fontSize: 15.sp.h,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ],
                                                ),
                                                Text(
                                                  cntrl.totalTrainingData[index]
                                                      .categoryName,
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources
                                                        .colorBlack,
                                                    fontSize: 15.sp.h,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ]),
                                              const TableRow(children: [
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
                                                    const Icon(
                                                        Icons
                                                            .hourglass_top_outlined,
                                                        color: Color(
                                                          0xFF294C73,
                                                        ),
                                                        size: 16),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    SizedBox(
                                                      width: 130.w,
                                                      child: Text( cntrl.totalTrainingData[index].trainingType.toString()=='Exam'? 'Schedule Exam  Start Time' :     'Expected Training Start Time',
                                                          style: TextStyle(
                                                              color: const Color(
                                                                0xFF294C73,
                                                              ),
                                                              fontSize: 15.sp.h,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  cntrl.totalTrainingData[index]
                                                      .expectedStartTime.toUpperCase(),
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources
                                                        .colorBlack,
                                                    fontSize: 15.sp.h,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ]),
                                                const TableRow(children: [
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

                                             if(cntrl.totalTrainingData[index].trainingType.toString()!='Exam') TableRow(children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .hourglass_top_outlined,
                                                        color: Color(
                                                          0xFF294C73,
                                                        ),
                                                        size: 16),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    SizedBox(
                                                      width: 130.w,
                                                      child: Text('Expected Training End Time',
                                                          style: TextStyle(
                                                              color: const Color(
                                                                0xFF294C73,
                                                              ),
                                                              fontSize: 15.sp.h,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  cntrl.totalTrainingData[index]
                                                      .expectedEndTime.toUpperCase(),
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources
                                                        .colorBlack,
                                                    fontSize: 15.sp.h,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ]),
                                                const TableRow(children: [
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

                                          // if(cntrl.totalTrainingData[index].trainingType.toString()!='Exam')     
                                        TableRow(children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .hourglass_top_outlined,
                                                        color: Color(
                                                          0xFF294C73,
                                                        ),
                                                        size: 16),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    SizedBox(
                                                      width: 130.w,
                                                      child: Text(cntrl.totalTrainingData[index].trainingType.toString()=='Exam'? 'Actual Exam Time' :'Actual Training Start Time',
                                                          style: TextStyle(
                                                              color: const Color(
                                                                0xFF294C73,
                                                              ),
                                                              fontSize: 15.sp.h,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  cntrl.totalTrainingData[index]
                                                      .startTime.toUpperCase(),
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources
                                                        .colorBlack,
                                                    fontSize: 15.sp.h,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ]),
                                                const TableRow(children: [
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
                                          if(cntrl.totalTrainingData[index].trainingType.toString()!='Exam')   TableRow(children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .hourglass_bottom_outlined,
                                                        color: Color(
                                                          0xFF294C73,
                                                        ),
                                                        size: 16),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    SizedBox(
                                                      width: 140.w,
                                                      child: Text('Actual Training End Time',
                                                          style: TextStyle(
                                                              color: const Color(
                                                                0xFF294C73,
                                                              ),
                                                              fontSize: 15.sp.h,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  cntrl.totalTrainingData[index]
                                                      .endTime.toUpperCase(),
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources
                                                        .colorBlack,
                                                    fontSize: 15.sp.h,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ]),
                                              const TableRow(children: [
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
                                                    const Icon(
                                                        Icons
                                                            .hourglass_top_outlined,
                                                        color: Color(
                                                          0xFF294C73,
                                                        ),
                                                        size: 16),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text('Start Date',
                                                        style: TextStyle(
                                                            color: const Color(
                                                              0xFF294C73,
                                                            ),
                                                            fontSize: 15.sp.h,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ],
                                                ),
                                                Text(cntrl
                                                      .totalTrainingData[index]
                                                      .startDate
                                                      .toString().isEmpty?'':
                                                formatDateString(cntrl
                                                      .totalTrainingData[index]
                                                      .startDate
                                                      .toString().toUpperCase(),)  ,
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources
                                                        .colorBlack,
                                                    fontSize: 15.sp.h,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ]),
                                              const TableRow(children: [
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
                                          if(cntrl.totalTrainingData[index].trainingType.toString()!='Exam')      TableRow(children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .hourglass_top_outlined,
                                                        color: Color(
                                                          0xFF294C73,
                                                        ),
                                                        size: 16),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text('End Date',
                                                        style: TextStyle(
                                                            color: const Color(
                                                              0xFF294C73,
                                                            ),
                                                            fontSize: 15.sp.h,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ],
                                                ),
                                                Text(cntrl
                                                      .totalTrainingData[index]
                                                      .endDate
                                                      .toString().isEmpty?'':

                                                  formatDateString(cntrl
                                                      .totalTrainingData[index]
                                                      .endDate
                                                      .toString().toUpperCase(),)


                                                 ,
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources
                                                        .colorBlack,
                                                    fontSize: 15.sp.h,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ]),
                                              if(cntrl.totalTrainingData[index].trainingType.toString()!='Exam')  const TableRow(children: [
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
                                             if(cntrl.totalTrainingData[index].trainingType.toString()!='Exam')   TableRow(children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .watch_later_outlined,
                                                        color: Color(
                                                          0xFF294C73,
                                                        ),
                                                        size: 16),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text('Total duration',
                                                        style: TextStyle(
                                                            color: const Color(
                                                              0xFF294C73,
                                                            ),
                                                            fontSize: 15.sp.h,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ],
                                                ),
                                                Text(
                                                  cntrl.totalTrainingData[index]
                                                      .duration,
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources
                                                        .colorBlack,
                                                    fontSize: 15.sp.h,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ]),
                                              if(cntrl.totalTrainingData[index].trainingType.toString()!='Exam')  const TableRow(children: [
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
                                                    const Icon(
                                                        Icons
                                                            .hourglass_top_outlined,
                                                        color: Color(
                                                          0xFF294C73,
                                                        ),
                                                        size: 16),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text('Status',
                                                        style: TextStyle(
                                                            color: const Color(
                                                              0xFF294C73,
                                                            ),
                                                            fontSize: 15.sp.h,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ],
                                                ),
                                                Text(cntrl
                                                      .totalTrainingData[index]
                                                      .statusName
                                                      .toString()


                                                 ,
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources
                                                        .colorBlack,
                                                    fontSize: 15.sp.h,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ]),
                                              const TableRow(children: [
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
                                            ],
                                          ),

                                          





                                          // Align(
                                          //   alignment: Alignment.center,
                                          //   child:
                                          //       GetBuilder<TodayTaskController>(
                                          //           builder: (countData) {
                                          //     return ElevatedButton(
                                          //         style:
                                          //             ElevatedButton.styleFrom(
                                          //                 backgroundColor:
                                          //                     ColorResources
                                          //                         .colorE5AA17),
                                          //         onPressed: () async {
                                          //           await trainingController
                                          //               .eligibilityData(
                                          //                   controller
                                          //                       .totalTrainingData[
                                          //                           index]
                                          //                       .orderDetailsSubId,
                                          //                   index);
                                          //         },
                                          //         child: const Text(
                                          //           'Update Eligibility',
                                          //           style: TextStyle(
                                          //               color: ColorResources
                                          //                   .colorBlack,
                                          //               fontWeight:
                                          //                   FontWeight.w400),
                                          //         ));
                                          //   }),
                                          // )
                                          // Align(
                                          //   alignment: Alignment.center,
                                          //   child: Container(
                                          //     height: 40,
                                          //     decoration: BoxDecoration(
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 30.r)),
                                          //     child: elevatedButtonWidget(
                                          //       context: context,
                                          //       text: 'Update Eligibility',
                                          //       width: Get.width / 2,
                                          //       backgroundColor:
                                          //           ColorResources.colorE5AA17,
                                          //       txtColor:
                                          //           ColorResources.whiteColor,
                                          //       onPressed: () {},
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
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
