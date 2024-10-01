// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/billing_page.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/tainning/training_controller_home.dart';

class Payment_Detailcards extends StatefulWidget {
  const Payment_Detailcards({super.key});

  @override
  State<Payment_Detailcards> createState() => _Payment_DetailcardsState();
}

enum Payment { visa, rupay, paypal }

class _Payment_DetailcardsState extends State<Payment_Detailcards> {
  final TrainingControllerHomee pricecontroller =
      Get.put(TrainingControllerHomee());
  Payment? _paymenttype = Payment.visa;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            commonBackgroundLinearColor(
              childWidget: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.sp),
                            ),
                            Text(
                              "AED 7,700",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 70.w.h,
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _paymenttype = Payment.visa;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/images/visa.png",
                                            height: 50.h),
                                        Text(
                                          "******9856",
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Radio<Payment>(
                                          activeColor: Color(0xFF003674),
                                          value: Payment.visa,
                                          groupValue: _paymenttype,
                                          onChanged: (Payment? value) {
                                            setState(() {
                                              _paymenttype = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 70.w.h,
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _paymenttype = Payment.rupay;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/images/rupay.png",
                                            height: 50.h),
                                        Text(
                                          "******8523",
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Radio<Payment>(
                                          activeColor: Color(0xFF003674),
                                          value: Payment.rupay,
                                          groupValue: _paymenttype,
                                          onChanged: (Payment? value) {
                                            setState(() {
                                              _paymenttype = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 70.w.h,
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _paymenttype = Payment.paypal;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/images/paypal.png",
                                            height: 50.h),
                                        Text(
                                          "johnson@gmail.com",
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Radio<Payment>(
                                          activeColor: Color(0xFF003674),
                                          value: Payment.paypal,
                                          groupValue: _paymenttype,
                                          onChanged: (Payment? value) {
                                            setState(() {
                                              _paymenttype = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "+ Add New Card",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF294C73),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: elevatedButtonWidget(
                context: context,
                text: 'Pay Now',
                width: Get.width,
                backgroundColor: ColorResources.colorE5AA17,
                txtColor: ColorResources.colorBlack,
                onPressed: () {
                  Get.to(() => BillingDetailsPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
