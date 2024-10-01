import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/billing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  final bool isFromPurchase;
  const CartScreen({super.key, required this.isFromPurchase});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TrainingControllerHomee trainingHomeController =
      Get.put(TrainingControllerHomee());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      trainingHomeController.getItemCart();
    });
    print('getItemCart4');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => commonBackgroundLinearColorCart(
            childWidget:!trainingHomeController.isCartscreenLoading.value? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     Get.back();
                    //   },
                    //   child: Icon(
                    //     Icons.arrow_back_ios,
                    //     size: 30.h,
                    //     color: ColorResources.color294C73,
                    //   ),
                    // ),
                    SizedBox(
                      height: 8.w,
                    ),
                    Row(
                      children: [
                        widget.isFromPurchase
                            ? InkWell(
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
                                      size: 25.h,
                                      color: ColorResources.color294C73,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        widget.isFromPurchase
                            ? SizedBox(
                                width: 15.w,
                              )
                            : const SizedBox(),
                        Text(
                          'Cart',
                          style: TextStyle(
                            fontSize: 32.sp.h,
                            color: ColorResources.color294C73,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    trainingHomeController.cartData.isNotEmpty
                        ? cartListViewWidget(context: context)
                        : Column(
                            children: [
                              SizedBox(
                                height: Get.height / 3,
                              ),
                              Center(
                                child: Text(
                                  'Your cart is empty',
                                  style: GoogleFonts.dmSans(
                                    color: ColorResources.color294C73,
                                    fontSize: 14.sp.h,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ):const Center(child: CircularProgressIndicator(),),
          ),
        ),
        bottomNavigationBar: GetBuilder<TrainingControllerHomee>(
          builder: (controller) {
            if (trainingHomeController.cartData.isNotEmpty) {
              return bottomBillWidget(
                serviceTax: '0',
                subTotal: '',
                totalVat: '0',
                transactionFee: '',
                totalPrice: '${trainingHomeController.calculateTotalPrice()}',
                context: context,
                btnText: 'Buy Now',
                bgColor: ColorResources.whiteColor,
                onPressed: () async {
                  await trainingHomeController.getItemCart();
                  Get.to(() => const BillingDetailsPage());
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
