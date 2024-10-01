import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DocumentationPage extends StatefulWidget {
  const DocumentationPage({super.key});

  @override
  State<DocumentationPage> createState() => _DocumentationPageState();
}

class _DocumentationPageState extends State<DocumentationPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      trainingController.getCategoryDocumentation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: commonBackgroundLinearColorCart(
          childWidget: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: ColorResources.color294C73,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          trainingController.categoryEligibilityDetails.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: ColorResources.whiteColor,
                            ),
                            child: ExpansionTile(
                              title: Text(
                                trainingController
                                    .categoryEligibilityDetails[index]
                                    .categoryName,
                                style: TextStyle(
                                    color: ColorResources.color294C73,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Required Documents',
                                        style: TextStyle(
                                            color: ColorResources.colorBlack,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      textAlign: TextAlign.justify,
                                      trainingController
                                          .categoryEligibilityDetails[index]
                                          .requiredDocuments,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Eligibility Criteria',
                                        style: TextStyle(
                                            color: ColorResources.colorBlack,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      textAlign: TextAlign.justify,
                                      trainingController
                                          .categoryEligibilityDetails[index]
                                          .eligibilityCriteria,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
