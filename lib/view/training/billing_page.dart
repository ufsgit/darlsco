import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/phone_verification_page.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/tainning/trainnig_controller.dart';
import '../home/bottom_navigation_screen.dart';

String StoreId = "30267";
String authKey = "MF27f#hJF9T@d7QB";

class BillingDetailsPage extends StatefulWidget {
  const BillingDetailsPage({
    super.key,
    categoryName,
  });

  @override
  State<BillingDetailsPage> createState() => _BillingDetailsPageState();
}

class _BillingDetailsPageState extends State<BillingDetailsPage> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  init() async {
    setState(() => isLoading = true);
    await homeController.isUsersignedIn();
    if (homeController.isTraineeLogin.value == true) {
      await trainingController.getProfile();
    }
    setState(() => isLoading = false);

    //   await trainingController
    //       .fetchCategoryData('${widget.trainingCourseId}');
  }

  // final TrainingControllerHomee trainingController =
  //     Get.put(TrainingControllerHomee());
  // final HomeController globalHomeController = Get.put(HomeController());

  List<double> listTotals = [];

  double calculateSubtotal(int index) {
    double applicationFees = 0.0;
    double examinationFees = 0.0;
    double certificationFees = 0.0;
    var priceDetails = trainingController.priceDetailsData[index];

    applicationFees = double.tryParse(priceDetails.applicationFees) ?? 0.0;
    examinationFees = double.tryParse(priceDetails.examinationFees) ?? 0.0;
    certificationFees = double.tryParse(priceDetails.certificateFees) ?? 0.0;

    double subtotal = applicationFees + examinationFees + certificationFees;

    return subtotal;
  }

  double calculateVat(double totalPrice) {
    return totalPrice * 0.05;
  }

  double calculateTransactionFee(double totalPrice) {
    return totalPrice * 0.025;
  }

  double calculateListTotal(int index) {
    double subtotal = calculateSubtotal(index);
    double vat = calculateVat(subtotal);
    double transactionFee = calculateTransactionFee(subtotal);

    double listTotal = subtotal + vat + transactionFee;

    return listTotal;
  }

  double calculateGrandTotal() {
    double grandTotal = 0.0;

    for (int i = 0; i < listTotals.length; i++) {
      grandTotal += listTotals[i];
    }
    print(grandTotal);
    return grandTotal;
  }

  bool isTotalPriceCalculated = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  // GetBuilder<TrainingControllerHomee>(
                  //   builder: (controller) {
                  // listTotals.clear(); // Clear the list before recalculating
                  // if (pricecontroller.priceDetailsData.isNotEmpty) {
                  //   for (int i = 0;
                  //       i < pricecontroller.priceDetailsData.length;
                  //       i++) {
                  //     if (pricecontroller
                  //             .priceDetailsData[i].isTraingwithExamination ==
                  //         1) {
                  //       listTotals.add(calculateListTotal(i));
                  //     }
                  //   }
                  // }

                  // return

                  commonBackgroundLinearColorBill(
                    childWidget: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: CircleAvatar(
                                    radius: 18.h,
                                    backgroundColor: ColorResources.colorDBE8FC,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 30.h,
                                        color: ColorResources.color294C73,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Text(
                                  'Price Details',
                                  style: GoogleFonts.dmSans(
                                    color: ColorResources.color294C73,
                                    fontSize: 25.sp.h,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            GetBuilder<TrainingControllerHomee>(builder: (tt) {
                              // print(
                              //     'print bill   ${trainingController.cartPriceList}');

                              // print(trainingController.cartPriceList);
                              return trainingController.cartPriceList.isEmpty
                                  ? const Center(child: CircularProgressIndicator())
                                  : ListView.separated(
                                      itemCount: trainingController
                                          .cartPriceList.length,
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: 12.h,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        double vat = double.parse(
                                                trainingController
                                                    .cartPriceList[index]
                                                    .subTotal) *
                                            0.025;
                                        double subTotal = double.parse(
                                            trainingController
                                                .cartPriceList[index].subTotal);

                                        double total = subTotal + vat;
                                        double transactionFee = total *
                                            double.parse(trainingController
                                                .cartPriceList[index]
                                                .serviceCharge) /
                                            100;

                                        double applicationFee = double.parse(
                                                trainingController
                                                    .cartPriceList[index]
                                                    .applicationFee) *
                                            trainingController
                                                .cartPriceList[index].quantity;
                                        double examinationFee = double.parse(
                                                trainingController
                                                    .cartPriceList[index]
                                                    .examinationFee) *
                                            trainingController
                                                .cartPriceList[index].quantity;
                                        double certificateFee = double.parse(
                                                trainingController
                                                    .cartPriceList[index]
                                                    .certificateFee) *
                                            trainingController
                                                .cartPriceList[index].quantity;

                                        double serviceAmount = double.parse(
                                                trainingController
                                                    .cartPriceList[index]
                                                    .amount) *
                                            double.parse(trainingController
                                                .cartPriceList[index].quantity
                                                .toString());
                                        double certificateVat = certificateFee *
                                            double.parse(trainingController
                                                .cartPriceList[index]
                                                .certificateTax) /
                                            100;
                                        double applicationVat = applicationFee *
                                            double.parse(trainingController
                                                .cartPriceList[index]
                                                .applicationTax) /
                                            100;
                                        double examinationVat = examinationFee *
                                            double.parse(trainingController
                                                .cartPriceList[index]
                                                .examinationTax) /
                                            100;
                                        double courseVat = serviceAmount *
                                            double.parse(trainingController
                                                .cartPriceList[index].tax) /
                                            100;

                                        double totalVat = certificateVat +
                                            courseVat +
                                            examinationVat +
                                            applicationVat;

                                        return Container(
                                          color: ColorResources.colorBlue
                                              .withOpacity(.15),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 20.h),
                                            child: billCartWidget(
                                                courseVatPer: trainingController
                                                    .cartPriceList[index].tax,
                                                courseVat: courseVat
                                                    .toStringAsFixed(2),
                                                serviceName: trainingController
                                                    .cartPriceList[index]
                                                    .trainingCourseName,
                                                servicePrice: serviceAmount
                                                    .toStringAsFixed(2),
                                                category: trainingController
                                                    .cartPriceList[index]
                                                    .categoryName,
                                                quantity: trainingController
                                                    .cartPriceList[index]
                                                    .quantity,
                                                applicationFee: applicationFee
                                                    .toStringAsFixed(2),
                                                examFee: examinationFee
                                                    .toStringAsFixed(2),
                                                certificateFee: certificateFee
                                                    .toStringAsFixed(2),
                                                vat: trainingController
                                                    .cartPriceList[index].vat,
                                                subTotal: trainingController
                                                    .cartPriceList[index]
                                                    .subTotal,
                                                totalPriceVat: totalVat,
                                                applicationVatpercentage:
                                                    trainingController.cartPriceList[index].applicationTax,
                                                certificateVatpercentage: trainingController.cartPriceList[index].certificateTax,
                                                examinationVatpercentage: trainingController.cartPriceList[index].examinationTax,
                                                applicationVat: applicationVat.toStringAsFixed(2),
                                                certificateVat: certificateVat.toStringAsFixed(2),
                                                examinationVat: examinationVat.toStringAsFixed(2),
                                                transactionFeeVat: trainingController.cartPriceList[index].serviceCharge,
                                                transactionFee: transactionFee.toPrecision(2)),
                                          ),
                                        );
                                      },
                                    );
                            }),
                            // GetBuilder(
                            //     init: trainingBillPageData,
                            //     builder: (context) {
                            //       print("nnnn${context.cartPriceList}");
                            //       return
                            //     })

                            // Column(
                            //   children: List.generate(
                            //       1,
                            //       (index) => Column(
                            //             children: [
                            //               SizedBox(height: 8.h),
                            //               Padding(
                            //                 padding: const EdgeInsets.all(10.0),
                            //                 child: billWidget(
                            //                   serviceName: trainingController
                            //                               .getTriningDetailList[index]
                            //                           ['Training_Course_Name'] ??
                            //                       'ex',
                            //                   servicePrice:
                            //                       tcontoller.totalPrice.toString(),
                            //                   category: trainingController
                            //                       .priceDetailsList[index]
                            //                       .categoryName!,
                            //                   quantity:
                            //                       int.parse(tcontoller.dropdownvalue),
                            //                   vat: trainingController
                            //                       .priceDetailsList[index]
                            //                       .trainingFeeVat!,
                            //                   applicationFee: trainingController
                            //                       .priceDetailsList[index]
                            //                       .applicationFees!,
                            //                   examFee: trainingController
                            //                       .priceDetailsList[index]
                            //                       .examinationFees!,
                            //                   certificateFee: trainingController
                            //                       .priceDetailsList[index]
                            //                       .certificateFees!,
                            //                 ),
                            //               ),
                            //               SizedBox(height: 10.h),
                            //             ],
                            //           )),
                            // )

                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   itemCount: 1,
                            //   itemBuilder: (context, index) {

                            //     var priceDetail =
                            //     trainingController.selectedCategory.value;

                            //       print(
                            //           "${trainingController.catdisplay.length}");
                            //       return Column(
                            //         children: [
                            //           SizedBox(height: 8.h),
                            //           Padding(
                            //             padding: const EdgeInsets.all(10.0),
                            //             child: billWidget(
                            //               serviceName:
                            //                 trainingController.priceDetailsList[index].trainingCourseName??'ex',
                            //               servicePrice:tcontoller.totalPrice.toString(),
                            //               category: pricecontroller.priceDetailsList[index].categoryName!,
                            //               quantity: int.parse(tcontoller.dropdownvalue)   ,
                            //               vat: pricecontroller.priceDetailsList[index].trainingFeeVat!,
                            //               applicationFee:
                            //              pricecontroller.priceDetailsList[index].applicationFees!,
                            //               examFee:pricecontroller.priceDetailsList[index].examinationFees!,
                            //               certificateFee:
                            //                pricecontroller.priceDetailsList[index].certificateFees!,
                            //             ),
                            //           ),
                            //           SizedBox(height: 10.h),

                            //         ],
                            //       );

                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                    //   );
                    // },
                  ),

                  // Positioned(
                  //   top: 40,
                  //   left: 20,
                  //   child:
                  // ),
                ],
              ),
        bottomNavigationBar:
            GetBuilder<TrainingControllerHomee>(builder: (controller) {
          // double totalPrice = 0.0;
          tcontoller.totalPrice = 0.0;
          tcontoller.totalVat = 0.0;
          tcontoller.subTotal = 0.0;
          tcontoller.serviceCharge = 0.0;

          for (int i = 0; i < trainingController.cartPriceList.length; i++) {
            tcontoller.subTotal += (double.parse(
                        trainingController.cartPriceList[i].amount) *
                    trainingController.cartPriceList[i].quantity) +
                (double.parse(
                        trainingController.cartPriceList[i].applicationFee) *
                    trainingController.cartPriceList[i].quantity) +
                (double.parse(
                        trainingController.cartPriceList[i].examinationFee) *
                    trainingController.cartPriceList[i].quantity) +
                (double.parse(
                        trainingController.cartPriceList[i].certificateFee) *
                    trainingController.cartPriceList[i].quantity);

            tcontoller.totalVat += (double.parse(
                            trainingController.cartPriceList[i].amount) *
                        trainingController.cartPriceList[i].quantity) *
                    ((double.parse(trainingController.cartPriceList[i].tax) /
                        100)) +
                (double.parse(trainingController.cartPriceList[i].applicationFee) *
                        trainingController.cartPriceList[i].quantity) *
                    ((double.parse(trainingController.cartPriceList[i].applicationTax) /
                        100)) +
                (double.parse(trainingController.cartPriceList[i].examinationFee) *
                        trainingController.cartPriceList[i].quantity) *
                    ((double.parse(trainingController.cartPriceList[i].examinationTax) /
                        100)) +
                (double.parse(trainingController.cartPriceList[i].certificateFee) *
                        trainingController.cartPriceList[i].quantity) *
                    ((double.parse(trainingController.cartPriceList[i].certificateTax) /
                        100));

            print(tcontoller.totalVat);
            tcontoller.totalPrice =
                (double.parse(tcontoller.subTotal.toString()) +
                    double.parse(tcontoller.totalVat.toString()) +
                    (((double.parse(tcontoller.subTotal.toString()) *
                            double.parse(trainingController
                                .cartPriceList[0].serviceCharge
                                .toString())) /
                        100)));
            tcontoller.coursePrice = tcontoller.totalPrice;
            tcontoller.serviceCharge = (tcontoller.subTotal *
                double.parse(trainingController.cartPriceList[0].serviceCharge
                    .toString()) /
                100);
            // double applicationFee = double.parse(
            //         trainingController.cartPriceList[i].applicationFee) *
            //     trainingController.cartPriceList[i].quantity;
            // double examinationFee = double.parse(
            //         trainingController.cartPriceList[i].examinationFee) *
            //     trainingController.cartPriceList[i].quantity;
            // double certificateFee = double.parse(
            //         trainingController.cartPriceList[i].certificateFee) *
            //     trainingController.cartPriceList[i].quantity;
            // double courseFee =
            //     double.parse(trainingController.cartPriceList[i].amount) *
            //         trainingController.cartPriceList[i].quantity;

            // double applicationVat = applicationFee *
            //     double.parse(
            //         trainingController.cartPriceList[i].applicationTax) /
            //     100;
            // double examinationVat = examinationFee *
            //     double.parse(
            //         trainingController.cartPriceList[i].examinationTax) /
            //     100;
            // double certificateVat = certificateFee *
            //     double.parse(
            //         trainingController.cartPriceList[i].certificateTax) /
            //     100;
            // double courseVat = courseFee *
            //     double.parse(trainingController.cartPriceList[i].tax) /
            //     100;
            // double totalVat = certificateVat +
            //     examinationVat +
            //     applicationVat +
            //     courseVat;
            // double vat = totalVat;
            // double subTotal =
            //     double.parse(trainingController.cartPriceList[i].subTotal);
            // double total = subTotal + vat;
            // double transactionFee = total *
            //     double.parse(
            //         trainingController.cartPriceList[i].serviceCharge) /
            //     100;
            // tcontoller.totalPrice += subTotal + vat + transactionFee;
          }

          print('////////////////////sub total:  ${tcontoller.subTotal}');

          // tcontoller.totalVat.value = 0.0;

          // for (int i = 0;
          //     i < trainingController.cartPriceList.length;
          //     i++) {
          //   double subTotal =
          //       double.parse(trainingController.cartPriceList[i].subTotal);
          //   double vat = subTotal * 0.025;

          //   tcontoller.totalVat.value += vat;
          // }
          // print('total vat charge:${tcontoller.totalVat}');
          // tcontoller.serviceCharge.value = 0.0;
          // for (int i = 0;
          //     i < trainingController.cartPriceList.length;
          //     i++) {
          //   double serviceCharge = double.parse(
          //       trainingController.cartPriceList[i].serviceCharge);

          //   tcontoller.serviceCharge.value += serviceCharge;
          // }
          // print('Service charge:${tcontoller.serviceCharge}');

          return trainingController.cartPriceList.isEmpty
              ? const SizedBox()
              : bottomBillWidget(
                  subTotal: tcontoller.subTotal.toStringAsFixed(2),
                  totalVat: tcontoller.totalVat.toStringAsFixed(2),
                  serviceTax: tcontoller.serviceCharge.toStringAsFixed(2),
                  totalPrice: tcontoller.totalPrice.toStringAsFixed(2),
                  transactionFee:
                      trainingController.cartPriceList[0].serviceCharge,
                  context: context,
                  btnText: 'Pay Now',
                  bgColor: const Color(0xFFC3DEFD),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          surfaceTintColor: Colors.transparent,
                          backgroundColor: ColorResources.whiteColor,
                          shadowColor: Colors.transparent,
                          // shape: ContinuousRectangleBorder(
                          //     borderRadius: BorderRadius.circular(15.r)),
                          // elevation: 10,
                          // shadowColor: ColorResources.color294C73,
                          content: Text(
                            'Are you sure you want to continue with the payment?',
                            style: GoogleFonts.dmSans(
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
                                    'retakePurchaseBillDataList ${trainingController.retakePurchaseBillDataList}');

                                await homeController.isUsersignedIn();
                                if (homeController.isTraineeLogin.value ==
                                    true) {
                                  Get.back();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String phoneNumber =
                                      prefs.getString('phone_no') ?? '';
                                  String email =
                                      prefs.getString('email_user_') ?? '';
                                  String name =
                                      prefs.getString('name_user_') ?? '';
                                  prefs.setString('totalPrice',
                                      tcontoller.totalPrice.toString());
                                  // TextEditingController email =
                                  //     TextEditingController();
                                  // Get.back();
                                  await homeController.purchaseGateWay(
                                      name: trainingController
                                          .profileDetails[0].customerName,
                                      Get.context!,
                                      phoneNumber: trainingController
                                          .profileDetails[0].mobile,
                                      email: trainingController
                                          .profileDetails[0].email,
                                      tcontoller.totalPrice.toStringAsFixed(2));
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (c) => AlertDialog(
                                  //           content: Column(
                                  //             mainAxisSize:   MainAxisSize.min,
                                  //             children: [
                                  //               const Text(
                                  //                 'Please enter your email address to initiate the payment process',
                                  //                 style: TextStyle(
                                  //                     fontSize: 14,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //               const SizedBox(height: 17),
                                  //               TextField(
                                  //                 controller: email,
                                  //                 decoration: const InputDecoration(
                                  //                   hintText: 'Enter Email ',
                                  //                   border: OutlineInputBorder(),
                                  //                 ),
                                  //               ),
                                  //               const SizedBox(height: 17),
                                  //               ElevatedButton(
                                  //                   onPressed: () async {

                                  //                     Navigator.of(Get.context!)
                                  //                         .pop();
                                  //                   },
                                  //                   child: const Text('Submit'))
                                  //             ],
                                  //           ),
                                  //         ));
                                } else {
                                  homeController.isFromPurchase.value = true;

                                  Get.to(() => const PhoneVerificationPage());
                                }
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
        }),
      ),
    );
  }
}
