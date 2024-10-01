// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/view/training/training_home_screen.dart';
import 'package:darlsco/view/training/widgets/bottom_navigation_widget.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OrderedSuccessfully extends StatefulWidget {
  const OrderedSuccessfully(
      {super.key,
      required this.isPayment,
      required this.isRetake,
      required this.orderMasterId});
  final isPayment;
  final isRetake;
  final orderMasterId;

  @override
  State<OrderedSuccessfully> createState() => _OrderedSuccessfullyState();
}

class _OrderedSuccessfullyState extends State<OrderedSuccessfully> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // await trainingHomeController.getItemCart();

      if (widget.isRetake) {
        trainingHomeController.saveTraineeRetake(
            tcontoller.isPaymentSuccessful.value == true ? 2 : 1,
            tcontoller.totalPrice,
            widget.orderMasterId);
        log('/////////////////orderfailed>>>>>>>>>>>>>>');
      } else {
        log('/////////////////cartDATA>>>>>>>>>>>>>>${trainingHomeController.cartPriceList.length}');
        await globalHomeController.postPurchaseOrder();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  widget.isPayment == true
                      ? Container(
                          height: 190,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: Color(0xFFD8EAFF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(100),
                            ),
                          ),
                          child: Lottie.asset(
                            'assets/lottie/Animation - 1717738951252.json',
                            width: 100,
                            height: 100,
                          ),
                        )
                      : Container(
                          height: 190,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: Color(0xFFD8EAFF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(100),
                            ),
                          ),
                          child: Lottie.asset(
                            'assets/lottie/Animation - 1717738882759.json',
                            width: 100,
                            height: 100,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tcontoller.isPaymentSuccessful.value == true
                          ? "Order placed successfully"
                          : 'Order failed',
                      style: TextStyle(
                          fontSize: 25.sp,
                          color: Color(0xFF294C73),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  if (widget.isPayment == true)
                    AutoSizeText(
                      'Your request has been processed successfully\nThank you!',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF294C73),
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // height: 300,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color.fromARGB(255, 126, 183, 249)),
                          color: Color.fromARGB(255, 236, 246, 255)),
                      child: Column(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         "Total",
                          //         style: TextStyle(
                          //             fontSize: 16.sp,
                          //             fontWeight: FontWeight.w600,
                          //             color: Color(0xFF294C73)),
                          //       ),
                          //       Text(
                          //         "AED ${tcontoller.grandTotal}",
                          //         style: TextStyle(
                          //             fontSize: 16.sp,
                          //             fontWeight: FontWeight.w600,
                          //             color: Color(0xFF0950A0)),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         "Tax(10%)",
                          //         style: TextStyle(
                          //             fontSize: 16.sp,
                          //             fontWeight: FontWeight.w600,
                          //             color: Color(0xFF294C73)),
                          //       ),
                          //       Text(
                          //         "AED 385",
                          //         style: TextStyle(
                          //             fontSize: 16.sp,
                          //             fontWeight: FontWeight.w600,
                          //             color: Color(0xFF0950A0)),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Card No",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF294C73)),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/visa.png",
                                      height: 40.h,
                                      width: 40.w,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "******${tcontoller.cardNumber}",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF0950A0)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF294C73)),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "AED ${tcontoller.totalPrice.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFE5AA17)),
                                        ),
                                        // Container(
                                        //   height: 25.h,
                                        //   width: 70.w,
                                        //   decoration: BoxDecoration(
                                        //       borderRadius:
                                        //           BorderRadius.circular(10),
                                        //       color: const Color.fromARGB(
                                        //           255, 190, 255, 192)),
                                        //   child: Center(
                                        //       child: Text(
                                        //     tcontoller.isPaymentSuccessful
                                        //                 .value ==
                                        //             true
                                        //         ? "Success"
                                        //         : "Failed",
                                        //     style: TextStyle(
                                        //         color: Color(0xFF00865D),
                                        //         fontWeight: FontWeight.w600),
                                        //   )),
                                        // ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Text(
                  //     "How was your experience?",
                  //     style: TextStyle(
                  //         fontSize: 16.sp,
                  //         fontWeight: FontWeight.w600,
                  //         color: Color(0xFF294C73)),
                  //   ),
                  // ),
                  // RatingBar.builder(
                  //   initialRating: 5,
                  //   minRating: .5,
                  //   direction: Axis.horizontal,
                  //   allowHalfRating: true,
                  //   itemCount: 5,
                  //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  //   itemBuilder: (context, _) => Icon(
                  //     Icons.star,
                  //     color: Colors.amber,
                  //   ),
                  //   onRatingUpdate: (rating) {
                  //     print(rating);
                  //   },
                  // )
                ],
              ),
              Positioned(
                bottom: 0,
                child: elevatedButtonWidget(
                  context: context,
                  text: tcontoller.isPaymentSuccessful.value == true
                      ? 'Back to Order'
                      : 'Back to Home',
                  width: Get.width,
                  backgroundColor: ColorResources.colorE5AA17,
                  txtColor: ColorResources.colorBlack,
                  onPressed: () {
                    // Get.to(() => BottomNavigationScreen());
                    tcontoller.isPaymentSuccessful.value == true
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BottomNavigationWidget(selectedIndex: 2);
                              },
                            ),
                            (route) {
                              return true;
                            },
                          )
                        : Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BottomNavigationWidget(
                                  selectedIndex: 0,
                                );
                              },
                            ),
                            (route) {
                              return true;
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
