// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:darlsco/view/training_phase2/trainer_assinging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingTask extends StatefulWidget {
  const UpcomingTask({super.key});

  @override
  State<UpcomingTask> createState() => _UpcomingTaskState();
}

class _UpcomingTaskState extends State<UpcomingTask> {
  bool _isButtonHovered = false;
  late bool dataLoaded = false;
  final TrainingControllerHomee trainingHomeController =
      Get.put(TrainingControllerHomee());

  @override
  void initState() {
    trainingHomeController.getUpComingTask();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: commonBackgroundLinearColor(
          childWidget: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.h, vertical: 16.h),
                  child: Column(
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
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Upcoming",
                              style: TextStyle(
                                fontSize: 35.sp.h,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF294C73),
                              ),
                            ),
                          ),
                          Text(
                            'Tasks',
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
                      GetBuilder<TrainingControllerHomee>(
                          init: trainingHomeController,
                          builder: (controller) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: controller.upComingTasks.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.business,
                                                  color: Color(0xFF294C73)),
                                              SizedBox(width: 5),
                                              Text(
                                                controller.upComingTasks[index]
                                                    .customerName,
                                                style: TextStyle(
                                                  fontSize: 15.sp.h,
                                                  color: Color(0xFF294C73),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15.h),
                                          Row(
                                            children: [
                                              Icon(Icons.circle_outlined,
                                                  color: Color(0xFF294C73)),
                                              SizedBox(width: 5),
                                              Text(
                                                "${controller.upComingTasks[index].trainingCourseName} - ${controller.upComingTasks[index].type}",
                                                style: TextStyle(
                                                  fontSize: 13.sp.h,
                                                  color: Color(0xFF294C73),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15.h),
                                          Row(
                                            children: [
                                              Icon(Icons.group_outlined,
                                                  color: Color(0xFF294C73),
                                                  size: 16),
                                              SizedBox(width: 5),
                                              Text(
                                                'Trainees - ${controller.upComingTasks[index].traineeCount.toString()}',
                                                style: TextStyle(
                                                  color: Color(0xFF294C73),
                                                  fontSize: 16.sp.h,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15.h),
                                          Row(
                                            children: [
                                              Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: Color(0xFF294C73),
                                                  size: 16),
                                              SizedBox(width: 5),
                                              Text(
                                                controller.upComingTasks[index]
                                                    .startDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Color(0xFF294C73),
                                                  fontSize: 16.sp.h,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15.h),
                                          Row(
                                            children: [
                                              Icon(Icons.access_time,
                                                  color: Color(0xFF294C73),
                                                  size: 16),
                                              SizedBox(width: 5),
                                              Text(
                                                controller.upComingTasks[index]
                                                    .startTime
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Color(0xFF294C73),
                                                  fontSize: 16.sp.h,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15.h),
                                          controller.upComingTasks[index]
                                                      .type ==
                                                  'Training'
                                              ? SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                              .size
                                                              .width >
                                                          700
                                                      ? 55
                                                      : 40,
                                                  child: MouseRegion(
                                                    onEnter: (_) {
                                                      setState(() {
                                                        _isButtonHovered = true;
                                                      });
                                                    },
                                                    onExit: (_) {
                                                      setState(() {
                                                        _isButtonHovered =
                                                            false;
                                                      });
                                                    },
                                                    child: OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                            color: controller
                                                                        .upComingTasks[
                                                                            index]
                                                                        .statusId ==
                                                                    '5'
                                                                ? Colors.grey
                                                                    .withOpacity(
                                                                        .2)
                                                                : Color(
                                                                    0xFFE5AA17)),
                                                        backgroundColor: controller
                                                                    .upComingTasks[
                                                                        index]
                                                                    .statusId ==
                                                                '5'
                                                            ? Colors.grey
                                                                .withOpacity(.2)
                                                            : _isButtonHovered
                                                                ? Color(
                                                                    0xFFE5AA17)
                                                                : Colors
                                                                    .amber[100],
                                                      ),
                                                      onPressed: controller
                                                                  .upComingTasks[
                                                                      index]
                                                                  .statusId ==
                                                              '5'
                                                          ? null
                                                          : () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    backgroundColor:
                                                                        ColorResources
                                                                            .whiteColor,
                                                                    shape: ContinuousRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.r)),
                                                                    elevation:
                                                                        10,
                                                                    shadowColor:
                                                                        ColorResources
                                                                            .color294C73,
                                                                    content:
                                                                        Text(
                                                                      'Are you sure!\nDo you want to reassign this task?',
                                                                      style: GoogleFonts
                                                                          .dmSans(
                                                                        color: ColorResources
                                                                            .colorBlack,
                                                                        fontSize: 16
                                                                            .sp
                                                                            .h,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      textButtonWidget(
                                                                        text:
                                                                            'Yes',
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                          Get.to(() =>
                                                                              TrainnerAssigning(
                                                                                upComingTask: controller.upComingTasks[index],
                                                                              ));
                                                                        },
                                                                      ),
                                                                      textButtonWidget(
                                                                        text:
                                                                            'No',
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                      )
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                      child: Text("Reassign",
                                                          style: TextStyle(
                                                              color: controller
                                                                          .upComingTasks[
                                                                              index]
                                                                          .statusId ==
                                                                      '5'
                                                                  ? Colors.black
                                                                      .withOpacity(
                                                                          .7)
                                                                  : Colors
                                                                      .black,
                                                              fontSize:
                                                                  14.sp.h)),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          controller.upComingTasks[index]
                                                      .statusId ==
                                                  '5'
                                              ? Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Reassign Requested',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 12.sp),
                                                  ),
                                                )
                                              : Container(),
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
