import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/retake_bill_page.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class ExamFailedListPage extends StatefulWidget {
  const ExamFailedListPage({
    super.key,
  });

  @override
  State<ExamFailedListPage> createState() => _ExamFailedListPageState();
}

class _ExamFailedListPageState extends State<ExamFailedListPage> {
  final trainingHomeController = Get.put(TrainingControllerHomee());
  late List<bool> isCheckedList;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        init();
      },
    );

    trainingHomeController.retakePurchaseBillDataList.clear();
    isCheckedList = []; // Initialize with an empty list

    print(
        'range error checking ${trainingHomeController.examFailedTraineeDetails}');
  }

  init() async {
    trainingHomeController.failedTraineesData = List.generate(
        trainingHomeController.examFailedTraineeDetails.length,
        (index) => {
              'Location_Id': trainingHomeController
                  .examFailedTraineeDetails[index].locationId,
              'Order_Location_Id': trainingHomeController
                  .examFailedTraineeDetails[index].orderLocationId,
              "Trainee_Id_": trainingHomeController
                  .examFailedTraineeDetails[index].traineeId,
              "Writen_Status_Id_": trainingHomeController
                  .examFailedTraineeDetails[index].writenStatusId,
              "Pratical_Status_Id_": trainingHomeController
                  .examFailedTraineeDetails[index].praticalStatusId,
              "Vat": trainingHomeController
                  .examFailedTraineeDetails[index].vatAmount,
              "Amount":
                  trainingHomeController.examFailedTraineeDetails[index].amount,
              "Sub_Total": trainingHomeController
                  .examFailedTraineeDetails[index].subTotal,
              "is_selected": false,
            }).toList();

    trainingHomeController.update();
  }

  bool isAnyCheckboxSelected() {
    return trainingHomeController.failedTraineesData
        .any((item) => item['is_selected'] == true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<TrainingControllerHomee>(
        
          builder: (controller) {
            return commonBackgroundLinearColorCart(
              childWidget: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 32.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      controller.examFailedTraineeDetails.length,
                      (index) => Container(
                        margin: EdgeInsets.only(top: 15.w),
                        padding: EdgeInsets.all(10.w),
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ColorResources.whiteColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F8FF),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 250.w,
                                    child: Text(
                                      controller.examFailedTraineeDetails[index]
                                          .trainingCourseName,
                                      style: GoogleFonts.dmSans(
                                        color: ColorResources.color294C73,
                                        fontSize: 18.sp.h,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10.w,
                                  ),

                                  SizedBox(
                                    width: 250.w,
                                    child: Text(
                                      controller.examFailedTraineeDetails[index]
                                          .traineeName,
                                      style: GoogleFonts.dmSans(
                                        color: ColorResources.color294C73,
                                        fontSize: 18.sp.h,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.w,
                                  ),

                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Written Status : ',
                                      style: GoogleFonts.dmSans(
                                        color: ColorResources.color294C73,
                                        fontSize: 18.sp.h,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          controller.examFailedTraineeDetails[index].writenStatusName,
                                      style: GoogleFonts.dmSans(
                                        color: controller
                                                    .examFailedTraineeDetails[
                                                        index]
                                                    .writenStatusId ==
                                                2
                                            ? Colors.red
                                            : Colors.green,
                                        fontSize: 18.sp.h,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ])),

                                  //

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                          text: 'Practical Status : ',
                                          style: GoogleFonts.dmSans(
                                            color: ColorResources.color294C73,
                                            fontSize: 18.sp.h,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: controller
                                              .examFailedTraineeDetails[index]
                                              .praticalStatusName,
                                          style: GoogleFonts.dmSans(
                                            color: controller
                                                        .examFailedTraineeDetails[
                                                            index]
                                                        .praticalStatusId ==
                                                    2
                                                ? Colors.red
                                                : Colors.green,
                                            fontSize: 18.sp.h,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ])),
                                      GetBuilder<TrainingControllerHomee>(
                                          builder: (checkboxSelected) {
                                        return Checkbox(
                                          activeColor:
                                              ColorResources.color294C73,
                                          shape:
                                              const ContinuousRectangleBorder(),
                                          side: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 124, 124, 124)),
                                          value: checkboxSelected
                                                  .failedTraineesData.isEmpty
                                              ? false
                                              : checkboxSelected
                                                      .failedTraineesData[index]
                                                  ['is_selected'],
                                          onChanged: controller
                                                          .examFailedTraineeDetails[
                                                              index]
                                                          .retakeCount
                                                          .toString() ==
                                                      '2' ||
                                                  controller
                                                          .examFailedTraineeDetails[
                                                              index]
                                                          .validityStatus ==
                                                      'Expired'
                                              ? null
                                              : (bool? value) async{

                                                trainingController.transactionFee= await   trainingController.getTransactionFee();



                                                  checkboxSelected
                                                              .failedTraineesData[
                                                          index]
                                                      ['is_selected'] = value;

                                                  if (value == true) {
                                                    print(index);



                                                    
                                                    controller
                                                        .retakePurchaseBillDataList
                                                        .add({
                                                      'order_master_id': controller
                                                          .examFailedTraineeDetails[
                                                              index]
                                                          .orderMasterId,
                                                      'category_id': controller
                                                          .examFailedTraineeDetails[
                                                              index]
                                                          .categoryId,
                                                      "course_name": controller
                                                          .examFailedTraineeDetails[
                                                              index]
                                                          .trainingCourseName,
                                                      "category": controller
                                                          .examFailedTraineeDetails[
                                                              index]
                                                          .categoryName,
                                                      "examination_fee": controller
                                                          .examFailedTraineeDetails[
                                                              index]
                                                          .amount,
                                                      "examination_vat": controller
                                                          .examFailedTraineeDetails[
                                                              index]
                                                          .vatPercentage,
                                                      "Amount": controller
                                                          .examFailedTraineeDetails[
                                                              index]
                                                          .amount,
                                                      "Vat": controller
                                                          .examFailedTraineeDetails[
                                                              index]
                                                          .vatAmount,
                                                      "Sub_Total": controller
                                                          .examFailedTraineeDetails[
                                                              index]
                                                          .subTotal,
                                                      "transaction_fee": "0",
                                                      'grant_total': (double.parse(
                                                                  controller
                                                                      .examFailedTraineeDetails[
                                                                          index]
                                                                      .amount
                                                                      .toString()) +
                                                              double.parse(controller
                                                                  .examFailedTraineeDetails[
                                                                      index]
                                                                  .vatAmount)) +
                                                          (((double.parse(controller
                                                                          .examFailedTraineeDetails[
                                                                              index]
                                                                          .amount) +
                                                                      double.parse(controller
                                                                          .examFailedTraineeDetails[
                                                                              index]
                                                                          .vatAmount)) *double.parse(
                                                                trainingController.transactionFee)) /
                                                              100)
                                                    });
                                                  } else {
                                                    controller
                                                        .retakePurchaseBillDataList
                                                        .removeWhere((item) =>
                                                            item[
                                                                'order_maseter_id'] ==
                                                            trainingHomeController
                                                                .examFailedTraineeDetails[
                                                                    index]
                                                                .orderMasterId);
                                                  }

                                                  print(controller
                                                      .retakePurchaseBillDataList);

                                                  trainingHomeController
                                                      .update();
                                                },
                                        );
                                      }),
                                    ],
                                  ),

                                  //

                                  SizedBox(
                                    height: 15.w,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: GetBuilder<TrainingControllerHomee>(
          builder: (controller) {
            return elevatedButtonWidget(
              context: context,
              text: 'Continue',
              width: Get.width,
              backgroundColor: ColorResources.colorE5AA17,
              txtColor: ColorResources.colorBlack,
              onPressed: isAnyCheckboxSelected()
                  ? () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                              'Are you sure!\nDo you want to purchase this?',
                              style: GoogleFonts.dmSans(
                                fontSize: 16.sp.h,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            actions: [
                              textButtonWidget(
                                text: 'Yes',
                                onPressed: () {
                                  Get.back();
                                  Get.to(() => const RetakeBillPage());
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
                    }
                  : null,
            );
          },
        ),
      ),
    );
  }
}
