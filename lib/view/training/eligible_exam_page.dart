import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/controller/tainning/training_home_controller.dart';
import 'package:darlsco/controller/tody_task_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/model/training/eligible_exam_model.dart';
import 'package:darlsco/model/training/get_today_task_model.dart';
import 'package:darlsco/view/training/training_inspection_screen.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EligibleExamPage extends StatefulWidget {
  final GetTodayTaskModel model;
  const EligibleExamPage({
    required this.model,
    super.key,
  });

  @override
  State<EligibleExamPage> createState() => _EligibleExamPageState();
}

class _EligibleExamPageState extends State<EligibleExamPage> {
  // final trainingController = Get.put(TrainingControllerHomee());
  // late List<String> dropdownValues;
  late bool dataLoaded = false;
  // late List<String> dropdownValues;
  TodayTaskController todayTaskController = Get.put(TodayTaskController());
  bool isLoaded = false;

  @override
  void initState() {
    print('eligible exam page');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     getData();
    });
    print('nnokftr ${trainingController.traineeDetails.length}');

    super.initState();
  }

getData()async{
      setState(() => isLoaded = true);

 await  trainingController.getTraineeDetails(
          widget.model.orderDetailsId.toString(),
          widget.model.orderLocationId.toString(),
          widget.model.examMasterId.toString());
              setState(() => isLoaded = false);

}
  String getCurrentTimeAsString() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hms().format(now);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: commonBackgroundLinearColorCart(childWidget:
            GetBuilder<TrainingControllerHomee>(builder: (context) {
          print('sdjnajds ${trainingController.traineeDetails.length}');
          // print('sdjnajds ${drop}');

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: isLoaded
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        InkWell(
                            onTap: () {
                              Get.back();
                              print('SDF');
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: ColorResources.color294C73,
                            )),
                        SizedBox(
                          height: 16.h,
                        ),
                        richTextWidget(
                          text: widget.model.customerName,
                          spanText: '',
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
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
                                    widget.model.trainingCourseName,
                                    style: GoogleFonts.dmSans(
                                      color: ColorResources.color294C73,
                                      fontSize: 15.sp.h,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                ListView.builder(
                                  itemCount:
                                      trainingController.traineeDetails.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return dropdownExamWidget(
                                      text: trainingController
                                              .traineeDetails[index]
                                              .employeeFirstname +
                                          trainingController
                                              .traineeDetails[index]
                                              .employeeLastname,
                                      context: context,
                                      onChanged: (newValue) {
                                        setState(() {
                                          trainingController.dropdownValues
                                              .value[index] = newValue!;
                                        });
                                      },
                                      dropDownValue: trainingController
                                          .dropdownValues.value[index],
                                      itemsList: eligibleList,
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          );
        })),
        bottomNavigationBar: elevatedButtonWidget(
          backgroundColor: ColorResources.colorFF0950A0,
          width: Get.width / 2,
          context: context,
          text: 'Finish',
          txtColor: ColorResources.whiteColor,
          onPressed: () async {
            if (!trainingController.dropdownValues.contains('Select')) {
              await trainingController.fetchTaskCount();
              if (trainingController.dropdownValues.length !=
                  trainingController.traineeDetails.length) {
                trainingController.dropdownValues.value = List.generate(
                    trainingController.traineeDetails.length,
                    (index) => eligibleList.first);
              }
              await trainingController.saveEligibility(EligibleExamModel(
                  eligibilityDetails: List.generate(
                      trainingController.traineeDetails.length,
                      (index) => EligibilityDetails(
                          traineeDetailsId: trainingController
                              .traineeDetails[index].traineeDetailsId,
                          eligibilityStatusId: trainingController
                                      .dropdownValues[index]
                                      .toString() ==
                                  'Eligible for Exam'
                              ? 1
                              : trainingController.dropdownValues[index]
                                          .toString() ==
                                      'Ineligible for Exam'
                                  ? 2
                                  : 0,
                          eligibilityStatusName:
                              trainingController.dropdownValues[index]))));
              await todayTaskController.fetchTaskCount();
              todayTaskController.update();

              await Get.to(() => const TrainingInspectionScreen());
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please choose a value')));
            }
          },
        ),
      ),
    );
  }
}
