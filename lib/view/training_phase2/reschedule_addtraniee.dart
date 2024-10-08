// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/http/http_urls.dart';
import 'package:darlsco/model/training/get_order_item_model.dart';
import 'package:darlsco/view/training/location_page.dart';
import 'package:darlsco/view/training/trainee_details_page.dart';
import 'package:darlsco/view/training_phase2/view_add_trainee_details_page.dart';
import 'package:darlsco/view/widgets/common_back_button_phase2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddtraineeReschedule extends StatefulWidget {
  final GetOrderItemModelElement orderItem;
  final int orderIndex;

  const AddtraineeReschedule(
      {super.key, required this.orderItem, required this.orderIndex});

  @override
  State<AddtraineeReschedule> createState() => _AddtraineeRescheduleState();
}

class _AddtraineeRescheduleState extends State<AddtraineeReschedule> {
  final trainingHomeController = Get.put(TrainingControllerHomee());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // trainingHomeController.getOrdersItems();
      init();
    });

    super.initState();
  }

  init() async {
    await trainingHomeController.getSpecificOrderDetails(
        orderMasterId: widget.orderItem.orderMasterId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: commonBackgroundLinearColorCart(
          childWidget: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 24.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: InkWell(
                        //     onTap: () {
                        //       Get.back();
                        //     },
                        //     child: CircleAvatar(
                        //       radius: 18.h,
                        //       backgroundColor: ColorResources.colorDBE8FC,
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(left: 8),
                        //         child: Icon(
                        //           Icons.arrow_back_ios,
                        //           size: 30.h,
                        //           color: ColorResources.color294C73,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 30.w),
                        GetBuilder<TrainingControllerHomee>(builder: (data) {
                          return Column(
                            children: List.generate(
                              data.specificOrderDetailList.length,
                              (index) => GetBuilder<TrainingControllerHomee>(
                                  builder: (specificOrderData) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              width: 90,
                                              height: 90.w,
                                              // decoration: BoxDecoration(
                                              //   color: ColorResources.colorD1D1D1,
                                              //   image: DecorationImage(
                                              //     image: NetworkImage('${HttpUrls.imageBase}${specificOrderData.specificOrderDetailList[index].fileName}'),
                                              //     fit: BoxFit.cover,
                                              //   ),
                                              //   borderRadius: BorderRadius.circular(10),
                                              // ),
                                              child: Image.network(
                                                '${HttpUrls.imageBase}${specificOrderData.specificOrderDetailList[index].fileName}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              specificOrderData
                                                  .specificOrderDetailList[
                                                      index]
                                                  .trainingCourseName,
                                              maxLines: 3,
                                              overflow: TextOverflow.visible,
                                              style: TextStyle(
                                                fontSize: 20.sp.h,
                                                color: Color(0xFF294C73),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 8.h,
                                          // ),
                                          Padding(
                                              padding: EdgeInsets.all(8.sp),
                                              child: Table(
                                                border: TableBorder.symmetric(
                                                  outside: BorderSide(
                                                      width: 0,
                                                      color: Colors.white),
                                                ),
                                                columnWidths: {
                                                  0: FlexColumnWidth(
                                                      2), // Adjust column width as needed
                                                  1: FlexColumnWidth(3),
                                                },
                                                children: [
                                                  TableRow(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                                4.0), // Adjust vertical padding
                                                        child: Text(
                                                          'Order No',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF294C73),
                                                            fontSize: 14
                                                                .sp, // Reduced font size
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                                4.0), // Adjust vertical padding
                                                        child: Text(
                                                          specificOrderData
                                                              .specificOrderDetailList[
                                                                  index]
                                                              .orderNo
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 14
                                                                .sp, // Reduced font size
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      SizedBox(
                                                          height:
                                                              8.0), // Reduce height if needed
                                                      SizedBox(
                                                          height:
                                                              8.0), // Reduce height if needed
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                                4.0), // Adjust vertical padding
                                                        child: Text(
                                                          'Category',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF294C73),
                                                            fontSize: 14
                                                                .sp, // Reduced font size
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                                4.0), // Adjust vertical padding
                                                        child: Text(
                                                          specificOrderData
                                                              .specificOrderDetailList[
                                                                  index]
                                                              .categoryName,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 14
                                                                .sp, // Reduced font size
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      SizedBox(
                                                          height:
                                                              8.0), // Reduce height if needed
                                                      SizedBox(
                                                          height:
                                                              8.0), // Reduce height if needed
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                                4.0), // Adjust vertical padding
                                                        child: Text(
                                                          'Quantity',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF294C73),
                                                            fontSize: 14
                                                                .sp, // Reduced font size
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                                4.0), // Adjust vertical padding
                                                        child: Text(
                                                          specificOrderData
                                                              .specificOrderDetailList[
                                                                  index]
                                                              .quantity
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 14
                                                                .sp, // Reduced font size
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GetBuilder<
                                                      TrainingControllerHomee>(
                                                  builder: (orderData) {
                                                return orderData
                                                            .specificOrderDetailList[
                                                                index]
                                                            .orderLocationId !=
                                                        0
                                                    ? Expanded(
                                                        flex: 40,
                                                        child: ElevatedButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Color(
                                                                          0xFFE5AA17)),

                                                              foregroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Color(
                                                                          0xFFE5AA17)),
                                                              shape: MaterialStateProperty
                                                                  .all<
                                                                      RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  side: BorderSide(
                                                                      color: Color(
                                                                          0xFFE5AA17)),
                                                                ),
                                                              ),

                                                              // backgroundColor:
                                                              //     Color(0xFFE5AA17)
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              trainingController
                                                                  .locationCountDetails
                                                                  .clear();
                                                              await trainingController.getLocationsCount(
                                                                  trainingHomeController
                                                                      .specificOrderDetailList[
                                                                          index]
                                                                      .orderDetailsId
                                                                      .toString(),
                                                                  trainingHomeController
                                                                      .specificOrderDetailList[
                                                                          index]
                                                                      .orderLocationId
                                                                      .toString());
                                                              Get.to(() =>
                                                                  LocationPage(
                                                                    orderItem:
                                                                        trainingHomeController
                                                                            .specificOrderDetailList[index],
                                                                  ));
                                                            },
                                                            child: Text(
                                                              "View Location Details",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      12.sp),
                                                            )),
                                                      )
                                                    : Expanded(
                                                        flex: 40,
                                                        child: Container());
                                              }),
                                              Expanded(
                                                  flex: 10, child: SizedBox()),
                                              GetBuilder<
                                                      TrainingControllerHomee>(
                                                  builder: (controller) {
                                                return controller
                                                            .specificOrderDetailList[
                                                                index]
                                                            .statusId !=
                                                        1
                                                    ? Container()
                                                    : Expanded(
                                                        flex: 40,
                                                        child: ElevatedButton(
                                                            onPressed:
                                                                // tcontoller
                                                                //                 .isTraineeAdded
                                                                //                 .value ==
                                                                //             true ||
                                                                () async {
                                                              await trainingController.getAddedTraineeDetails(
                                                                  trainingHomeController
                                                                      .specificOrderDetailList[
                                                                          index]
                                                                      .orderDetailsId
                                                                      .toString());
                                                              Get.to(() =>
                                                                  ViewAddTraineeDetailsPage(
                                                                    orderItem:
                                                                        trainingHomeController
                                                                            .specificOrderDetailList[index],
                                                                  ));
                                                              trainingHomeController
                                                                  .update();
                                                            },
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Color(
                                                                          0xFF0950A0)),

                                                              foregroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Color(
                                                                          0xFF0950A0)),
                                                              shape: MaterialStateProperty
                                                                  .all<
                                                                      RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  side: BorderSide(
                                                                      color: Color(
                                                                          0xFF0950A0)),
                                                                ),
                                                              ),

                                                              // backgroundColor:
                                                              //     Color(0xFFE5AA17)
                                                            ),

                                                            // ElevatedButton.styleFrom(
                                                            //     backgroundColor:
                                                            //         Color(0xFF0950A0)),
                                                            child: Text(
                                                                "View Trainee Details",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize: 12
                                                                        .sp))),
                                                      );
                                              }),
                                              GetBuilder<
                                                      TrainingControllerHomee>(
                                                  builder: (controller) {
                                                return controller
                                                            .specificOrderDetailList[
                                                                index]
                                                            .statusId !=
                                                        1
                                                    ? Expanded(
                                                        flex: 5,
                                                        child: SizedBox())
                                                    : Container();
                                              }),
                                              GetBuilder<
                                                  TrainingControllerHomee>(
                                                builder: (controller) {
                                                  print(
                                                      'add trainee rebuilding ${controller.specificOrderDetailList}  ${controller.specificOrderDetailList[index].statusId}  ');
                                                  return controller
                                                              .specificOrderDetailList[
                                                                  index]
                                                              .statusId
                                                              .toString() ==
                                                          '1'
                                                      ? Expanded(
                                                          // flex: 10,

                                                          child: Container())
                                                      : Expanded(
                                                          flex: 40,
                                                          child: ElevatedButton(
                                                              onPressed:
                                                                  // tcontoller
                                                                  //                 .isTraineeAdded
                                                                  //                 .value ==
                                                                  //             true ||
                                                                  () async {
                                                                await trainingHomeController.getSpecificOrderDetails(
                                                                    orderMasterId: widget
                                                                        .orderItem
                                                                        .orderMasterId
                                                                        .toString());
                                                                print(
                                                                    'index $index');
                                                                Get.to(() =>
                                                                    TraineeDetailsPage(
                                                                      orderItem:
                                                                          controller
                                                                              .specificOrderDetailList[index],
                                                                      previousPageSetState:
                                                                          setState,
                                                                    ));
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all<
                                                                            Color>(
                                                                  Color(
                                                                      0xFF0B8900),
                                                                ),

                                                                foregroundColor:
                                                                    MaterialStateProperty
                                                                        .all<
                                                                            Color>(
                                                                  Color(
                                                                      0xFF0B8900),
                                                                ),
                                                                shape: MaterialStateProperty
                                                                    .all<
                                                                        RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                    side:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0xFF0B8900),
                                                                    ),
                                                                  ),
                                                                ),

                                                                // backgroundColor:
                                                                //     Color(0xFFE5AA17)
                                                              ),

                                                              // ElevatedButton.styleFrom(
                                                              //     backgroundColor:
                                                              //         Color(0xFF0950A0)),
                                                              child: Text(
                                                                  "Add Trainee Details",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12.sp))),
                                                        );
                                                },
                                              ),

                                              // Obx(
                                              //   () => ,
                                              // ),
                                              // GetBuilder(
                                              //     init: trainingController,
                                              //     builder: (context) {
                                              //       return
                                              //     }),
                                              // Expanded(
                                              //   flex: 10,
                                              //   child: SizedBox())
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              commonBackButton()
            ],
          ),
        ),
      ),
    );
  }
}
