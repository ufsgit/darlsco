// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/model/training/trainee_reassign_model.dart';
import 'package:darlsco/model/training/upcoming_task_model.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TrainnerAssigning extends StatefulWidget {
  final UpComingTaskModel upComingTask;
  const TrainnerAssigning({super.key, required this.upComingTask});

  @override
  State<TrainnerAssigning> createState() => _TrainnerAssigningState();
}

class _TrainnerAssigningState extends State<TrainnerAssigning> {
  late DateTime selectedDate;

  final RxString selectedTrainer = ''.obs;
  final RxInt selectedTrainerId = 0.obs;

  String? errorTextTrainer;
  String? errorTextNotes;

  // Function to update selected date
  void updateSelectedDate(DateTime newSelectedDate) {
    setState(() {
      selectedDate = newSelectedDate;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedTrainer.value = '';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      trainingController.getTrainerList();
      if (trainingController.trainerList.isNotEmpty) {
        selectedTrainer.value =
            trainingController.trainerList.first.userDetailsName;
        selectedTrainerId.value =
            trainingController.trainerList.first.userDetailsId;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String dateString = widget.upComingTask.startDate.toString();
    DateTime parsedDate = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    return SafeArea(
      child: Scaffold(
        body: commonBackgroundLinearColor(
          childWidget: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 16.h),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.upComingTask.customerName.split(' ')[0],
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF294C73)),
                          ),
                        ),
                        Text(
                          widget.upComingTask.customerName
                              .split(' ')
                              .skip(1)
                              .join(' '),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 0.1
                              ..color = Color(0xFF294C73),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.upComingTask.trainingCourseName,
                                      style: TextStyle(
                                        color: Color(0xFF294C73),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Date",
                                      style: TextStyle(
                                        color: Color(0xFF294C73),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  SizedBox(
                                    width: 220.w,
                                    child: disabledDatePickerWidget(
                                        text: formattedDate),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Trainer Name",
                                      style: TextStyle(
                                        color: Color(0xFF294C73),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: ColorResources.colorDCCCFF),
                                    ),
                                    width: 220.w,
                                    height: 55.h,
                                    child: Obx(() {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                          hint: Text(
                                            'Select Trainer',
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w),
                                          isExpanded: true,
                                          style: GoogleFonts.dmSans(
                                            color: ColorResources.colorBlack,
                                            fontSize: 14.sp.h,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          value:
                                              selectedTrainer.value.isNotEmpty
                                                  ? selectedTrainer.value
                                                  : null,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: trainingController
                                                  .trainerList.isNotEmpty
                                              ? trainingController.trainerList
                                                  .map((trainer) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value:
                                                        trainer.userDetailsName,
                                                    child: Text(trainer
                                                        .userDetailsName),
                                                    onTap: () {
                                                      selectedTrainerId.value =
                                                          trainer.userDetailsId;
                                                    },
                                                  );
                                                }).toList()
                                              : [],
                                          onChanged: (value) {
                                            selectedTrainer.value = value!;
                                          },
                                        ),
                                      );
                                    }),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Notes",
                                      style: TextStyle(
                                        color: Color(0xFF294C73),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  SizedBox(
                                    width: 220.w,
                                    child: TextFormField(
                                      controller:
                                          trainingController.notesController,
                                      decoration: InputDecoration(
                                        hintText: "Write here....",
                                        hintStyle: TextStyle(fontSize: 16.sp),
                                        errorText: errorTextNotes,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFCECECE)), // Set border color here
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFCECECE)), // Set border color here
                                        ),
                                      ),
                                      maxLines: 3,
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          errorTextNotes =
                                              'Notes must be specified!';
                                        } else {
                                          errorTextNotes = null;
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
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
        bottomNavigationBar: SizedBox(
          height: 60.h,
          width: MediaQuery.sizeOf(context).width,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(side: BorderSide.none),
                  backgroundColor: Color(0xFFE5AA17)),
              onPressed: () {
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
                        'Are you sure!\nDo you want to submit the reassigned task?',
                        style: GoogleFonts.dmSans(
                          // color: ColorResources.colorBlack,
                          fontSize: 16.sp.h,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      actions: [
                        textButtonWidget(
                          text: 'Yes',
                          onPressed: () async{
                            Get.back();
                         
                           await trainingController.traineeReassign(
                                ReassignModel(
                                  orderDetailsSubId:
                                      widget.upComingTask.orderDetailsSubId,
                                  trainerId: selectedTrainerId.value,
                                  trainerName: selectedTrainer.value,
                                  expectedDate: widget.upComingTask.startDate,
                                  notes:
                                      trainingController.notesController.text,
                                ),
                                context);
                                Get.back();

                                 
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
              child: Text("Submit",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700))),
        ),
      ),
    );
  }
}
