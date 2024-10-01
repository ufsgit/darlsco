import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/controller/tainning/training_home_controller.dart';
import 'package:darlsco/controller/tody_task_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/model/training/exam_attendance_model.dart';
import 'package:darlsco/model/training/get_today_task_model.dart';
import 'package:darlsco/model/training/save_attendance_model.dart';
import 'package:darlsco/view/training/exam_attendance_stop_page.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:darlsco/view/training_phase2/todaytask_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendancePage extends StatefulWidget {
  final GetTodayTaskModel data;
  final int index;

  const AttendancePage({super.key, required this.data, required this.index});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final trainingController = Get.put(TrainingControllerHomee());
  final TodayTaskController todayTaskController =
      Get.put(TodayTaskController());
  List<String> dropdownValues = [];
  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchAttendanceDetails();
    });

    super.initState();
  }

  Future<void> _fetchAttendanceDetails() async {
    await todayTaskController.getTraineeAttendanceDetails(
      widget.data.orderDetailsId.toString(),
      widget.data.orderLocationId.toString(),
      widget.data.examMasterId.toString(),
    );
    setState(() {
      dropdownValues = List.generate(
        todayTaskController.traineeAttendanceList.length,
        (index) => itemsList.first,
      );
      isLoading = false;
    });
  }

  String getCurrentTimeAsString() {
    DateTime now = DateTime.now();
    return DateFormat.Hms().format(now);
  }

  void _navigateToPage(Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.off(() => page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: commonBackgroundLinearColorCart(
          childWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Get.back(),
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
                SizedBox(height: 16.h),
                richTextWidget(text: widget.data.customerName, spanText: ''),
                SizedBox(height: 16.h),
                Container(
                  decoration: BoxDecoration(
                    color: ColorResources.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.data.trainingCourseName,
                            style: GoogleFonts.dmSans(
                              color: ColorResources.color294C73,
                              fontSize: 15.sp.h,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        GetBuilder<TodayTaskController>(
                          builder: (traineeDetailsData) {
                            if (dropdownValues.length !=
                                traineeDetailsData
                                    .traineeAttendanceList.length) {
                              dropdownValues = List.generate(
                                traineeDetailsData.traineeAttendanceList.length,
                                (index) => itemsList.first,
                              );
                            }
                            return SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  traineeDetailsData
                                      .traineeAttendanceList.length,
                                  (index) => dropdownWidget(
                                    text:
                                        '${traineeDetailsData.traineeAttendanceList[index].employeeFirstname} ${traineeDetailsData.traineeAttendanceList[index].employeeLastname}',
                                    context: context,
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownValues[index] = newValue!;
                                      });
                                    },
                                    dropDownValue: dropdownValues[index],
                                    itemsList: itemsList,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: GetBuilder<TodayTaskController>(
          builder: (attendanceData) {
            return Visibility(
              visible: attendanceData.traineeAttendanceList.isNotEmpty,
              child: elevatedButtonWidget(
                  backgroundColor: ColorResources.colorE5AA17,
                  width: Get.width / 2,
                  context: context,
                  text: 'Update Attendance',
                  txtColor: ColorResources.colorBlack,
                  onPressed: () {
                    print('dfwefdw $dropdownValues');
                    if (dropdownValues.any((v) => v != 'Select')) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                              'Are you sure!\nDo you want to update the attendance?',
                              style: GoogleFonts.dmSans(
                                fontSize: 16.sp.h,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            actions: [
                              textButtonWidget(
                                text: 'Yes',
                                onPressed: widget.data.examMasterId == 0
                                    ? () async {
                                        Get.back();
                                        final currentTime =
                                            getCurrentTimeAsString();
                                        todayTaskController
                                            .attendanceTime.value = currentTime;
                                        await trainingController
                                            .saveAttendance(SaveAttendanceModel(
                                          attendanceDate:
                                              DateTime.now().toIso8601String(),
                                          attendanceTime: currentTime,
                                          userId: 0,
                                          orderDetailsSubId:
                                              widget.data.orderDetailsSubId,
                                          attendanceDetails: List.generate(
                                            todayTaskController
                                                .traineeAttendanceList.length,
                                            (index) => AttendanceDetails(
                                              trainingCourseId:
                                                  widget.data.trainingCourseId,
                                              trainingCourseName: widget
                                                  .data.trainingCourseName,
                                              trainingCourseCategoryId: widget
                                                  .data
                                                  .trainingCourseCategoryId,
                                              categoryName:
                                                  widget.data.categoryName,
                                              traineeId: todayTaskController
                                                  .traineeAttendanceList[index]
                                                  .traineeDetailsId,
                                              traineeName:
                                                  '${todayTaskController.traineeAttendanceList[index].employeeFirstname} ${todayTaskController.traineeAttendanceList[index].employeeLastname}',
                                              attendanceStatusId:
                                                  dropdownValues[index] ==
                                                          'Present'
                                                      ? 1
                                                      : dropdownValues[index] ==
                                                              'Absent'
                                                          ? 2
                                                          : 0,
                                              attendanceStatusName:
                                                  dropdownValues[index],
                                            ),
                                          ),
                                        ));

                                        await trainingController
                                            .getTraineeDetails(
                                          widget.data.orderDetailsId.toString(),
                                          widget.data.orderLocationId
                                              .toString(),
                                          widget.data.examMasterId.toString(),
                                        );

                                        _navigateToPage(TodayTaskView(
                                            model: widget.data,
                                            index: widget.index));
                                      }
                                    : () async {
                                        Get.back();
                                        final currentTime =
                                            getCurrentTimeAsString();
                                        todayTaskController
                                            .attendanceTime.value = currentTime;
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        final String customerId =
                                            prefs.getString('darlsco_id') ?? "";
                                        await trainingController
                                            .saveExamAttendance(
                                          ExamAttendanceModel(
                                            attendanceDate: DateTime.now()
                                                .toIso8601String(),
                                            attendanceTime: currentTime,
                                            userId: 0,
                                            examMasterId:
                                                widget.data.examMasterId,
                                            examDetails: List.generate(
                                              todayTaskController
                                                  .traineeAttendanceList.length,
                                              (index) => ExamAttendanceDetails(
                                                trainingCourseName: widget
                                                    .data.trainingCourseName,
                                                trainerId:
                                                    widget.data.trainerId,
                                                trainerName: todayTaskController
                                                    .traineeAttendanceList[
                                                        index]
                                                    .employeeFirstname,
                                                traineeId: todayTaskController
                                                    .traineeAttendanceList[
                                                        index]
                                                    .traineeDetailsId,
                                                traineeName:
                                                    widget.data.customerName,
                                                trainingCourseId: widget
                                                    .data.trainingCourseId,
                                                trainingCourseCategoryId: widget
                                                    .data
                                                    .trainingCourseCategoryId,
                                                categoryName:
                                                    widget.data.categoryName,
                                                attendanceStatusId:
                                                    dropdownValues[index] ==
                                                            'Present'
                                                        ? 1
                                                        : dropdownValues[
                                                                    index] ==
                                                                'Absent'
                                                            ? 2
                                                            : 0,
                                                attendanceStatusName:
                                                    dropdownValues[index],
                                              ),
                                            ),
                                          ),
                                        );

                                        _navigateToPage(ExamAttendanceStopPage(
                                          model: widget.data,
                                          index: 0,
                                        ));
                                      },
                              ),
                              textButtonWidget(
                                  text: 'No', onPressed: () => Get.back()),
                            ],
                          );
                        },
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please check the value selected')));
                    }
                  }),
            );
          },
        ),
      ),
    );
  }
}
