import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SampleEquipmentScreen extends StatelessWidget {
  const SampleEquipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton.filledTonal(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.grey.shade300)),
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.keyboard_arrow_left_outlined),
        ),
        title: Text('Equipment List'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.sp),
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Equipment',
                  style: GoogleFonts.roboto(
                      color: ColorResources.color294C73,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: ' List',
                  style: GoogleFonts.roboto(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w700,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = ColorResources.color294C73,
                  ),
                ),
              ])),
              SizedBox(
                height: 44.h,
              ),
              Wrap(
                spacing: 15.w,
                runSpacing: 15.h,
                children: List.generate(
                  homeController.customerEquipmentData.length,
                  (index) => InkWell(
                    // onTap: () {
                    //   homeController.selectingEquipment(homeController
                    //       .customerEquipmentData[index].equipmentName);
                    // },
                    child: Container(
                      width: 367.w,
                      // height: 179.h,
                      margin: EdgeInsets.only(top: 15.h),
                      padding: EdgeInsets.only(
                          left: 15.sp, right: 15.sp, top: 15.sp),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.sp)),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.handyman,
                              color:
                                  ColorResources.color294C73.withOpacity(0.10),
                              size: 100.sp,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200.w,
                                    child: Text(
                                      homeController
                                          .customerEquipmentData[index]
                                          .equipmentName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: "DM Sans",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: ColorResources.color294C73,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  GetBuilder<HomeController>(builder: (data) {
                                    return data.customerEquipmentData[index]
                                                    .statusId
                                                    .toString() ==
                                                '11' ||
                                            data.customerEquipmentData[index]
                                                    .statusId
                                                    .toString() ==
                                                '0'
                                        ? Checkbox(
                                            value:
                                                data.equipmentCheckValue[index],
                                            onChanged: (value) {
                                              data.equipmentCheckValue[index] =
                                                  value!;
                                              homeController
                                                  .selectingEquipment({
                                                'Equipment_Id': data
                                                    .customerEquipmentData[
                                                        index]
                                                    .equipmentId,
                                                'Equipment_Name': data
                                                    .customerEquipmentData[
                                                        index]
                                                    .equipmentName
                                              }, value);
                                            })
                                        : Text(
                                            data.customerEquipmentData[index]
                                                        .statusId
                                                        .toString() ==
                                                    '12'
                                                ? 'Requested'
                                                : data
                                                    .customerEquipmentData[
                                                        index]
                                                    .statusName,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12.sp),
                                          );
                                  }),
                                ],
                              ),
                              SizedBox(
                                height: 18.h,
                              ),
                              Column(children: [
                                equipmentCommonItemWidget(
                                  keyText: 'Equipment Type',
                                  valueText: homeController
                                      .customerEquipmentData[index]
                                      .equipmentType,
                                ),
                                equipmentCommonItemWidget(
                                  keyText: 'Expiring Date',
                                  valueText: homeController
                                      .customerEquipmentData[index]
                                      .experingDate,
                                ),
                                equipmentCommonItemWidget(
                                  keyText: 'Make',
                                  valueText: homeController
                                      .customerEquipmentData[index]
                                      .equipmentMake,
                                ),
                                equipmentCommonItemWidget(
                                  keyText: 'Model',
                                  valueText: homeController
                                      .customerEquipmentData[index]
                                      .equipmentModel,
                                ),
                                equipmentCommonItemWidget(
                                  keyText: 'Serial No',
                                  valueText: homeController
                                      .customerEquipmentData[index].serialNo,
                                ),
                                equipmentCommonItemWidget(
                                  keyText: 'Description',
                                  valueText: homeController
                                      .customerEquipmentData[index].description,
                                ),
                              ]),
                              SizedBox(
                                height: 15.h,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Container(
        color: AppColors.primaryBlue,
        child: IconButton(
          padding: EdgeInsets.all(5.w),
          onPressed: () {
            if (homeController.equipmentListCustomer.isNotEmpty) {
              Get.back();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'Select at least one equipment detail to continue!')));
            }
          },
          icon: SizedBox(
            height: 50.h,
            // color: ColorResources.colorE5AA17,
            child: Center(
                child: Text(
              "Continue",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 14.9767427444458 / 20,
              ),
              textAlign: TextAlign.center,
            )),
          ),
        ),
      ),
    );
  }

  equipmentCommonItemWidget(
      {required String keyText, required String valueText}) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              keyText,
              style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorResources.color294C73),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          SizedBox(
            width: 190.w,
            child: Text(
              valueText,
              style: TextStyle(
                fontFamily: "DM Sans",
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff51688a),
              ),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}
