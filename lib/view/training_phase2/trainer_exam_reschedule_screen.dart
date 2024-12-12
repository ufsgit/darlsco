// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/task_page.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:darlsco/view/training_phase2/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/training/get_today_task_model.dart';

class TrainerExamRescheduleScreen extends StatefulWidget {
  final GetTodayTaskModel todaysTaskDetails;
  final setState;

  const TrainerExamRescheduleScreen({
    super.key,
    required this.todaysTaskDetails,
    required this.setState,
  });

  @override
  State<TrainerExamRescheduleScreen> createState() => _TrainerExamRescheduleScreenState();
}

class _TrainerExamRescheduleScreenState extends State<TrainerExamRescheduleScreen> {
  TextEditingController notesController = TextEditingController();
  DateTime selectDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(now);
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          commonBackgroundLinearColorCart(
            childWidget: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.todaysTaskDetails.trainingCourseName,
                                  style: TextStyle(fontSize: 35.sp.h, fontWeight: FontWeight.bold, color: Color(0xFF294C73)),
                                ),
                              ),
                            ),
                            Text(
                              '',
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
                                    child: Text(
                                      widget.todaysTaskDetails.trainingCourseName,
                                      style: TextStyle(
                                        fontSize: 16.sp.h,
                                        color: Color(0xFF294C73),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Requesting Date",
                                      style: TextStyle(
                                        fontSize: 14.sp.h,
                                        color: Color(0xFF294C73),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DatePickerExample(
                                      onDateSelected: (DateTime selectedDate) {
                                        selectDate = selectedDate;
                                        print(selectDate);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      "Date may vary based on availability of trainer",
                                      style: TextStyle(fontSize: 12.sp.h, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Notes",
                                      style: TextStyle(
                                        fontSize: 12.sp.h,
                                        color: Color(0xFF294C73),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: notesController,
                                      decoration: InputDecoration(
                                        hintText: "Write here....",
                                        hintStyle: TextStyle(fontSize: 16.sp.h),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFCECECE)), // Set border color here
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFCECECE)), // Set border color here
                                        ),
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  )
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
            ),
          ),
          Positioned(
            bottom: 0,
            child: elevatedButtonWidget(
              context: context,
              text: 'Submit',
              width: Get.width,
              backgroundColor: ColorResources.colorE5AA17,
              txtColor: ColorResources.colorBlack,
              onPressed: () async {
                print('Selected Date: $selectDate');

                try {
                  await trainingController.rescheduleExam(context: context, todaysExamDetails: widget.todaysTaskDetails, selectedDate: selectDate!, notes: notesController.text);
                  await todayTaskController.getTodayTaskList();
                  todayTaskController.update();
                  trainingController.update();
                  widget.setState(() {});
                } catch (e) {
                  // Get.snackbar(
                  //   'Failed',
                  //   'Failed to reschedule course: $e',
                  //   backgroundColor: Colors.red,
                  //   colorText: Colors.white,
                  //   snackPosition: SnackPosition.BOTTOM,
                  // );
                }
                            },
            ),
          )
        ],
      )),
    );
  }
}
