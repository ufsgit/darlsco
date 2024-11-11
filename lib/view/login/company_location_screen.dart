import 'package:darlsco/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_resources.dart';
import '../../core/constants/common_widgets.dart';

class CompanyLocationScreen extends StatelessWidget {
  CompanyLocationScreen({super.key});
  final HomeController homeController = Get.put(HomeController());

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
                icon: const Icon(Icons.arrow_back_ios_new)),
            backgroundColor: ColorResources.colorTransparent,
          ))),
      body: commonBackgroundLinearColorHome(
        childWidget: Container(
            padding: EdgeInsets.all(15.sp),
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Company',
                  style: GoogleFonts.roboto(
                      color: ColorResources.color294C73,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: ' Locations',
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
              homeController.customerLocations.isEmpty
                  ? SizedBox(
                      height: 600.h,
                      child: const Center(
                          child: Text(
                        'No locations are currently available. They will be added soon. For assistance, contact the team!',
                        textAlign: TextAlign.center,
                      )),
                    )
                  : Expanded(
                      child: ListView.separated(
                          itemCount: homeController.customerLocations.length,
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10.h,
                              ),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(15.sp),
                              width: 367.w,
                              // height: 83.h,
                              decoration: BoxDecoration(
                                  color: ColorResources.whiteColor,
                                  borderRadius: BorderRadius.circular(16.sp)),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 80,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 20.sp,
                                            color: ColorResources.color294C73,
                                          ),
                                          SizedBox(
                                            width: 17.w,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        600 &&
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        1440
                                                ? 400.w
                                                : 200.w,
                                            child: Text(
                                              homeController
                                                  .customerLocations[index]
                                                  .locationName,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorResources
                                                      .color294C73),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 20,
                                      child: IconButton(
                                        onPressed: () {
                                          homeController
                                                  .isCalibrationSection.value
                                              ? homeController
                                                  .getEquipmentsCalibration(
                                                      context,
                                                      homeController
                                                          .customerLocations[
                                                              index]
                                                          .locationId,
                                                      isFromLocationScreen:
                                                          true)
                                              : homeController
                                                  .getCustomerEquipments(
                                                      context,
                                                      homeController
                                                          .customerLocations[
                                                              index]
                                                          .locationId,
                                                      isFromLocationScreen:
                                                          true);
                                        },
                                        icon: Container(
                                          width: 100.w,
                                          height: 32.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                              color: ColorResources.colorDCCCFF,
                                              borderRadius:
                                                  BorderRadius.circular(43.sp)),
                                          child: Center(
                                              child: Text(
                                            'view',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 14.h,
                                ),
                                //   Row(
                                //     children: [
                                //       Icon(Icons.build_outlined, size: 20.sp,color: ColorResources.color294C73,),

                                //         SizedBox(width: 17.w,),
                                //       Text(
                                //        loginController.companyEquipmentList[index],
                                //         style: TextStyle(fontSize: 13.sp),
                                //       ),
                                //     ],
                                //   ),
                              ]),
                            );
                          }),
                    ),
            ])),
      ),
    );
  }
}
