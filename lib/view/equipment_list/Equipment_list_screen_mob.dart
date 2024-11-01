import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/view/equipment_list/equipment_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_resources.dart';
import '../../core/constants/common_widgets.dart';
import '../home/bottom_navigation_screen.dart';

class EquipmentListScreenMob extends StatelessWidget {
  const EquipmentListScreenMob({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(70.w, 70.h),
          child: commonBackgroundLinearColor(
              childWidget: AppBar(
            leading: IconButton(
                onPressed: () {
                  homeController.inspectionDropdownValue.value = '';
                  homeController.equipmentListCustomer = {};
                  homeController.inspectionDateController.clear();
                  homeController.inspectionMessageController.clear();
                  homeController.isChooseEquipment.value = false;
                  homeController.update();

                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            backgroundColor: ColorResources.colorTransparent,
          ))),
      body: commonBackgroundLinearColorHome(
        childWidget: Container(
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
                    GetBuilder<HomeController>(builder: (eqData) {
                      List equipmentData =eqData.isCalliberationSection.value?eqData.customerEquipmentDataCalliberation:eqData.customerEquipmentData;
                      print('dfgwr4tiow4oi4wroi kk${eqData.isCalliberationSection.value}');
                      print('dfgwr4tiow4oi4wroi kk oop ${eqData.customerEquipmentDataCalliberation}');
                      print('dfgwr4tiow4oi4wroi $equipmentData');
                      return Wrap(
                        children:equipmentData.isEmpty
                            ? [
                                SizedBox(
                                  height: 500.h,
                                  child: const Center(
                                    child: Text(
                                      'No equipments are currently available. They will be added soon. For assistance, contact the team!',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ]
                            : List.generate(
                               equipmentData.length,
                                (index) => Container(
                                  width: Get.width > 615 ? 380.w : 367.w,

                                  // height: 179.h,
                                  margin: EdgeInsets.only(top: 15.h),
                                  padding: EdgeInsets.only(
                                      left: 15.sp, right: 15.sp, top: 15.sp),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(6.sp)),
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Icon(
                                        Icons.handyman_outlined,
                                        color: ColorResources.color294C73
                                            .withOpacity(0.10),
                                        size: 100.sp,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              
                                                  equipmentData[index]
                                                  .equipmentName,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: "DM Sans",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorResources.color294C73,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 18.h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 50,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    equipmentCommonItemWidget(
                                                        keyText: 'Location',
                                                        valueText: 
                                                            equipmentData[
                                                                index]
                                                            .location),
                                                    equipmentCommonItemWidget(
                                                      keyText: 'Equipment Type',
                                                      valueText: 
                                                          equipmentData[
                                                              index]
                                                          .equipmentType,
                                                    ),
                                                    equipmentCommonItemWidget(
                                                      keyText: 'Expiring Date',
                                                      valueText: 
                                                          equipmentData[
                                                              index]
                                                          .experingDate,
                                                    ),
                                                    equipmentCommonItemWidget(
                                                      keyText: 'Make',
                                                      valueText: 
                                                          equipmentData[
                                                              index]
                                                          .equipmentMake,
                                                    ),
                                                    equipmentCommonItemWidget(
                                                      keyText: 'Model',
                                                      valueText: 
                                                          equipmentData[
                                                              index]
                                                          .equipmentModel,
                                                    ),
                                                    equipmentCommonItemWidget(
                                                      keyText: 'Serial No',
                                                      valueText: 
                                                          equipmentData[
                                                              index]
                                                          .serialNo,
                                                    ),
                                                    equipmentCommonItemWidget(
                                                      keyText: 'Description',
                                                      valueText:equipmentData[
                                                              index]
                                                          .description,
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    // equipmentCommonItemWidget(
                                                    //   keyText: 'status',
                                                    //   valueText: eqData
                                                    //       .equipmentData[
                                                    //           index]
                                                    //       .statusName,
                                                    // ),
                                                    Text(
                                                      
                                                                  equipmentData[
                                                                      index]
                                                                  .statusId
                                                                  .toString() ==
                                                              '11'
                                                          ? 'Inspection Finished'
                                                          : 
                                                              equipmentData[
                                                                  index]
                                                              .statusName,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12.sp),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ElevatedButton(
                                              child: const Text('View'),
                                              onPressed: () => Get.to(
                                                  () => EquipmentDetailScreen(
                                                        equipmentId: equipmentData[
                                                                index]
                                                            .equipmentId
                                                            .toString(),
                                                      )),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      );
                    })
                  ]),
            )),
      ),
    );
  }

  equipmentCommonItemWidget(
      {required String keyText, required String valueText}) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              SizedBox(
                width: 120.w,
                child: Text(
                  keyText,
                  style: TextStyle(
                      fontFamily: "DM Sans",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.color294C73),
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: 179.w,
              child: Text(
                valueText,
                overflow: Get.width > 615 ? TextOverflow.ellipsis : null,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff51688a),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          )
        ],
      ),
    );
  }
}
