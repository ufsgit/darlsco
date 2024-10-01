// import 'package:darlsco/controller/tainning/training_controller_home.dart';
// import 'package:darlsco/controller/tainning/training_home_controller.dart';
// import 'package:darlsco/core/constants/color_resources.dart';
// import 'package:darlsco/core/constants/common_widgets.dart';
// import 'package:darlsco/model/training/exam_attendance_model.dart';
// import 'package:darlsco/model/training/get_today_task_model.dart';
// import 'package:darlsco/model/training/save_attendance_model.dart';
// import 'package:darlsco/view/training/exam_attendance_stop_page.dart';
// import 'package:darlsco/view/training/training_home_screen.dart';
// import 'package:darlsco/view/training/widgets/training_widgets.dart';
// import 'package:darlsco/view/training_phase2/todaytask_view.dart';
// import 'package:darlsco/view/training_phase2/training_attended_page.dart';
// import 'package:darlsco/view/training_phase2/upcoming_task.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class ExamAttendancePage extends StatefulWidget {
//   final GetTodayTaskModel data;
//   const ExamAttendancePage({super.key, required this.data});

//   @override
//   State<ExamAttendancePage> createState() => _ExamAttendancePageState();
// }

// class _ExamAttendancePageState extends State<ExamAttendancePage> {
//   // final trainingController = Get.put(TrainingControllerHomee());
//   late List<String> dropdownValues;
//   late bool dataLoaded = false;

//   @override
//   void initState() {
//     dropdownValues = List.generate(
//         trainingController.traineeDetails.length, (index) => itemsList.first);
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       trainingController.getTraineeDetails(
//           widget.data.orderDetailsId.toString(),
//           widget.data.orderLocationId.toString(),
//           widget.data.examMasterId.toString());
//     });
//   }

//   String getCurrentTimeAsString() {
//     DateTime now = DateTime.now();
//     String formattedTime = DateFormat.Hms().format(now);
//     return formattedTime;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: GetBuilder(
//           init: trainingController,
//           builder: (controller) {
//             if (dropdownValues.length !=
//                 trainingController.traineeDetails.length) {
//               dropdownValues = List.generate(
//                   trainingController.traineeDetails.length,
//                   (index) => itemsList.first);
//             }
//             return commonBackgroundLinearColorCart(
//                 childWidget: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 8.h,
//                   ),
//                   InkWell(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: const Icon(
//                         Icons.arrow_back,
//                         color: ColorResources.color294C73,
//                       )),
//                   SizedBox(
//                     height: 16.h,
//                   ),
//                   richTextWidget(
//                     text: widget.data.customerName,
//                     spanText: '',
//                   ),
//                   SizedBox(
//                     height: 16.h,
//                   ),

//                   Container(
//                     decoration: BoxDecoration(
//                       color: ColorResources.whiteColor,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 24),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               widget.data.trainingCourseName,
//                               style: GoogleFonts.dmSans(
//                                 color: ColorResources.color294C73,
//                                 fontSize: 15.sp.h,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 24.h,
//                           ),
//                           ListView.builder(
//                             itemCount: trainingController.traineeDetails.length,
//                             shrinkWrap: true,
//                             physics: const ClampingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return dropdownWidget(
//                                 text:
//                                     '${trainingController.traineeDetails[index].employeeFirstname} ${trainingController.traineeDetails[index].employeeLastname}',
//                                 context: context,
//                                 onChanged: (newValue) {
//                                   setState(() {
//                                     dropdownValues[index] = newValue!;
//                                   });
//                                 },
//                                 dropDownValue: dropdownValues[index],
//                                 itemsList: itemsList,
//                               );
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                   // else
//                   // Column(
//                   //   children: [
//                   //     SizedBox(
//                   //       height: Get.height / 3,
//                   //     ),
//                   //     Center(
//                   //         child: Text(
//                   //       'No trainees to start course',
//                   //       style: GoogleFonts.dmSans(
//                   //         color: ColorResources.color294C73,
//                   //         fontSize: 15.sp.h,
//                   //         fontWeight: FontWeight.w700,
//                   //       ),
//                   //     ))
//                   //   ],
//                   // )
//                 ],
//               ),
//             ));
//           },
//         ),
//         bottomNavigationBar: Obx(() {
//           return Visibility(
//             visible: trainingController.traineeDetails.isNotEmpty,
//             child: elevatedButtonWidget(
//               backgroundColor: ColorResources.colorE5AA17,
//               width: Get.width / 2,
//               context: context,
//               text: 'Start',
//               txtColor: ColorResources.colorBlack,
//               onPressed: () {
             
//                 Get.to(() => ExamAttendanceStopPage(
//                       model: widget.data,
//                     ));
//               },
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
