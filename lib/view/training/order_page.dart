import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training_phase2/reschedule_addtraniee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final trainingHomeController = Get.put(TrainingControllerHomee());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      trainingHomeController.getOrdersItems();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => commonBackgroundLinearColorCart(
            childWidget: !trainingHomeController.isOrderscreenLoading.value
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.h, vertical: 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     // InkWell(
                          //     //   onTap: () {
                          //     //     Get.back();
                          //     //   },
                          //     //   child: Icon(
                          //     //     Icons.arrow_back,
                          //     //     size: 30.h,
                          //     //     color: ColorResources.color294C73,
                          //     //   ),
                          //     // ),
                          //     InkWell(
                          //       onTap: () {
                          //         Get.to(() => const CartScreen());
                          //       },
                          //       child: CircleAvatar(
                          //         radius: 18.h,
                          //         backgroundColor: ColorResources.whiteColor,
                          //         child: const Icon(Icons.shopping_cart_outlined),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 24.h,
                          // ),
                          trainingHomeController.orderData.isNotEmpty
                              ? ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 15.w,
                                      ),
                                  itemCount:
                                      trainingHomeController.orderData.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      //     onTap: () async{

                                      // await  trainingHomeController.    getSpecificOrderDetails(orderMasterId: trainingHomeController
                                      //                 .orderData[index].orderMasterId.toString() );

                                      //       Get.to(() => AddtraineeReschedule(
                                      //             orderItem: trainingHomeController
                                      //                 .orderData[index],
                                      //             orderIndex: index,
                                      //           ));
                                      //     },
                                      child: Column(
                                        children: [
                                          Container(
                                              // height: 150.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: ColorResources
                                                      .whiteColor),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.h,
                                                    vertical: 12.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // SizedBox(width: 5.w,),

                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10.w),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Text(
                                                            trainingHomeController
                                                                .orderData[
                                                                    index]
                                                                .orderNo,
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              color:
                                                                  ColorResources
                                                                      .colorBlack,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15.w,
                                                          ),
                                                          Text(
                                                            trainingHomeController
                                                                .orderData[
                                                                    index]
                                                                .orderDate,
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              color: ColorResources
                                                                  .color294C73,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15.w,
                                                          ),
                                                          Text(
                                                            'AED ${trainingHomeController.orderData[index].totalAmount}',
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              color: ColorResources
                                                                  .colorE5AA17,
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    ElevatedButton(
                                                        onPressed:
                                                            // tcontoller
                                                            //                 .isTraineeAdded
                                                            //                 .value ==
                                                            //             true ||
                                                            () async {
                                                          trainingHomeController
                                                              .isOrderscreenLoading
                                                              .value = true;

                                                          await trainingHomeController
                                                              .getSpecificOrderDetails(
                                                                  orderMasterId: trainingHomeController
                                                                      .orderData[
                                                                          index]
                                                                      .orderMasterId
                                                                      .toString());

                                                          Get.to(() =>
                                                                  AddtraineeReschedule(
                                                                    orderItem:
                                                                        trainingHomeController
                                                                            .orderData[index],
                                                                    orderIndex:
                                                                        index,
                                                                  ))!
                                                              .whenComplete(() =>
                                                                  trainingHomeController
                                                                      .isOrderscreenLoading
                                                                      .value = false);
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              WidgetStateProperty
                                                                  .all<Color>(
                                                            const Color(
                                                                0xFF0B8900),
                                                          ),

                                                          foregroundColor:
                                                              WidgetStateProperty
                                                                  .all<Color>(
                                                            const Color(
                                                                0xFF0B8900),
                                                          ),
                                                          shape: WidgetStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              side:
                                                                  const BorderSide(
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
                                                            "Course Details",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    12.sp)))

                                                    // Container(
                                                    //   width: 90.h.w,
                                                    //   decoration: BoxDecoration(
                                                    //     image: const DecorationImage(
                                                    //         image: AssetImage('assets/images/order_image.png'),
                                                    //         fit: BoxFit.contain),
                                                    //     borderRadius: BorderRadius.circular(10),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),

                                      //   cartDetailsWidget(
                                      //       height: 130.h,
                                      //       imageName: 'jhjh',
                                      //       orderNumber: trainingHomeController
                                      //           .orderData[index].orderNo,
                                      //       fileName: trainingHomeController
                                      //           .orderData[index].fileName!,
                                      //       onTap: () {},
                                      //       isCartpage: false,
                                      //       textColor: ColorResources.color294C73,
                                      //       courseName: trainingHomeController
                                      //           .orderData[index].trainingCourseName,
                                      //       categoryName: trainingHomeController
                                      //           .orderData[index].categoryName,
                                      //       amount:
                                      //           'AED ${trainingHomeController.orderData[index].totalAmount}',
                                      //       quantity: trainingHomeController
                                      //           .orderData[index].quantity
                                      //           .toString(),
                                      //       context: context,
                                      //       amtColor: ColorResources.colorE5AA17),
                                      // );
                                    );
                                  })
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height / 2.5,
                                    ),
                                    Center(
                                      child: Text(
                                        'No orders',
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
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
