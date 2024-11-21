// ignore_for_file: prefer_const_constructors

import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/http/http_urls.dart';
import 'package:darlsco/model/training/add_to_cart_model.dart';
import 'package:darlsco/model/training/training_home_model.dart';
import 'package:darlsco/view/training/billing_page.dart';
import 'package:darlsco/view/training/cart_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum SingingCharacter { training, retake }

class Training_Details extends StatefulWidget {
  final TrainingHomeModel trainingCourseDetail;

  final bool isFail;
  final int trainingCourseId;
  const Training_Details({
    super.key,
    required this.trainingCourseDetail,
    required this.isFail,
    required this.trainingCourseId,
  });
  @override
  State<Training_Details> createState() => _Training_DetailsState();
}

class _Training_DetailsState extends State<Training_Details> {
  SingingCharacter? _character = SingingCharacter.training;
  final TrainingControllerHomee trainingController =
      Get.put(TrainingControllerHomee());

  bool isLoading = false;
  bool valuefirst = false;
  bool valuesecond = false;

  // final TrainingControllerHomee catcontroller =
  //     Get.put(TrainingControllerHomee());
  // List of items in our dropdown menu
  // var items = ['1', '2', '3', '4', '5', '6'];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  init() async {
    trainingController.priceList.value = 0;
    tcontoller.quantity.value = 1;
    trainingController.selectedCategory.value = null;
    trainingController.selectedCategoryAfterNavigation.value = null;

    await trainingController.fetchCategoryData('${widget.trainingCourseId}');
  }

  // tcontoller.quantity=1;

  // int quantity = 1;
  @override
  Widget build(BuildContext context) {
    void increaseQuantity() {
      setState(() {
        tcontoller.quantity.value++;
      });
    }

    void decreaseQuantity() {
      if (tcontoller.quantity > 0) {
        setState(() {
          tcontoller.quantity.value--;
        });
      }
    }

    final imageName =
        HttpUrls.imageBase + widget.trainingCourseDetail.fileName!;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   toolbarHeight: 50.h,
        //   scrolledUnderElevation: 0,
        //   backgroundColor: Colors.blue[50],
        //   leading: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: InkWell(
        //       onTap: () {
        //         Get.back();
        //       },
        //       child: CircleAvatar(
        //         radius: 15.h,
        //         backgroundColor: ColorResources.whiteColor,
        //         child: Padding(
        //           padding: const EdgeInsets.only(left: 8),
        //           child: Icon(
        //             Icons.arrow_back_ios,
        //             size: 25.h,
        //             color: ColorResources.color294C73,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.blue[50]),
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: '1',
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(100),
                          ), // Adjust the radius as needed
                          child: Image.network(
                            imageName,
                            fit: BoxFit.cover,
                            width: MediaQuery.sizeOf(context).width,
                            height: 350,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "> Course Name",
                              style: GoogleFonts.dmSans(
                                color: ColorResources.color294C73,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            //                       InkWell(

                            //                         onTap: (){
                            //                            Get.back();
                            //                         },

                            //                         child: Text(
                            //   'Continue Purchase',
                            //   style: GoogleFonts.dmSans(
                            //     color: ColorResources.colorBlue,
                            //     fontSize: 14.sp.h,
                            //     fontWeight: FontWeight.w700,
                            //   ),
                            // ) ,),

                            // textButtonWidget(
                            //     onPressed: () {
                            //       Get.back();
                            //     },
                            //     text: 'Continue Purchase',
                            //     color: ColorResources.colorBlue),
                          ],
                        ),
                      ),
                      // Obx(
                      //   () =>
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     trainingController
                      //             .selectedCategory.value?.description ??
                      //         'Select a category',
                      //     style: GoogleFonts.dmSans(
                      //       color: ColorResources.colorBlack,
                      //       fontSize: 14.sp.h,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25.w, vertical: 8),
                        child: Text(
                          widget.trainingCourseDetail.trainingCourseName,
                          style: GoogleFonts.dmSans(
                            color: ColorResources.colorBlack,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     "${widget.trainingCourseDetail.trainingCourseName}",
                      //     style: TextStyle(
                      //       fontSize: 30.sp.h,
                      //       fontWeight: FontWeight.bold,
                      //       color: Color(0xFF294C73),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "> Course Fee",
                          style: GoogleFonts.dmSans(
                            color: ColorResources.color294C73,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      GetBuilder<TrainingControllerHomee>(
                        builder: (controller) {
                          var applicationFees = trainingController
                                  .selectedCategory.value?.applicationFees ??
                              0.0;
                          tcontoller.applicationFeesDouble.value =
                              applicationFees != null
                                  ? double.parse(applicationFees.toString())
                                  : 0.0;
                          return trainingController.priceList.value != 0
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.w, vertical: 6),
                                  child: Text(
                                    "AED ${controller.priceList.value.toStringAsFixed(2)}",
                                    style: GoogleFonts.dmSans(
                                      color: ColorResources.colorE5AA17,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                )
                              : SizedBox();
                        },
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     "> Description",
                      //     style: GoogleFonts.dmSans(
                      //       color: ColorResources.color294C73,
                      //       fontSize: 20.sp.h,
                      //       fontWeight: FontWeight.w800,
                      //     ),
                      //   ),
                      // ),
                      // Obx(
                      //   () =>
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     trainingController
                      //             .selectedCategory.value?.description ??
                      //         'Select a category',
                      //     style: GoogleFonts.dmSans(
                      //       color: ColorResources.colorBlack,
                      //       fontSize: 14.sp.h,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 25.w, vertical: 8),
                      //   child: Text(
                      //     "${widget.trainingCourseDetail.description}",
                      //     style: GoogleFonts.dmSans(
                      //       color: ColorResources.colorBlack,
                      //       fontSize: 15.sp,

                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      // ),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "> Category",
                          style: GoogleFonts.dmSans(
                            color: ColorResources.color294C73,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(() {
                            print(
                                'category selected from training page  ${trainingController.selectedCategory.value?.categoryName} sddsfds ${trainingController.selectedCategoryAfterNavigation.value?.categoryName}');
                            return Column(
                              children: trainingController.catdisplay
                                  .map<Widget>((category) {
                                return RadioListTile(
                                  activeColor: ColorResources.color294C73,
                                  title: Text(
                                    category.categoryName ?? '',
                                    style: GoogleFonts.dmSans(
                                      color: ColorResources.colorBlack,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  value: category,
                                  groupValue:
                                      trainingController.selectedCategory.value,
                                  onChanged: (selectedCategory) {
                                    print(
                                        ' selected category $selectedCategory');
                                    trainingController
                                        .selectedCategoryAfterNavigation
                                        .value = selectedCategory;
                                    trainingController.selectedCategory.value =
                                        selectedCategory;
                                    var selected = category.categoryName;
                                    trainingController.updateSelectedCategory(
                                        selected.toString());
                                    updatePrice();
                                    trainingController.update();
                                  },
                                );
                              }).toList(),
                            );
                          }),
                          // GetBuilder<TrainingControllerHomee>(
                          //   init: trainingController,
                          //   // id: 'category',
                          //   builder: (trainingController) {
                          //     print('Rebuilding');
                          //     print(trainingController.catdisplay);
                          //     return
                          //   },
                          // ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "> Duration",
                          style: GoogleFonts.dmSans(
                            color: ColorResources.color294C73,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      // GetBuilder<TrainingControllerHomee>(
                      //   init: trainingController,
                      //   id: 'duration',
                      //   builder: (trainingC) {
                      //     return Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Column(
                      //         children: [
                      //           Text(
                      //             '${trainingC.selectedCategory.value?.duration ?? 'Select a category'} Days',
                      //             style: GoogleFonts.dmSans(
                      //               color: ColorResources.colorBlack,
                      //               fontSize: 14.sp.h,
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                      GetBuilder<TrainingControllerHomee>(
                          builder: (durationData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 26, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              durationData.selectedCategory.value?.duration !=
                                      null
                                  ? Text(
                                      '${durationData.selectedCategory.value?.duration} Hrs',
                                      style: GoogleFonts.dmSans(
                                        color: ColorResources.colorBlack,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        );
                      }),

                      SizedBox(
                        height: 15.w,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "> Quantity",
                          style: GoogleFonts.dmSans(
                            color: ColorResources.color294C73,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.sp,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                    onTap: decreaseQuantity,
                                    child: Icon(Icons.arrow_left)),
                                Container(
                                  height: 45.h,
                                  width: 45.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: Color(0xFF294C73),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Obx(
                                      () => Text(
                                        '${tcontoller.quantity.value}',
                                        style: GoogleFonts.dmSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: increaseQuantity,
                                    child: Icon(Icons.arrow_right)),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  final selectedQuantity =
                                      tcontoller.quantity.value;
                                  if (trainingController.selectedCategory.value
                                              ?.duration ==
                                          null ||
                                      _character == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 1),
                                            content: Text('Select Category!')));
                                  } else if (selectedQuantity == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 1),
                                            content: Text('Enter Quantity!')));
                                  } else {
                                    var applicationFees = trainingController
                                        .selectedCategory
                                        .value
                                        ?.applicationFees;
                                    double applicationFeesDouble =
                                        applicationFees != null
                                            ? double.parse(
                                                applicationFees.toString())
                                            : 0.0;

                                    trainingController.addTocart(
                                      AddCart(
                                        deviceId: '',
                                        userId: 123456,
                                        trainingCourse: [
                                          TrainingCourse(
                                            type: trainingController
                                                .selectType.value,
                                            description: trainingController
                                                .selectedCategory
                                                .value
                                                ?.description,
                                            trainingCourseId: widget
                                                .trainingCourseDetail
                                                .trainingCourseId,
                                            trainingCourseName: widget
                                                .trainingCourseDetail
                                                .trainingCourseName,
                                            trainingCourseCategoryId:
                                                trainingController
                                                    .selectedCategory
                                                    .value
                                                    ?.trainingCourseCategoryId,
                                            categoryName: trainingController
                                                .selectCategory.value,
                                            quantity: tcontoller.quantity.value,
                                            price: applicationFeesDouble,
                                            amount: trainingController
                                                .priceList.value,
                                            fileName: widget
                                                .trainingCourseDetail.fileName,
                                            imageName: widget
                                                .trainingCourseDetail.imageName,
                                          ),
                                        ],
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 1),
                                            content:
                                                Text('Item added to Cart')));
                                  }

                                  trainingController.priceList.value = 0;
                                  tcontoller.quantity.value = 1;
                                  trainingController.selectedCategory.value =
                                      null;
                                  trainingController
                                      .selectedCategoryAfterNavigation
                                      .value = null;

                                  trainingController.fetchCategoryData(
                                      '${widget.trainingCourseId}');
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF0B8900),
                              ),
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.w,
                      ),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "> Type",
                          style: GoogleFonts.dmSans(
                            color: ColorResources.color294C73,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widget.isFail == false
                              ? RadioListTile<SingingCharacter>(
                                  activeColor: ColorResources.color294C73,
                                  title: Text(
                                    'Training with Examination',
                                    style: GoogleFonts.dmSans(
                                      color: ColorResources.colorBlack,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  value: SingingCharacter.training,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter? value) {
                                    print('examination value $value');
                                    setState(() {
                                      _character = value;
                                      valuefirst = false;
                                      valuesecond = false;
                                      updatePrice();
                                    });
                                  },
                                )
                              : Container(),
                          widget.isFail
                              ? RadioListTile<SingingCharacter>(
                                  activeColor: ColorResources.color294C73,
                                  title: Text(
                                    'Retake Only',
                                    style: GoogleFonts.dmSans(
                                      color: ColorResources.colorBlack,
                                      fontSize: 15.sp.h,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  value: SingingCharacter.retake,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter? value) {
                                    setState(() {
                                      _character = value;
                                      valuefirst = true;
                                      valuesecond = false;
                                      updatePrice();
                                    });
                                  },
                                )
                              : Container(),
                          widget.isFail
                              ? Row(
                                  children: <Widget>[
                                    SizedBox(width: 10),
                                    Checkbox(
                                      side: BorderSide(color: Colors.grey),
                                      activeColor: ColorResources.color294C73,
                                      value: _character ==
                                              SingingCharacter.training
                                          ? false
                                          : valuefirst,
                                      onChanged: _character ==
                                              SingingCharacter.training
                                          ? null
                                          : (bool? value) {
                                              setState(() {
                                                valuefirst = value!;
                                                updatePrice();
                                              });
                                            },
                                    ),
                                    Text(
                                      'Written',
                                      style: GoogleFonts.dmSans(
                                        color: ColorResources.colorBlack,
                                        fontSize: 17.sp.h,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Checkbox(
                                      side: BorderSide(color: Colors.grey),
                                      activeColor: ColorResources.color294C73,
                                      value: _character ==
                                              SingingCharacter.training
                                          ? false
                                          : valuesecond,
                                      onChanged: _character ==
                                              SingingCharacter.training
                                          ? null
                                          : (bool? value) {
                                              setState(() {
                                                valuesecond = value!;
                                                updatePrice();
                                              });
                                            },
                                    ),
                                    Text(
                                      'Practical',
                                      style: GoogleFonts.dmSans(
                                        color: ColorResources.colorBlack,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20.h,
              left: 20.w,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                  radius: 18.h,
                  backgroundColor: ColorResources.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 25.h,
                      color: ColorResources.colorBlack,
                    ),
                  ),
                ),
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        ),
        bottomNavigationBar: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(side: BorderSide.none),
                      backgroundColor: ColorResources.colorFF0950A0,
                    ),
                    onPressed: () {
                      Get.to(() => CartScreen(
                            isFromPurchase: true,
                          ));
                    },
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "My Cart",
                            style: GoogleFonts.dmSans(
                              color: ColorResources.whiteColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          trainingController.cartData.isNotEmpty
                              ? CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 12.r,
                                  child: Text(
                                    '${trainingController.cartData.length}',
                                    style: GoogleFonts.dmSans(
                                      color: ColorResources.colorBlack,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? () {}
                        : () async {
                            if (trainingController.selectedCategory.value ==
                                    null ||
                                _character == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Select Category!')));
                            } else if ((tcontoller.quantity.value == 0)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Enter Quantity!')));
                            } else {
                              // await trainingController.fetchCategoryData(
                              //     '${widget.trainingCourseDetail.trainingCourseId}',
                              //     isCategorySelected: true
                              //     // updatePrice,
                              //     );
                              setState(() => isLoading = true);

                              var applicationFees = trainingController
                                  .selectedCategory.value?.applicationFees;
                              double applicationFeesDouble =
                                  applicationFees != null
                                      ? double.parse(applicationFees.toString())
                                      : 0.0;
                              await trainingController.deleteItemCart();
                              await trainingController.addTocart(
                                AddCart(
                                  deviceId: '',
                                  userId: 123456,
                                  trainingCourse: [
                                    TrainingCourse(
                                      type: trainingController.selectType.value,
                                      description: trainingController
                                          .selectedCategory.value?.description,
                                      trainingCourseId: widget
                                          .trainingCourseDetail
                                          .trainingCourseId,
                                      trainingCourseName: widget
                                          .trainingCourseDetail
                                          .trainingCourseName,
                                      trainingCourseCategoryId:
                                          trainingController.selectedCategory
                                              .value?.trainingCourseCategoryId,
                                      categoryName: trainingController
                                          .selectCategory.value,
                                      quantity: tcontoller.quantity.value,
                                      price: applicationFeesDouble,
                                      amount:
                                          trainingController.priceList.value,
                                      fileName:
                                          widget.trainingCourseDetail.fileName,
                                      imageName:
                                          widget.trainingCourseDetail.imageName,
                                    ),
                                  ],
                                ),
                              );
                              // trainingController.selectedCategory.value = null;

                              // trainingController.selectedCategory.value = trainingController.selectedCategoryAfterNavigation.value;

                              // // trainingController.selectedCategory.value = trainingController.selectedCategoryAfterNavigation.value;
                              // print('${ trainingController.selectedCategoryAfterNavigation.value}');
                              // trainingController.update();

                              Get.to(() => BillingDetailsPage())?.then((e) {
                                setState(() => isLoading = false);
                              });
                            }
                            print('object sfgerf');
                          },
                    style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(side: BorderSide.none),
                      backgroundColor: Color(0xFFE5AA17),
                    ),
                    child: Text(
                      "Buy Now",
                      style: GoogleFonts.dmSans(
                        color: ColorResources.colorBlack,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePrice() {
    print('calling function');
    var applicationFees =
        trainingController.selectedCategory.value?.applicationFees ?? 0.0;
    var trainingwithExamFees =
        trainingController.selectedCategory.value?.trainingwithExamFees ?? 0.0;
    var retakewrittenFees =
        trainingController.selectedCategory.value?.retakeOnlyWritenFess ?? 0.0;
    var retakePracticalFees =
        trainingController.selectedCategory.value?.retakeOnlyPracticalFees ??
            0.0;
    var examinationFees =
        trainingController.selectedCategory.value?.examinationFees ?? 0.0;
    var certificationfees =
        trainingController.selectedCategory.value?.certificateFees ?? 0.0;

    double applicationFeesDouble = applicationFees != null
        ? double.parse(applicationFees.toString())
        : 0.0;
    double trainingwithExamFeesDouble = trainingwithExamFees != null
        ? double.parse(trainingwithExamFees.toString())
        : 0.0;
    double examinationFeesDouble = trainingwithExamFees != null
        ? double.parse(examinationFees.toString())
        : 0.0;
    double certificationFeesDouble = trainingwithExamFees != null
        ? double.parse(certificationfees.toString())
        : 0.0;
    double retakewrittenFeesDouble = retakewrittenFees != null
        ? double.parse(retakewrittenFees.toString())
        : 0.0;
    double retakePracticalFeesDouble = retakePracticalFees != null
        ? double.parse(retakePracticalFees.toString())
        : 0.0;

    double price = applicationFeesDouble;

    if (_character == SingingCharacter.training) {
      price =

          // applicationFeesDouble +
          trainingwithExamFeesDouble;

      // +
      // examinationFeesDouble +
      // certificationFeesDouble;
    } else if (_character == SingingCharacter.retake) {
      price = applicationFeesDouble;
      if (valuefirst) {
        price += retakewrittenFeesDouble;
      }
      if (valuesecond) {
        price += retakePracticalFeesDouble;
      }
    }

    trainingController.updatePrice(price);
    trainingController.updateSelected(
        _character == SingingCharacter.training ? "Training" : "Retake");
    tcontoller.totalPrice = price;
    print('price $price');
    trainingController.update();
  }
}
