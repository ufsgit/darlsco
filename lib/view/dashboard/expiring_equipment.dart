import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../controller/home/home_controller.dart';
import '../../core/constants/color_resources.dart';
import '../../core/constants/common_widgets.dart';

class ExpiringEquipmentScreen extends StatefulWidget {
  const ExpiringEquipmentScreen({super.key});

  @override
  State<ExpiringEquipmentScreen> createState() =>
      _ExpiringEquipmentScreenState();
}

class _ExpiringEquipmentScreenState extends State<ExpiringEquipmentScreen> {
  bool isScreenLoading = false;
  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      setState(() {
        isScreenLoading = true;
      });
      await homeController.searchExpiringInspections(
          context: Get.context, isfromSplashScreen: false);
    } finally {
      setState(() {
        isScreenLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = homeController.isCalibrationSection.value
        ? homeController.customerEquipmentExpiringDataCalibration
        : homeController.customerEquipmentExpiringData;

    return GetBuilder<HomeController>(builder: (_) {
      if (homeController.isCalibrationSection.value) {
        if (homeController.equipmentCheckValue.isEmpty ||
            homeController.equipmentCheckValue.length !=
                homeController
                    .customerEquipmentExpiringDataCalibration.length) {
          homeController.equipmentCheckValue = List.generate(
              homeController.customerEquipmentExpiringDataCalibration.length,
              (index) => false);
          print(
              'jiwefiw ${homeController.customerEquipmentExpiringDataCalibration.length}');
        }
      } else {
        if (homeController.equipmentCheckValue.isEmpty ||
            homeController.equipmentCheckValue.length !=
                homeController.customerEquipmentExpiringData.length) {
          homeController.equipmentCheckValue = List.generate(
              homeController.customerEquipmentExpiringData.length,
              (index) => false);
          print(
              'jiwefiw ${homeController.customerEquipmentExpiringData.length}');
        }
      }
      return Scaffold(
        // drawer: const Drawer(),
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
                    homeController.initfunction();
                    homeController.update();
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              // leading: Builder(builder: (ctx) {
              //   return customDrawerIcon(context: ctx);
              // }),
              backgroundColor: ColorResources.colorTransparent,
            ))),

        bottomNavigationBar: data.isEmpty
            ? const SizedBox()
            : InkWell(
                onTap: () {
                  if (homeController.equipmentListCustomer.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Select atleast one equipment name!')));
                  } else {
                    homeController.saveCustomerRequest(
                        context: context, ispostdataExpiring: true);
                  }

                  // print(homeController.equipmentListCustomer.map((e) => e).toList());
                },
                child: Container(
                  height: 60.h,
                  color: ColorResources.colorE5AA17,
                  child: Center(
                      child: Text(
                    homeController.isCalibrationSection.value
                        ? 'Calibration Request'
                        : 'Inspection Request',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  )),
                ),
              ),
        body: commonBackgroundLinearColorHome(
          childWidget: Container(
              padding: EdgeInsets.all(15.sp),
              width: Get.width,
              child: RefreshIndicator(
                onRefresh: () => getData(),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'Expiring',
                            style: GoogleFonts.roboto(
                                color: ColorResources.color294C73,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: ' Equipments',
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

                        GetBuilder<HomeController>(builder: (_) {
                          return Column(
                            mainAxisAlignment: homeController
                                    .isCalibrationSection.value
                                ? homeController
                                        .customerEquipmentExpiringDataCalibration
                                        .isEmpty
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start
                                : homeController
                                        .customerEquipmentExpiringData.isEmpty
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
                            children: isScreenLoading
                                ? [
                                    Container(
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                2,
                                        child: Center(child: CircularProgressIndicator()))
                                  ]
                                : data.isEmpty
                                    ? [
                                        SizedBox(
                                            height: 500.h,
                                            child: const Center(
                                                child: Text(
                                              'No equipment has expired!',
                                              textAlign: TextAlign.center,
                                            )))
                                      ]
                                    : List.generate(
                                        data.length,
                                        (index) => InkWell(
                                          // onTap: () {
                                          //   print(
                                          //       'djkfns ${homeController.equipmentCheckValue}');
                                          //   // homeController.selectingEquipment(homeController
                                          //   //     .customerEquipmentData[index].equipmentName);
                                          // },
                                          child: Container(
                                            width: Get.width,
                                            // height: 179.h,
                                            margin: EdgeInsets.only(top: 15.h),
                                            padding: EdgeInsets.only(
                                                left: 15.sp,
                                                right: 15.sp,
                                                top: 15.sp),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        6.sp)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width > 615
                                                          ? 550.w
                                                          : 200.w,
                                                      child: Text(
                                                        data[index]
                                                            .equipmentName,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontFamily: "DM Sans",
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: ColorResources
                                                              .color294C73,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    data[index].statusId ==
                                                                11 ||
                                                            data[index]
                                                                    .statusId ==
                                                                0
                                                        ? GetBuilder<
                                                                HomeController>(
                                                            builder: (hdata) {
                                                            return Checkbox(
                                                                value: hdata
                                                                        .equipmentCheckValue[
                                                                    index],
                                                                onChanged:
                                                                    (value) {
                                                                  hdata.equipmentCheckValue[
                                                                          index] =
                                                                      value!;
                                                                  homeController
                                                                      .selectingEquipment({
                                                                    'Equipment_Id':
                                                                        data[index]
                                                                            .equipmentId,
                                                                    'Equipment_Name':
                                                                        data[index]
                                                                            .equipmentName
                                                                  }, value);
                                                                });
                                                          })
                                                        : Text(
                                                            !homeController.isCalibrationSection
                                                                            .value &&
                                                                        data[index].statusId ==
                                                                            12 ||
                                                                    homeController
                                                                            .isCalibrationSection
                                                                            .value &&
                                                                        data[index].statusId ==
                                                                            16
                                                                ? 'Requested'
                                                                : data[index]
                                                                    .statusName,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize:
                                                                    12.sp),
                                                          )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 18.h,
                                                ),

                                                // Column(children: [
                                                //   // equipmentCommonItemWidget(
                                                //   //   keyText: 'Location',
                                                //   //   valueText: equipmentListController.equipmentListData[index]['location'],
                                                //   // ),
                                                //   // equipmentCommonItemWidget(
                                                //   //   keyText: 'Make',
                                                //   //   valueText: homeController
                                                //   //       .customerEquipmentData[index]
                                                //   //       .equipmentMake,
                                                //   // ),
                                                //   // equipmentCommonItemWidget(
                                                //   //   keyText: 'Model',
                                                //   //   valueText: homeController
                                                //   //       .customerEquipmentData[index]
                                                //   //       .equipmentModel,
                                                //   // ),
                                                //   // equipmentCommonItemWidget(
                                                //   //   keyText: 'Serial No',
                                                //   //   valueText: homeController
                                                //   //       .customerEquipmentData[index].serialNo,
                                                //   // ),
                                                //   // equipmentCommonItemWidget(
                                                //   //   keyText: 'Expiring Date',
                                                //   //   valueText: homeController
                                                //   //       .customerEquipmentData[index]
                                                //   //       .experingDate,
                                                //   // ),
                                                // ]),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Expiring In",
                                                      style: TextStyle(
                                                        fontFamily: "DM Sans",
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: ColorResources
                                                            .color294C73,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Text(
                                                      int.parse(data[index]
                                                                  .experingIn
                                                                  .toString()) <
                                                              0
                                                          ? 'Expired'
                                                          : int.parse(data[
                                                                          index]
                                                                      .experingIn
                                                                      .toString()) ==
                                                                  0
                                                              ? 'Today'
                                                              : '${data[index].experingIn} Days',
                                                      style: TextStyle(
                                                        fontFamily: "DM Sans",
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: ColorResources
                                                            .color294C73,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 15.h,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                          );
                        }),

                        // Expanded(
                        //   child: ListView.separated(
                        //       itemCount: 3,
                        //       separatorBuilder: (context, index) => SizedBox(
                        //             height: 10.h,
                        //           ),
                        //       itemBuilder: (context, index) {
                        //         return Container(
                        //           padding: EdgeInsets.all(15.sp),
                        //           width: 367.w,
                        //           // height: 83.h,
                        //           decoration: BoxDecoration(
                        //               color: ColorResources.whiteColor,
                        //               borderRadius: BorderRadius.circular(16.sp)),
                        //           child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 SizedBox(
                        //                   width: 17.w,
                        //                 ),
                        //                 Text(
                        //                   'Bending Machine',
                        //                   style: TextStyle(
                        //                       fontSize: 16.sp,
                        //                       fontWeight: FontWeight.w700,
                        //                       color: ColorResources.color294C73),
                        //                 ),
                        //                 SizedBox(
                        //                   height: 14.h,
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       "Expiring In",
                        //                       style: TextStyle(
                        //                         fontFamily: "DM Sans",
                        //                         fontSize: 13.sp,
                        //                         fontWeight: FontWeight.w500,
                        //                         color: ColorResources.color294C73,
                        //                       ),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                    Text(
                        //                       "200 Days",
                        //                       style: TextStyle(
                        //                         fontFamily: "DM Sans",
                        //                         fontSize: 13.sp,
                        //                         fontWeight: FontWeight.w500,
                        //                         color: ColorResources.color294C73,
                        //                       ),
                        //                       textAlign: TextAlign.left,
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ]),
                        //         );
                        //       }),
                        // ),
                      ]),
                ),
              )),
        ),
      );
    });
  }
}
