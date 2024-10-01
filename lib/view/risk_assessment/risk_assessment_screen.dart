
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/risk_assessment/risk_assessment_controller.dart';
import 'risk_assessment_stop_screen.dart';

class RiskAssessmentScreen extends StatefulWidget {
  const RiskAssessmentScreen({super.key});

  @override
  State<RiskAssessmentScreen> createState() => _RiskAssessmentScreenState();
}

class _RiskAssessmentScreenState extends State<RiskAssessmentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    riskAssessmentController.initFun();
    super.initState();
  }

  final RiskAssessmentController riskAssessmentController =
      Get.put(RiskAssessmentController());


  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        bottomNavigationBar: Container(
          height: 50.h,
          color: ColorResources.colorE5AA17,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => const RiskAssesmentStopScreen());
                },
                child: Container(
                  width: 220.w,
                  height: 60.h,
                  color: const Color(0xffFFF1CD),
                  child: Center(
                      child: Text(
                    "Skip",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.color0d0d0d,
                    ),
                  )),
                ),
              ),
              InkWell(
                splashColor: Colors.black,
                onLongPress: () {},
                onTap: () {
                  print(
                      'first data ${riskAssessmentController.getPostDataRiskSection1()}');

                  riskAssessmentController.saveTaskRiskAssistants(
                      postBodyData:
                          riskAssessmentController.getPostDataRiskSection1());

                  // upcomingInspectionsController.saveTaskTest(context: context);
                },
                child: Container(
                  margin: EdgeInsets.all(5.sp),
                  width: Get.width > 615 ? 600.w : 160.w,
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorResources.color0d0d0d,
                        height: 14.9767427444458 / 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: RiskAssesmentBodyWidget(
            riskAssessmentController: riskAssessmentController));
  }
}

class RiskAssesmentBodyWidget extends StatefulWidget {
  const RiskAssesmentBodyWidget({
    super.key,
    required this.riskAssessmentController,
  });

  final RiskAssessmentController riskAssessmentController;

  @override
  State<RiskAssesmentBodyWidget> createState() =>
      _RiskAssesmentBodyWidgetState();
}

class _RiskAssesmentBodyWidgetState extends State<RiskAssesmentBodyWidget> {
  // @override
  // void initState() {
  //   riskAssessmentController.initFun();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(18.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Risk Assessment",
              style: TextStyle(
                fontFamily: "DM Sans",
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: ColorResources.color294C73,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.h,
            ),
            ExpansionListTaskAssessment(
                riskAssessmentController: widget.riskAssessmentController),
            SizedBox(
              height: 15.h,
            ),
            // commonNoteWidget(isbtton: false),
          ],
        ),
      ),
    );
  }
}

class ExpansionListTaskAssessment extends StatelessWidget {
  const ExpansionListTaskAssessment({
    super.key,
    required this.riskAssessmentController,
  });

  final RiskAssessmentController riskAssessmentController;

  @override
  Widget build(BuildContext context) {
    return Theme(
       data: ThemeData(
                        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
                     

                      ),
      child: ExpansionTileGroup(
        spaceBetweenItem: 12.h,
        toggleType: ToggleType.expandOnlyCurrent,
        children: List.generate(
            riskAssessmentController.assessmentList.length,
            (mIndex) => ExpansionTileItem(
                    trailing: const Icon(Icons.arrow_drop_down),
                    collapsedBackgroundColor: const Color(0xffE5F1FF),
                    backgroundColor: Colors.white,
                    title: Text(
                      riskAssessmentController.assessmentList[mIndex],
                    ),
                    children: [
                      Theme(
                         data: ThemeData(
                        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                     

                      ),
                        child: ExpansionTileGroup(
                          
                            spaceBetweenItem: 12.h,
                            toggleType: ToggleType.expandOnlyCurrent,
                            children: List.generate(
                              riskAssessmentController
                                  .subAssessmentLIst[mIndex].length,
                              (subIndex) => ExpansionTileItem(
                                onExpansionChanged: (value) {
                                  riskAssessmentController.isExpanded.value = value;
                                },
                                trailing: const Icon(Icons.arrow_drop_down),
                                collapsedBackgroundColor: const Color(0xffE5F1FF),
                                backgroundColor: Colors.white,
                                title: Text(
                                  riskAssessmentController.subAssessmentLIst[mIndex]
                                      [subIndex],
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    // color: ColorResources.color294C73,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                expendedBorderColor: Colors.red,
                                children: [
                                  RiskassessmentFormWidget(
                                      mIndex: mIndex,
                                      subIndex: subIndex,
                                      riskAssessmentController:
                                          riskAssessmentController)
                                ],
                              ),
                             
                            )),
                      ),
                    ])),
      ),
    );
  }
}

class RiskassessmentFormWidget extends StatelessWidget {
  const RiskassessmentFormWidget({
    super.key,
    required this.riskAssessmentController,
    required this.mIndex,
    required this.subIndex,
  });
  final int subIndex;
  final int mIndex;
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RiskAssessmentController riskAssessmentController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: ColorResources.colorBlue))),
      child: Form(
          // key: formKey,
          child: Column(
        children: [
          Wrap(
            spacing: 20.w,
            runSpacing: 20.h,
            children: List.generate(
              riskAssessmentController.textFieldTitles.length,
              (index) => CustomTextField(
                titleText: riskAssessmentController.textFieldTitles[index],
                txtController: riskAssessmentController
                    .riskAssessmentControllerList[mIndex][subIndex][index],
                maxLength: riskAssessmentController.textfieldMaxLength[index],
                keyboardType:
                    riskAssessmentController.textfieldKeyboardType[index],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.titleText,
      required this.txtController,
      this.maxLength = 50,
      this.keyboardType});

  final int maxLength;

  final TextInputType? keyboardType;

  final String titleText;
  final TextEditingController txtController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: ColorResources.color294C73,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
            width: 350.w,
            child: TextFormField(
              maxLength: maxLength,
              keyboardType: keyboardType,
              onChanged: (value) {
                print(riskAssessmentController
                    .physicalNoiseRiskDescriptionController.text);
              },
              controller: txtController,
              style: const TextStyle(fontSize: 14),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(2)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2))),
            )),
      ],
    );
  }
}
