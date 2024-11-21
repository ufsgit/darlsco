import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/exam_failed_list_page.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExamFailedPage extends StatefulWidget {
  const ExamFailedPage({super.key});

  @override
  State<ExamFailedPage> createState() => _ExamFailedPageState();
}

class _ExamFailedPageState extends State<ExamFailedPage> {
  final trainingHomeController = Get.put(TrainingControllerHomee());
  
  @override
  void initState() {
    print('exam failed page');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      trainingHomeController.getFaildDetails();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GetBuilder(
              init: trainingHomeController,
              builder: (context) {
                return commonBackgroundLinearColorCart(
                  childWidget: SingleChildScrollView(
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
                          //   child: Icon(
                          //     Icons.arrow_back,
                          //     size: 30.h,
                          //     color: ColorResources.color294C73,
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
                          trainingHomeController.examFailDetails.isNotEmpty
                              ? ListView.separated(
                                  itemCount: trainingHomeController
                                      .examFailDetails.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 16,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () async {
                                          await trainingHomeController
                                              .getExamFailedOrderDetails(
                                                  orederId:
                                                      trainingHomeController
                                                          .examFailDetails[
                                                              index]
                                                          .orderMasterId);
                                          Get.to(() => const ExamFailedListPage(
                                              // examFailDetailsModel:
                                              //     trainingHomeController
                                              //         .examFailDetails[index],
                                              ));
                                        },
                                        child: examFailedWidget(
                                          textColor: ColorResources.colorBlack,
                                          courseName: trainingHomeController
                                              .examFailDetails[index]
                                              .customerName,
                                          categoryName:
                                              trainingHomeController.examFailDetails[index].orderNo,
                                          amount:
                                              trainingHomeController.examFailDetails[index].orderDate,
                                          context: context,
                                          onTap: () {},
                                        ));
                                  },
                                )
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height / 2.5,
                                    ),
                                    Center(
                                      child: Text(
                                        'No Failed Trainees',
                                        style: GoogleFonts.dmSans(
                                          color: ColorResources.color294C73,
                                          fontSize: 14.sp.h,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 16.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
