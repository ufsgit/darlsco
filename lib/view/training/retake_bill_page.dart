
import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/certificate_page.dart';
import 'package:darlsco/view/training/phone_verification_page.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/tainning/trainnig_controller.dart';
import '../home/bottom_navigation_screen.dart';

String StoreId = '30267';
String authKey = 'MF27f#hJF9T@d7QB';

class RetakeBillPage extends StatefulWidget {
  const RetakeBillPage({
    super.key,
  });

  @override
  State<RetakeBillPage> createState() => _RetakeBillPageState();
}

class _RetakeBillPageState extends State<RetakeBillPage> {
  double grantTotal = 0.00;
  double subTotal = 0.00;
  double totalVat = 0.00;
  String transactionFee = '0';

  @override
  void initState() {
    init();

    print(
        'retake check bill list ${trainingController.retakePurchaseBillDataList}');

    for (var i = 0;
        i < trainingController.retakePurchaseBillDataList.length;
        i++) {
      grantTotal +=
          trainingController.retakePurchaseBillDataList[i]['grant_total'];
      subTotal += double.parse(trainingController.retakePurchaseBillDataList[i]
              ['Amount']
          .toString());
      totalVat += double.parse(
          trainingController.retakePurchaseBillDataList[i]['Vat'].toString());
    }
    super.initState();
  }

  init() async {
    trainingController.transactionFee =
        await trainingController.getTransactionFee();
    trainingController.getProfile();
  }

  final TrainingControllerHomee trainingController =
      Get.put(TrainingControllerHomee());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            commonBackgroundLinearColorBill(
              childWidget: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.h, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 80.h),
                      Text(
                        'Price Details',
                        style: GoogleFonts.dmSans(
                          color: ColorResources.color294C73,
                          fontSize: 25.sp.h,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GetBuilder<TrainingControllerHomee>(builder: (data) {
                        return ListView.separated(
                          itemCount: data.retakePurchaseBillDataList.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 12.h,
                            );
                          },
                          itemBuilder: (context, index) {
                            return Container(
                                color:
                                    ColorResources.colorBlue.withOpacity(.15),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 20.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            billPriceTextStyleWidget(
                                                text:
                                                    data.retakePurchaseBillDataList[
                                                        index]['course_name']),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        billTextStylewidget(
                                            text:
                                                'Category - ${data.retakePurchaseBillDataList[index]['category']}'),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        // billTextStylewidget(text: 'Quantity - 10'),
                                        // SizedBox(
                                        //   height: 12.h,
                                        // ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            billTextStylewidget(
                                                text: 'Examination Fees'),
                                            SizedBox(
                                              width: 85.w.h,
                                              child: billPriceTextStyleWidget(
                                                  text:
                                                      'AED ${double.parse(data.retakePurchaseBillDataList[index]['Amount'].toString()).toStringAsFixed(2)}'),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            billTextStylewidget(
                                                text:
                                                    'Examination Vat-  ${data.retakePurchaseBillDataList[index]['examination_vat']}%'),
                                            SizedBox(
                                              width: 85.w.h,
                                              child: billPriceTextStyleWidget(
                                                  text:
                                                      'AED ${double.parse(data.retakePurchaseBillDataList[index]['Vat'].toString()).toStringAsFixed(2)}'),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),

                                        SizedBox(
                                          height: 24.h,
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     billPriceTextStyleWidget(
                                        //         text: 'Sub Total'),
                                        //     SizedBox(
                                        //       width: 85.w.h,
                                        //       child: billPriceTextStyleWidget(
                                        //           text:
                                        //               'AED ${data.retakePurchaseBillDataList[index]['sub_total']}'),
                                        //     )
                                        //   ],
                                        // ),
                                        // SizedBox(
                                        //   height: 24.h,
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     billPriceTextStyleWidget(
                                        //         text: 'Total Vat'),
                                        //     SizedBox(
                                        //       width: 85.w.h,
                                        //       child: billPriceTextStyleWidget(
                                        //           text:
                                        //               'AED ${(double.parse(data.retakePurchaseBillDataList[index]['examination_fee'].toString()) * double.parse(data.retakePurchaseBillDataList[index]['examination_vat'].toString())) / 100}'),
                                        //     )
                                        //   ],
                                        // ),
                                        // SizedBox(height: 24.h),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     billPriceTextStyleWidget(
                                        //         text: 'Transaction Fee - 2.5%'),
                                        //     SizedBox(
                                        //       width: 85.w.h,
                                        //       child: billPriceTextStyleWidget(
                                        //           text:
                                        //               'AED ${((double.parse(data.retakePurchaseBillDataList[index]['examination_fee'].toString()) + (double.parse(data.retakePurchaseBillDataList[index]['examination_fee'].toString()) * double.parse(data.retakePurchaseBillDataList[index]['examination_vat'].toString())) / 100) * 2.5 / 100).toStringAsFixed(2)}'),
                                        //     ),
                                        //   ],
                                        // ),
                                        // SizedBox(height: 16.h),

                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     billPriceTextStyleWidget(
                                        //         text: 'Total'),
                                        //     SizedBox(
                                        //       width: 85.w.h,
                                        //       child: billPriceTextStyleWidget(
                                        //           text:
                                        //               'AED ${(double.parse(data.retakePurchaseBillDataList[index]['examination_fee'].toString()) + ((double.parse(data.retakePurchaseBillDataList[index]['examination_fee'].toString()) * double.parse(trainingController.retakePurchaseBillDataList[index]['examination_vat'].toString())) / 100) + ((double.parse(trainingController.retakePurchaseBillDataList[index]['examination_fee'].toString()) + (double.parse(trainingController.retakePurchaseBillDataList[index]['examination_fee'].toString()) * double.parse(trainingController.retakePurchaseBillDataList[index]['examination_vat'].toString())) / 100) * 2.5 / 100)).toStringAsFixed(2)}'),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    )));
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              //   );
              // },
            ),
            Positioned(
              top: 40,
              left: 20,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30.h,
                  color: ColorResources.color294C73,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            GetBuilder<TrainingControllerHomee>(builder: (controller) {
          tcontoller.totalPrice = (double.parse(subTotal.toString()) +
              double.parse(totalVat.toString()) +
              (((double.parse(subTotal.toString()) *
                      double.parse(
                          trainingHomeController.transactionFee.toString())) /
                  100)));
          return GetBuilder<TrainingControllerHomee>(
              builder: (transactionData) {
            return bottomBillWidget(
              subTotal: subTotal.toStringAsFixed(2),
              totalVat: totalVat.toStringAsFixed(2),
              serviceTax: (subTotal *
                      double.parse(transactionData.transactionFee.toString()) /
                      100)
                  .toStringAsFixed(2),
              transactionFee: transactionData.transactionFee.toString(),
              totalPrice: (double.parse(subTotal.toString()) +
                      double.parse(totalVat.toString()) +
                      (((double.parse(subTotal.toString()) *
                              double.parse(
                                  transactionData.transactionFee.toString())) /
                          100)))
                  .toStringAsFixed(2),
              context: context,
              btnText: 'Pay Now',
              bgColor: const Color.fromARGB(255, 65, 92, 124),
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                String phoneNumber =
                    sharedPreferences.getString('phone_no') ?? '';
                String email = sharedPreferences.getString('email_user_') ?? '';
                String name = sharedPreferences.getString('Name_retake') ?? '';
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // backgroundColor: ColorResources.whiteColor,
                      // shape: ContinuousRectangleBorder(
                      //     borderRadius: BorderRadius.circular(15.r)),
                      // elevation: 10,
                      // shadowColor: ColorResources.color294C73,
                      content: Text(
                        'Are you sure you want to continue with the payment?',
                        style: GoogleFonts.dmSans(
                          // color: ColorResources.colorBlack,
                          fontSize: 16.sp.h,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      actions: [
                        textButtonWidget(
                          text: 'No',
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        textButtonWidget(
                          text: 'Yes',
                          onPressed: () async {
                            print(
                                'inside purchase bill button ${trainingController.retakePurchaseBillDataList}');

                            await homeController.isUsersignedIn();
                            if (homeController.isTraineeLogin.value == true) {
                              // Get.back();

                              await homeController.purchaseGateWay(Get.context!,
                                  tcontoller.totalPrice.toStringAsFixed(2),
                                  isRetake: true,
                                  orderMasterId: transactionData
                                      .retakePurchaseBillDataList[0]
                                          ['order_master_id']
                                      .toString(),
                                  phoneNumber: phoneNumber,
                                  name: trainingController
                                      .profileDetails[0].customerName,
                                  email: trainingController
                                      .profileDetails[0].email);

                              Navigator.of(Get.context!).pop();
                            } else {
                              homeController.isFromPurchase.value = true;

                              Get.to(() => const PhoneVerificationPage());
                            }
                            // Get.back();
                          },
                        ),
                      ],
                    );
                  },
                );
                // homeController.isUsersignedIn();
                // if (homeController.isTraineeLogin.value == true) {
                //   await homeController.purchaseGateWay(context);
                // } else {
                //   homeController.isFromPurchase.value = true;
                //   Get.to(() => const PhoneVerificationPage());
                // }
              },
            );
          });

          // SizedBox(
          //   height: 125.w.h,
          //   child: Column(
          //     children: [
          //       Align(
          //         alignment: Alignment.bottomCenter,
          //         child: Container(
          //           height: 70.w.h,
          //           decoration: const BoxDecoration(
          //             color: Color(0xFFC3DEFD),
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 12),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   'Total',
          //                   style: GoogleFonts.dmSans(
          //                     color: ColorResources.colorFF0950A0,
          //                     fontSize: 19.sp.h,
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //                 Text(
          //                   'AED ${grantTotal.toStringAsFixed(2)}',
          //                   style: GoogleFonts.dmSans(
          //                     color: ColorResources.colorFF0950A0,
          //                     fontSize: 19.sp.h,
          //                     fontWeight: FontWeight.w700,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       elevatedButtonWidget(
          //         context: context,
          //         width: Get.width,
          //         backgroundColor: ColorResources.colorE5AA17,
          //         text: 'Pay Now',
          //         onPressed: () async {
          //           await homeController.purchaseGateWay(
          //               context, grantTotal,
          //               isRetake: true);
          //           // showDialog(
          //           //   context: context,
          //           //   builder: (context) {
          //           //     return AlertDialog(
          //           //       backgroundColor: ColorResources.whiteColor,
          //           //       shape: ContinuousRectangleBorder(
          //           //           borderRadius: BorderRadius.circular(15.r)),
          //           //       elevation: 10,
          //           //       shadowColor: ColorResources.color294C73,
          //           //       content: Text(
          //           //         'Are you sure!\nDo you want to confirm this payment?',
          //           //         style: GoogleFonts.dmSans(
          //           //           color: ColorResources.colorBlack,
          //           //           fontSize: 16.sp.h,
          //           //           fontWeight: FontWeight.w700,
          //           //         ),
          //           //       ),
          //           //       actions: [
          //           //         textButtonWidget(
          //           //           text: 'Yes',
          //           //           onPressed: () async {
          //           //             Get.back();
          //           //             await homeController.purchaseGateWay(
          //           //                 context, grantTotal,
          //           //                 isRetake: true);
          //           //           },
          //           //         ),
          //           //         textButtonWidget(
          //           //           text: 'No',
          //           //           onPressed: () {
          //           //             Get.back();
          //           //           },
          //           //         )
          //           //       ],
          //           //     );
          //           //   },
          //           // );
          //         },
          //         txtColor: ColorResources.colorBlack,
          //       ),
          //     ],
          //   ),
          // );
        }),
      ),
    );
  }
}
