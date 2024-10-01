import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/controller/tainning/training_home_controller.dart';
import 'package:darlsco/controller/tainning/trainnig_controller.dart';

import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/http/http_urls.dart';
import 'package:darlsco/model/training/get_trainee_details_model.dart';
import 'package:darlsco/model/training/location_list_model.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/training_phase2/datepicker.dart';
import 'package:darlsco/view/training_phase2/training_detail_page.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:search_map_location/utils/google_search/place_type.dart';

import '../../../http/aws_upload.dart';
import '../training_home_screen.dart';
import 'show_dialog_widget.dart';

File? image;
RxString imgUrl = ''.obs;
final _picker = ImagePicker();
Future<void> pickImageFromGallery() async {
  final XFile? pickedImage =
      await _picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    image = File(pickedImage.path);
    Get.back();

    print('image aws${await AwsUpload.uploadToAws(image!)}');
    var img = await AwsUpload.uploadToAws(image!);

    imgUrl.value = Uri.parse(img!).path;
  }
}

Future<void> pickImageFromCamera() async {
  final XFile? pickedImage =
      await _picker.pickImage(source: ImageSource.camera);
  if (pickedImage != null) {
    image = File(pickedImage.path);
    Get.back();

    print('image aws${await AwsUpload.uploadToAws(image!)}');
    var img = await AwsUpload.uploadToAws(image!);

    print(Uri.parse(img!).path);
    imgUrl.value = Uri.parse(img).path;
  }
}

Container trainingBackgroundLinearColor(
    {required BuildContext context, required Widget childWidget}) {
  return Container(
    width: MediaQuery.sizeOf(context).width.w,
    height: 30.h,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorResources.backgroundColors2)),
    child: childWidget,
  );
}

Widget servicesContainerWidget(
    {required BuildContext context,
    required String image,
    required String text}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        trainingBackgroundLinearColor(
          context: context,
          childWidget: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              text,
              style: TextStyle(
                color: ColorResources.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: Get.width < 700 ? 15.sp : 17.sp,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget gridViewWidget({
  required BuildContext context,
}) {
  final crossAxisCount = MediaQuery.of(context).size.width < 600 ? 2 : 4;
  return GridView.builder(
    itemCount: trainingController.trainingData.length,
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisExtent: MediaQuery.of(context).size.width < 850
          ? MediaQuery.of(context).size.height / 5.5
          : MediaQuery.of(context).size.height / 3.5,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
    ),
    itemBuilder: (context, index) {
      final training = trainingController.trainingData[index];

      return InkWell(
        onTap: () {
          Get.to(() => Training_Details(
                trainingCourseDetail: training,
                isFail: false,
                trainingCourseId: training.trainingCourseId,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(HttpUrls.imageBase +
                  trainingController.trainingData[index].fileName!),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              trainingBackgroundLinearColor(
                context: context,
                childWidget: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    training.trainingCourseName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorResources.whiteColor,
                      fontWeight: FontWeight.w800,
                      fontSize: Get.width < 700 ? 13.sp : 17.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget cartListViewWidget({
  required BuildContext context,
}) {
  TrainingControllerHomee trainingHomeController =
      Get.put(TrainingControllerHomee());
  return ListView.separated(
    separatorBuilder: (context, index) {
      return SizedBox(
        height: 16.h,
      );
    },
    itemCount: trainingHomeController.cartData.length,
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemBuilder: (context, index) {
      return cartDetailsWidget(
        // height: 150.h,
        index: index,
        courseName: trainingHomeController.cartData[index].trainingCourseName,
        amount:
            'AED ${double.parse(trainingHomeController.cartData[index].price) * double.parse(trainingHomeController.cartData[index].quantity.toString())}',
        quantity: trainingHomeController.cartData[index].quantity.toString(),
        categoryName: trainingHomeController.cartData[index].categoryName,
        fileName: trainingHomeController.cartData[index].fileName,
        imageName: trainingHomeController.cartData[index].imageName,
        amtColor: ColorResources.colorE5AA17,
        onTap: () {
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
                  'Are you sure you want to remove this course from the cart?',
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
                    onPressed: () {
                      trainingHomeController.deleteCartItem(
                          trainingHomeController.cartData[index].itemCartId);
                      Get.back();
                    },
                  ),
                ],
              );
            },
          );
        },
        context: context,
        isCartpage: true,
        textColor: ColorResources.colorBlack,
      );
    },
  );
  // return GetBuilder<TrainingControllerHomee>(
  //   init: TrainingControllerHomee(),
  //   builder: (controller) {
  //     if (controller.cartData.isNotEmpty) {

  //     } else {
  //       return Center(
  //         child: Text(
  //           'Empty cart',
  //           style: GoogleFonts.dmSans(
  //             color: ColorResources.colorBlack,
  //             fontSize: 16.sp.h,
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //       );
  //     }
  //   },
  // );
}

Widget cartDetailsWidget({
  required bool? isCartpage,
  required Color textColor,
  String? orderNumber,
  int index = 0,
  required String courseName,
  required String categoryName,
  required String amount,
  required String quantity,
  required String imageName,
  required String fileName,
  double? height,
  required BuildContext context,
  required void Function()? onTap,
  required Color? amtColor,
}) {
  final fullImageName = HttpUrls.imageBase + fileName;
  tcontoller.cartQuantity.value = int.parse(quantity);

  // if(isCartpage==true){
  //   tcontoller.cartQuantityList.value=List.generate(length, (index) => 0).toList();

  // }

  return GetBuilder<TrainingControllerHomee>(builder: (cartDataQuatity) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorResources.whiteColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  width: 90.h.w,
                  decoration: BoxDecoration(
                    color: ColorResources.colorD1D1D1,
                    image: DecorationImage(
                      image: NetworkImage(fullImageName),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (isCartpage == false)
                        Text(
                          orderNumber ?? '',
                          style: GoogleFonts.dmSans(
                            color: Colors.black,
                            fontSize: 14.sp.h,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        courseName,
                        style: GoogleFonts.dmSans(
                          color: ColorResources.color294C73,
                          fontSize: 14.sp.h,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      // if(isCartpage==false)
                      // SizedBox(
                      //   width: 200.w,
                      //   child: Text(
                      //   '${amount}',
                      //   style: GoogleFonts.dmSans(
                      //     color: ColorResources.color294C73,
                      //     fontSize: 14.sp.h,
                      //     fontWeight: FontWeight.w700,
                      //   ),
                      //                         ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              categoryName,
                              style: GoogleFonts.dmSans(
                                color: ColorResources.colorBlack,
                                fontSize: 14.sp.h,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          if (isCartpage != true)
                            Text(
                              'x$quantity',
                              style: GoogleFonts.dmSans(
                                color: ColorResources.color294C73,
                                fontSize: 14.sp.h,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                        ],
                      ),

                      SizedBox(
                        width: 8.w,
                      ),

                      if (isCartpage != false)
                        cartDataQuatity.cartData.isNotEmpty
                            ? Text(
                                (double.parse(cartDataQuatity
                                            .cartData[index].amount) *
                                        cartDataQuatity
                                            .cartData[index].quantity)
                                    .toStringAsFixed(2),
                                style: GoogleFonts.dmSans(
                                  color: amtColor,
                                  fontSize: 15.sp.h,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            : Container(),

                      // if (isCartpage != false)

                      // Row(children:[
                      //    InkWell(
                      //       onTap: ()async{
                      //         if(cartDataQuatity.cartData[index].quantity>1){
                      //           cartDataQuatity.cartData[index].quantity--;

                      //         var amount=  cartDataQuatity.calculateTotalPrice();

                      //           trainingController.updateItemCartQuatity(itemCartId:  cartDataQuatity.cartData[index].itemCartId, quantity:  cartDataQuatity.cartData[index].quantity, amount:amount );

                      //         }

                      //        trainingController.update();

                      //       },
                      //       child: Container(

                      //         color: const Color.fromARGB(255, 244, 242, 242),

                      //       width: 25.w,height: 25.w,

                      //        child: Center(child: Icon(Icons.remove,size: 20.sp,),),

                      //       ),
                      //     ),
                      //     overflow: TextOverflow.ellipsis,
                      //   )
                      // : Container(),

                      if (isCartpage != false)
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                if (cartDataQuatity.cartData[index].quantity >
                                    1) {
                                  cartDataQuatity.cartData[index].quantity--;

                                  var amount = double.parse(cartDataQuatity
                                          .cartData[index].price) *
                                      double.parse(cartDataQuatity
                                          .cartData[index].quantity
                                          .toString());
                                  trainingController.update();

                                  trainingController.updateItemCartQuatity(
                                    itemCartId: cartDataQuatity
                                        .cartData[index].itemCartId,
                                    quantity: cartDataQuatity
                                        .cartData[index].quantity,
                                    amount: amount,
                                  );
                                }
                                // trainingController.getItemCart();
                                trainingHomeController.calculateTotalPrice();
                                trainingController.update();
                              },
                              child: Container(
                                width: 50.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 244, 242, 242),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.w),
                                        bottomLeft: Radius.circular(10.w))),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Container(
                              width: 50.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: ColorResources.color294C73),
                              ),
                              child: Center(
                                child: Text(
                                    '${cartDataQuatity.cartData[index].quantity}'),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            InkWell(
                              onTap: () {
                                cartDataQuatity.cartData[index].quantity++;
                                var amount = double.parse(
                                        cartDataQuatity.cartData[index].price) *
                                    double.parse(cartDataQuatity
                                        .cartData[index].quantity
                                        .toString());
                                trainingController.update();

                                trainingController.updateItemCartQuatity(
                                    itemCartId: cartDataQuatity
                                        .cartData[index].itemCartId,
                                    quantity: cartDataQuatity
                                        .cartData[index].quantity,
                                    amount: amount);

                                trainingController.update();
                              },
                              child: Container(
                                width: 50.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 244, 242, 242),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.w),
                                        bottomRight: Radius.circular(10.w))),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  size: 20.sp,
                                )),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
                Column(
                  children: [
                    if (isCartpage == true)
                      Material(
                        color: ColorResources.whiteColor,
                        child: InkWell(
                          onTap: onTap,
                          splashColor: ColorResources.colorDCCCFF,
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                            backgroundColor: ColorResources.whiteColor,
                            child: Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.red,
                              size: 30.w,
                            ),
                          ),
                        ),
                      )
                    // const Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  });
}

Widget locationTileWidget({
  required Color textColor,
  String? orderNumber,
  int index = 0,
  required String courseName,
  required String categoryName,
  required String quantity,
  required String imageName,
  required String fileName,
  required String locationName,
  required BuildContext context,
  required void Function()? onTap,
  required Color? amtColor,
}) {
  final fullImageName = HttpUrls.imageBase + fileName;
  tcontoller.cartQuantity.value = int.parse(quantity);

  // if(isCartpage==true){
  //   tcontoller.cartQuantityList.value=List.generate(length, (index) => 0).toList();

  // }

  return GetBuilder<TrainingControllerHomee>(builder: (cartDataQuatity) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 130.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorResources.whiteColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  width: 90.h.w,
                  decoration: BoxDecoration(
                    color: ColorResources.colorD1D1D1,
                    image: DecorationImage(
                      image: NetworkImage(fullImageName),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        orderNumber ?? '',
                        style: GoogleFonts.dmSans(
                          color: ColorResources.colorBlack,
                          fontSize: 15.sp.h,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        courseName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.dmSans(
                          color: ColorResources.color294C73,
                          fontSize: 15.sp.h,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(
                      //       width: 200.w,
                      //       child: Text(
                      //         '$categoryName',
                      //         style: GoogleFonts.dmSans(
                      //           color: textColor,
                      //           fontSize: 14.sp.h,
                      //           fontWeight: FontWeight.w700,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              locationName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.dmSans(
                                color: textColor,
                                fontSize: 14.sp.h,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            'x$quantity',
                            style: GoogleFonts.dmSans(
                              color: ColorResources.color294C73,
                              fontSize: 14.sp.h,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  });
}

Widget authenticationImageWidget(
    {required BuildContext context,
    required bool? isPhoneNumberPage,
    required String image}) {
  return Container(
    height: 360.h,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              image,
            ),
            fit: BoxFit.contain),
        color: ColorResources.whiteColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(100),
        )),
    child: isPhoneNumberPage == true
        ? Padding(
            padding: EdgeInsets.only(top: 32.h, left: 16.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  child: InkWell(
                    splashColor: ColorResources.colorBlack,
                    borderRadius: BorderRadius.circular(10),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xffd8eaff),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : null,
  );
}

Widget elevatedButtonWidget(
    {required BuildContext context,
    required String text,
    required double? width,
    required Color? backgroundColor,
    required Color? txtColor,
    required void Function()? onPressed}) {
  return SizedBox(
    height: 55.h.w,
    width: width,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const BeveledRectangleBorder(),
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            color: txtColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        )),
  );
}

Widget textFieldWidget(
    {required BuildContext context,
    required TextEditingController? controller}) {
  return Row(
    children: [
      Container(
        height: 48,
        decoration: BoxDecoration(
            color: ColorResources.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        child: Obx(
          () => CountryCodePicker(
            padding: const EdgeInsets.all(0),
            onChanged: (value) {
              print(value);
              loginController.countryCode.value = value.toString();
            },
            initialSelection: homeController.currentCountryCode.value == ''
                ? 'AE'
                : homeController.currentCountryCode.value,
            favorite: const ['+91', '+971'],
            showCountryOnly: false,
            textStyle: GoogleFonts.dmSans(
              color: ColorResources.colorA5A5A5,
              fontSize: 14.sp.h,
              fontWeight: FontWeight.w400,
            ),
            showFlag: true,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
          ),
        ),
      ),
      const SizedBox(
        width: 8,
      ),
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 48,
            child: TextFormField(
              style: GoogleFonts.dmSans(
                color: ColorResources.colorA5A5A5,
                fontSize: 15.sp.h,
                fontWeight: FontWeight.w400,
              ),
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: InputDecoration(
                fillColor: ColorResources.whiteColor,
                hintText: 'Enter Phone Number',
                hintStyle: GoogleFonts.dmSans(
                  color: ColorResources.colorA5A5A5,
                  fontSize: 14.sp.h,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                filled: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      // const Expanded(
      //   child: SizedBox(),
      // )
    ],
  );
}

Widget richTextWidget({required String text, required String spanText}) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: text,
          style: GoogleFonts.dmSans(
              color: ColorResources.color294C73,
              fontSize: 32.sp.h,
              fontWeight: FontWeight.w900),
        ),
        TextSpan(
          text: spanText,
          style: GoogleFonts.dmSans(
            fontSize: 32.sp.h,
            fontWeight: FontWeight.w800,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = ColorResources.color294C73,
          ),
        ),
      ],
    ),
  );
}

Widget verificationContentWidget(
    {required String text,
    required String spanText,
    required String title,
    required bool isphone}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      richTextWidget(text: text, spanText: spanText),
      Text(
        title,
        style: GoogleFonts.dmSans(
            color: ColorResources.color294C73,
            fontSize: 15.sp.h,
            fontWeight: FontWeight.w400),
      ),
      isphone == true
          ? SizedBox(
              height: 48.h,
            )
          : SizedBox(
              height: 24.h,
            ),
      isphone == true
          ? Text(
              'Mobile Number',
              style: GoogleFonts.dmSans(
                color: ColorResources.color294C73,
                fontSize: 16.sp.h,
                fontWeight: FontWeight.w800,
              ),
            )
          : const SizedBox(),
    ],
  );
}

Widget billTextStylewidget(
    {required String text,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w800}) {
  return Text(
    text,
    // style: TextStyle(
    //   fontFamily: "DM Sans",
    // ),
    style: GoogleFonts.dmSans(
      color: ColorResources.colorBlack,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    ),
  );
}

double calculateTotalPrice() {
  double applicationFees = 0.0;
  double examinationFees = 0.0;
  double certificationFees = 0.0;

  final TrainingControllerHomee pricecontroller =
      Get.put(TrainingControllerHomee());

  if (pricecontroller.priceDetailsData.isNotEmpty) {
    var priceDetails = pricecontroller.priceDetailsData[0];

    applicationFees = double.tryParse(priceDetails.applicationFees) ?? 0.0;
    examinationFees = double.tryParse(priceDetails.examinationFees) ?? 0.0;
    certificationFees = double.tryParse(priceDetails.certificateFees) ?? 0.0;
  }

  double total = applicationFees + examinationFees + certificationFees;

  return total;
}

double calculateVat(double totalPrice) {
  return totalPrice * 0.05;
}

double calculateSubtotal() {
  double applicationFees = 0.0;
  double examinationFees = 0.0;
  double certificationFees = 0.0;

  final TrainingControllerHomee pricecontroller =
      Get.put(TrainingControllerHomee());

  if (pricecontroller.priceDetailsData.isNotEmpty) {
    var priceDetails = pricecontroller.priceDetailsData[0];

    applicationFees = double.tryParse(priceDetails.applicationFees) ?? 0.0;
    examinationFees = double.tryParse(priceDetails.examinationFees) ?? 0.0;
    certificationFees = double.tryParse(priceDetails.certificateFees) ?? 0.0;
  }

  double subtotal = applicationFees + examinationFees + certificationFees;

  return subtotal;
}

double calculateTransactionFee(double totalPrice) {
  return totalPrice * 0.025;
}

double calculateListTotal() {
  double subtotal = calculateSubtotal();
  double vat = calculateVat(subtotal);
  double transactionFee = calculateTransactionFee(subtotal);

  double grandTotal = subtotal + vat + transactionFee;

  return grandTotal;
}

Widget billPriceTextStyleWidget(
    {required String text,
    double fontSize = 15,
    FontWeight fontweight = FontWeight.w800}) {
  return SizedBox(
    width: 220.w.h,
    child: Text(
      text,
      style: GoogleFonts.dmSans(
        color: ColorResources.colorBlack,
        fontSize: fontSize.sp,
        fontWeight: fontweight,
      ),
    ),
  );
}

Widget billWidget({
  required String serviceName,
  required String servicePrice,
  required String category,
  required int quantity,
  required String applicationFee,
  required String examFee,
  required String certificateFee,
  required String vat,
}) {
  // double totalPrice = calculateTotalPrice();

  // double transactionFee = calculateTransactionFee(totalPrice);
  double grandTotal = calculateListTotal();
  double subTotal = (double.parse(applicationFee) +
          double.parse(examFee) +
          double.parse(certificateFee)) +
      (quantity * double.parse(servicePrice));
  double totalPriceVat = (subTotal * (double.parse(vat) / 100));
  double totalpriceFee = (subTotal * (double.parse('2.5') / 100));
  tcontoller.grandTotal.value = subTotal + totalPriceVat + totalpriceFee;
  tcontoller.totalvat.value = vat;
  tcontoller.update();
  //
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          billPriceTextStyleWidget(text: serviceName),
          SizedBox(
            width: 85.w.h,
            child: billPriceTextStyleWidget(text: 'AED $servicePrice'),
          )
        ],
      ),
      SizedBox(
        height: 8.h,
      ),
      billTextStylewidget(text: 'Category - $category'),
      SizedBox(
        height: 4.h,
      ),
      billTextStylewidget(text: 'Quantity - $quantity'),
      SizedBox(
        height: 4.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          billTextStylewidget(text: 'Application Fees'),
          SizedBox(
            width: 85.w.h,
            child: billPriceTextStyleWidget(text: 'AED $applicationFee'),
          )
        ],
      ),
      SizedBox(
        height: 4.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          billTextStylewidget(text: 'Examination Fees'),
          SizedBox(
            width: 85.w.h,
            child: billPriceTextStyleWidget(text: 'AED $examFee'),
          )
        ],
      ),
      SizedBox(
        height: 4.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          billTextStylewidget(text: 'Certificate Fees'),
          SizedBox(
            width: 85.w.h,
            child: billPriceTextStyleWidget(text: 'AED $certificateFee'),
          )
        ],
      ),
      SizedBox(
        height: 24.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          billPriceTextStyleWidget(text: 'Sub Total'),
          SizedBox(
            width: 85.w.h,
            child: billPriceTextStyleWidget(text: 'AED $subTotal'),
          )
        ],
      ),
      SizedBox(
        height: 24.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          billPriceTextStyleWidget(text: 'VAT - $vat%'),
          SizedBox(
            width: 85.w.h,
            child: billPriceTextStyleWidget(
                text: 'AED ${totalPriceVat.toStringAsFixed(2)}'),
          )
        ],
      ),
      SizedBox(height: 24.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          billPriceTextStyleWidget(text: 'Transaction Fee - 2.5%'),
          SizedBox(
            width: 85.w.h,
            child: billPriceTextStyleWidget(
                text: 'AED ${totalpriceFee.toStringAsFixed(2)}'),
          ),
        ],
      ),
      SizedBox(height: 16.h),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     billPriceTextStyleWidget(text: 'Total'),
      //     SizedBox(
      //       width: 85.w.h,
      //       child: billPriceTextStyleWidget(
      //           text: 'AED ${grandTotal.toStringAsFixed(2)}'),
      //     ),
      //   ],
      // ),
    ],
  );
}

Widget billCartWidget({
  required String serviceName,
  required String servicePrice,
  required String category,
  required int quantity,
  required String applicationFee,
  required String examFee,
  required String certificateFee,
  required String vat,
  required String subTotal,
  required double totalPriceVat,
  required double transactionFee,
  required String applicationVatpercentage,
  required String examinationVatpercentage,
  required String certificateVatpercentage,
  required String applicationVat,
  required String examinationVat,
  required String certificateVat,
  required String transactionFeeVat,
  required String courseVat,
  required String courseVatPer,
}) {
  // // double totalPrice = calculateTotalPrice();

  // // double transactionFee = calculateTransactionFee(totalPrice);
  // double grandTotal = calculateListTotal();
  // double subTotal = (double.parse(applicationFee) +
  //         double.parse(examFee) +
  //         double.parse(certificateFee)) +
  //     (quantity * double.parse(servicePrice));
  // double totalPriceVat = (subTotal * (double.parse(vat) / 100));
  // double transactionFee = (subTotal * (double.parse('2.5') / 100));
  // tcontoller.grandTotal.value = subTotal + totalPriceVat + transactionFee;
  // tcontoller.totalvat.value = vat;
  // tcontoller.update();
  //
  return GetBuilder<TrainingControllerHomee>(builder: (context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        billPriceTextStyleWidget(text: serviceName, fontSize: 16),
        SizedBox(
          height: 15.h,
        ),

        billTextStylewidget(
            text: 'Category - $category',
            fontSize: 14,
            fontWeight: FontWeight.w500),
        SizedBox(
          height: 4.h,
        ),
        billTextStylewidget(
            text: 'Quantity - $quantity',
            fontSize: 14,
            fontWeight: FontWeight.w500),
        SizedBox(
          height: 14.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            billTextStylewidget(text: 'Course Fee', fontSize: 16),
            SizedBox(
              width: 120.w.h,
              child: billPriceTextStyleWidget(
                  text: 'AED $servicePrice', fontSize: 16),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            billTextStylewidget(
                text: 'VAT $courseVatPer%',
                fontSize: 14,
                fontWeight: FontWeight.w500),
            SizedBox(
              width: 120.w.h,
              child: billPriceTextStyleWidget(
                  text: 'AED $courseVat',
                  fontSize: 14,
                  fontweight: FontWeight.w500),
            )
          ],
        ),

        SizedBox(
          height: 12.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            billTextStylewidget(
                text: 'Application Fee',
                fontSize: 16,
                fontWeight: FontWeight.w800),
            SizedBox(
              width: 120.w.h,
              child: billPriceTextStyleWidget(
                  text: 'AED $applicationFee', fontSize: 16),
            )
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            billTextStylewidget(
                text: 'VAT $applicationVatpercentage%',
                fontSize: 14,
                fontWeight: FontWeight.w500),
            SizedBox(
              width: 120.w.h,
              child: billPriceTextStyleWidget(
                  text: 'AED $applicationVat',
                  fontSize: 14,
                  fontweight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            billTextStylewidget(
                text: 'Examination Fee',
                fontSize: 16,
                fontWeight: FontWeight.w800),
            SizedBox(
              width: 120.w.h,
              child: billPriceTextStyleWidget(
                  text: 'AED $examFee',
                  fontSize: 16,
                  fontweight: FontWeight.w800),
            )
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            billTextStylewidget(
                text: 'VAT $examinationVatpercentage%',
                fontSize: 14,
                fontWeight: FontWeight.w500),
            SizedBox(
              width: 120.w.h,
              child: billPriceTextStyleWidget(
                  text: 'AED $examinationVat',
                  fontSize: 14,
                  fontweight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            billTextStylewidget(
                text: 'Certificate Fee ',
                fontSize: 16,
                fontWeight: FontWeight.w800),
            SizedBox(
              width: 120.w.h,
              child: billPriceTextStyleWidget(
                  text: 'AED $certificateFee',
                  fontSize: 16,
                  fontweight: FontWeight.w800),
            )
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            billTextStylewidget(
                text: 'VAT $certificateVatpercentage%',
                fontSize: 14,
                fontWeight: FontWeight.w500),
            SizedBox(
              width: 120.w.h,
              child: billPriceTextStyleWidget(
                  text: 'AED $certificateVat',
                  fontweight: FontWeight.w500,
                  fontSize: 14),
            )
          ],
        ),
        SizedBox(
          height: 24.h,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     billPriceTextStyleWidget(text: 'Sub Total'),
        //     SizedBox(
        //       width: 85.w.h,
        //       child: billPriceTextStyleWidget(text: 'AED $subTotal'),
        //     )
        //   ],
        // ),
        // SizedBox(
        //   height: 24.h,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     billPriceTextStyleWidget(text: 'Total Vat'),
        //     SizedBox(
        //       width: 85.w.h,
        //       child: billPriceTextStyleWidget(text: 'AED $totalPriceVat'),
        //     )
        //   ],
        // ),
        // SizedBox(height: 24.h),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     billPriceTextStyleWidget(
        //         text: 'Transaction Fee-$transactionFeeVat%'),
        //     SizedBox(
        //       width: 85.w.h,
        //       child: billPriceTextStyleWidget(text: 'AED ${transactionFee}'),
        //     ),
        //   ],
        // ),
        SizedBox(height: 16.h),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     billPriceTextStyleWidget(text: 'Total'),
        //     SizedBox(
        //       width: 85.w.h,
        //       child: billPriceTextStyleWidget(
        //           text: 'AED ${grandTotal.toStringAsFixed(2)}'),
        //     ),
        //   ],
        // ),
      ],
    );
  });
}

Widget containerWidget({
  required String text,
  required double height,
  required double width,
  required Color textColor,
  required Color bgColor,
}) {
  return Container(
    height: height,
    width: width,
    decoration:
        BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16)),
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.dmSans(
          color: textColor,
          fontSize: 10.sp.h,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Widget disabledDatePickerWidget({required String text}) {
  return SizedBox(
    child: TextField(
      readOnly: true,
      controller: TextEditingController(text: text),
      style: GoogleFonts.dmSans(
        color: ColorResources.colorA5A5A5,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFCECECE),
          ), // Set border color here
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFCECECE),
          ),
        ),
        hintText: 'Select date',
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.calendar_month_outlined,
            color: Color(0xFF294C73),
          ),
          onPressed: () {},
        ),
      ),
    ),
  );
}

Widget bottomBillWidget({
  required BuildContext context,
  required String btnText,
  required String totalPrice,
  required void Function()? onPressed,
  required Color bgColor,
  required String subTotal,
  required String totalVat,
  required String serviceTax,
  required String transactionFee,
}) {
  print('tcontroller ${tcontoller.grandTotal}');

  return Container(
    height: subTotal.isEmpty ? 125.w.h : 211.w.h,
    decoration: const BoxDecoration(
      color: Color(0xFFC3DEFD),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (subTotal.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sub Total',
                        style: GoogleFonts.dmSans(
                          color: ColorResources.colorFF0950A0,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 8.w.h,
                      ),
                      Text(
                        'Total Vat',
                        style: GoogleFonts.dmSans(
                          color: ColorResources.colorFF0950A0,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 8.w.h,
                      ),
                      Text(
                        'Processing Fee ${(transactionFee)}% ',
                        style: GoogleFonts.dmSans(
                          color: ColorResources.colorFF0950A0,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 8.w.h,
                      ),
                      Text(
                        'Total',
                        style: GoogleFonts.dmSans(
                          color: ColorResources.colorFF0950A0,
                          fontSize: 19.sp.h,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AED $subTotal',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
                          color: ColorResources.colorFF0950A0,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 8.w.h,
                      ),
                      Text(
                        'AED $totalVat',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
                          color: ColorResources.colorFF0950A0,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 8.w.h,
                      ),
                      Text(
                        'AED $serviceTax',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
                          color: ColorResources.colorFF0950A0,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 8.w.h,
                      ),
                      Text(
                        'AED $totalPrice',
                        style: GoogleFonts.dmSans(
                          color: ColorResources.colorFF0950A0,
                          fontSize: 19.sp.h,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

        // if(subTotal.isNotEmpty)    Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Container(
        //         // height: 70.w.h,
        //         decoration: const BoxDecoration(
        //           color: Color(0xFFC3DEFD),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 12),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 'Sub Total',
        //                 style: GoogleFonts.dmSans(
        //                   color: ColorResources.colorFF0950A0,
        //                   fontSize: 16.sp.h,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               ),
        //               Text(
        //                 'AED $subTotal',
        //                 textAlign: TextAlign.left,
        //                 style: GoogleFonts.dmSans(
        //                   color: ColorResources.colorFF0950A0,
        //                   fontSize: 16.sp.h,
        //                   fontWeight: FontWeight.w700,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),

        //   if(subTotal.isNotEmpty)  Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Container(
        //         // height: 70.w.h,
        //         decoration: const BoxDecoration(
        //           color: Color(0xFFC3DEFD),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 12),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 'Total Vat',
        //                 style: GoogleFonts.dmSans(
        //                   color: ColorResources.colorFF0950A0,
        //                   fontSize: 16.sp.h,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               ),
        //               Text(
        //                 'AED $totalVat',
        //                  textAlign: TextAlign.left,
        //                 style: GoogleFonts.dmSans(
        //                   color: ColorResources.colorFF0950A0,
        //                   fontSize: 16.sp.h,
        //                   fontWeight: FontWeight.w700,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),

        //     if(subTotal.isNotEmpty)    Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Container(
        //         // height: 70.w.h,
        //         decoration: const BoxDecoration(
        //           color: Color(0xFFC3DEFD),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 12),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 'Transaction Fee ',
        //                 style: GoogleFonts.dmSans(
        //                   color: ColorResources.colorFF0950A0,
        //                   fontSize: 16.sp.h,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               ),
        //               Text(
        //                 'AED ${( (double.parse(subTotal)   *double.parse(serviceTax.toString()))/100)}',
        //                 textAlign: TextAlign.left,
        //                 style: GoogleFonts.dmSans(
        //                   color: ColorResources.colorFF0950A0,
        //                   fontSize: 16.sp.h,
        //                   fontWeight: FontWeight.w700,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),

        if (subTotal.isEmpty)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: subTotal.isNotEmpty ? 40 : 70.w.h,
              decoration: const BoxDecoration(
                color: Color(0xFFC3DEFD),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.dmSans(
                        color: ColorResources.colorFF0950A0,
                        fontSize: 19.sp.h,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'AED ${double.parse(totalPrice).toStringAsFixed(2)}',
                      style: GoogleFonts.dmSans(
                        color: ColorResources.colorFF0950A0,
                        fontSize: 19.sp.h,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        elevatedButtonWidget(
          context: context,
          width: Get.width,
          backgroundColor: ColorResources.colorE5AA17,
          text: btnText,
          onPressed: onPressed,
          txtColor: ColorResources.colorBlack,
        ),
      ],
    ),
  );
}

Widget textButtonWidget(
    {required String text, required void Function()? onPressed, Color? color}) {
  return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          color: color,
          fontSize: 14.sp.h,
          fontWeight: FontWeight.w700,
        ),
      ));
}

Widget cardDetailsWidget(
    {required bool? clicked, required void Function(bool?)? onChanged}) {
  return Container(
    height: 72.h,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/visa_image.png'),
          Text(
            '******9856',
            style: GoogleFonts.dmSans(
              color: ColorResources.colorA5A5A5,
              fontSize: 14.sp.h,
              fontWeight: FontWeight.w400,
            ),
          ),
          Radio(
            value: true,
            groupValue: clicked,
            onChanged: onChanged,
            activeColor: ColorResources.color294C73,
          ),
        ],
      ),
    ),
  );
}

Widget textFieldTraineeWidget(
    {required String hintText,
    required TextEditingController? controller,
    required bool? enabled,
    TextInputType? keyboardType,
    FocusNode? focusNode,
    String? errorText,
    int? maxLength,
    void Function(String)? onChanged,
    String? Function(String?)? validator}) {
  return SizedBox(
    height: 78.h.w,
    child: TextFormField(
      maxLength: maxLength,
      focusNode: focusNode,
      enabled: enabled,
      controller: controller,
      onChanged: onChanged,
      cursorColor: ColorResources.color294C73,
      cursorWidth: .90,

      style: GoogleFonts.dmSans(
        color: ColorResources.colorBlack,
        fontSize: 14.sp.h,
        fontWeight: FontWeight.w400,
      ),

      keyboardType: keyboardType,
      // validator: validator,
      decoration: InputDecoration(
        errorText: errorText,

        // counterText: '',
        contentPadding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 16.w),
        hintText: hintText,
        hintStyle: GoogleFonts.dmSans(
          color: ColorResources.colorA5A5A5,
          fontSize: 14.sp.h,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorResources.colorA5A5A5,
            width: 1.1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorResources.colorA5A5A5,
            width: 1.1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}

Widget traineeDetailsWidget(
    {required BuildContext context,
    required bool? isTraineeView,
    GetTraineeDetailModel? traineeDetailModel,
    LocationListModel? selectedLocation,
    Prediction? selectedLocationLatLong,
    void Function(LocationListModel?)? onChanged,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController dobController,
    required TextEditingController contactController,
    required TextEditingController emiratedIdController,
    required TextEditingController employeeIdcontroller,
    required TextEditingController applicationIdController,
    required TextEditingController emailController,
    required TextEditingController customLocationController,
    required List<String> imageListUrl,
    bool? isDropdownEnabled,
    bool? enabled,
    required int index,
    List<LocationListModel>? locList,
    required String traineecount}) {
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();
  final FocusNode contactFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode customLocationFocusNode = FocusNode();
  final FocusNode employeeIdFocusNode = FocusNode();
  final FocusNode applicationIdFocusNode = FocusNode();
  final FocusNode emiratedIdFocusNode = FocusNode();

  // void requestCustomLocationFocus() {
  //   FocusScope.of(context).requestFocus(customLocationFocusNode);
  // }

  String convertDate(String date) {
    if (date == 'null' || date.isEmpty) return 'not available';
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    return formattedDate;
  }

  return Form(
    child: Container(
      decoration: BoxDecoration(
        color: ColorResources.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: isTraineeView == false
              ? Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Container(
                    //       height: 15.h.w,
                    //       width: 20.w.h,
                    //       decoration: const BoxDecoration(
                    //           image: DecorationImage(
                    //               image: AssetImage('assets/images/icon.png'),
                    //               fit: BoxFit.contain)),
                    //     ),
                    //     SizedBox(
                    //       width: 6.w,
                    //     ),
                    //     Text(
                    //       traineecount,
                    //       style: GoogleFonts.dmSans(
                    //         color: ColorResources.color294C73,
                    //         fontSize: 15.sp.h,
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15.h.w,
                          width: 20.w.h,
                          child: Icon(
                            Icons.person_4_rounded,
                            size: 27.w,
                            color: ColorResources.color294C73,
                          ),
                          // decoration: const BoxDecoration(
                          //     image: DecorationImage(
                          //         image: AssetImage('assets/images/icon.png'),
                          //         fit: BoxFit.contain)),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15.w),
                          child: Text(
                            traineecount.toString(),
                            style: GoogleFonts.dmSans(
                              color: ColorResources.color294C73,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.w,
                    ),

                    GetBuilder<TrainingControllerHomee>(builder: (data) {
                      return Stack(
                        children: [
                          SizedBox(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                height: 100.r,
                                width: 100.r,
                                decoration:
                                    const BoxDecoration(color: Colors.grey),
                                child: image != null &&
                                        imageListUrl[index] != 'empty'
                                    ? Image.network(
                                        '${HttpUrls.imageBase}${imageListUrl[index].substring(1)}',
                                        fit: BoxFit.cover)
                                    : const Icon(
                                        Icons.person_2,
                                        size: 80,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ShowDialogWidget(
                                      fromCamera: () async {
                                        await pickImageFromCamera();

                                        imageListUrl[index] = imgUrl.value;
                                        print(
                                            'trainee//////////////////// url ${trainingController.traineeImgUrl}');
                                        trainingController.update();
                                      },
                                      fromGallery: () async {
                                        await pickImageFromGallery();

                                        print(
                                            'trainee//////////////////// url ${trainingController.traineeImgUrl}');
                                        print('image url $imageListUrl');
                                        imageListUrl[index] = imgUrl.value;

                                        trainingController.update();
                                        print('image url $imageListUrl');
                                      },
                                    );
                                  },
                                );
                              },
                              child: const CircleAvatar(
                                backgroundColor: ColorResources.color294C73,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: ColorResources.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),

                    SizedBox(
                      height: 24.w,
                    ),
                    rowField(
                        maxLength: 50,
                        title: 'First Name',
                        context: context,
                        controller: firstNameController,
                        focusNode: firstNameFocusNode,
                        enabled: enabled,
                        hintText: 'Enter First Name'),
                    SizedBox(
                      height: 16.w,
                    ),
                    rowField(
                        maxLength: 50,
                        title: 'Last Name',
                        context: context,
                        controller: lastNameController,
                        focusNode: lastNameFocusNode,
                        enabled: enabled,
                        hintText: 'Enter Last Name'),
                    SizedBox(
                      height: 16.w,
                    ),
                    // dobWidget(context: context),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'DOB',
                            style: GoogleFonts.dmSans(
                              color: ColorResources.color294C73,
                              fontSize: 14.sp.h,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.7.w,
                          child: SizedBox(
                            height: 54.h.w,
                            child: TextField(
                              style: TextStyle(fontSize: 12.sp),
                              controller: dobController,
                              focusNode: dobFocusNode,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  size: 14.sp,
                                  color: ColorResources.color294C73,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: ColorResources.colorA5A5A5,
                                  width: 1.1,
                                )),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: ColorResources.colorA5A5A5,
                                  width: 1.1,
                                )),
                                hintText: 'Enter DOB',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                hintStyle: GoogleFonts.dmSans(
                                  color: ColorResources.colorA5A5A5,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime today = DateTime.now();
                                DateTime initialDate = DateTime(
                                    today.year - 18, today.month, today.day);
                                DateTime firstDate = DateTime(
                                    today.year - 100, today.month, today.day);
                                DateTime lastDate = initialDate;

                                DateTime? pickedDate = await showDatePicker(
                                  barrierDismissible: false,
                                  context: context,
                                  initialDate: initialDate,
                                  firstDate: firstDate,
                                  lastDate: lastDate,
                                );

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  DateTime parsedDate =
                                      DateTime.parse(formattedDate);
                                  String newDate = DateFormat('dd/MM/yyyy')
                                      .format(parsedDate);
                                  dobController.text = newDate;
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Contact No. ',
                            style: GoogleFonts.dmSans(
                              color: ColorResources.color294C73,
                              fontSize: 14.sp.h,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.7.w,
                              height: 54.h.w,
                              child: TextField(
                                // maxLength: 10,
                                keyboardType: TextInputType.number,
                                controller: contactController,
                                focusNode: contactFocusNode,
                                style: TextStyle(fontSize: 12.sp),
                                decoration: InputDecoration(
                                  hintText: 'Enter Contact No',
                                  hintStyle: const TextStyle(
                                    color: ColorResources.colorA5A5A5,
                                  ),
                                  counterText: '',
                                  prefixIcon: Obx(
                                    () => CountryCodePicker(
                                      textStyle: GoogleFonts.dmSans(
                                        color: ColorResources.colorBlack,
                                        fontSize: 14.sp.h,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      showFlag: false,
                                      padding: const EdgeInsets.all(0),
                                      onChanged: (value) {
                                        print(value);

                                        loginController.countryCode.value =
                                            value.toString();
                                      },
                                      initialSelection: homeController
                                                  .currentCountryCode.value ==
                                              ''
                                          ? 'AE'
                                          : homeController
                                              .currentCountryCode.value,
                                      favorite: const ['+91', '+971'],
                                      showCountryOnly: false,
                                      showOnlyCountryWhenClosed: false,
                                      alignLeft: false,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 10),
                                  // labelText: 'Enter phone number',
                                  labelStyle: const TextStyle(
                                    color: ColorResources.colorA5A5A5,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: ColorResources.colorA5A5A5,
                                    width: 1.1,
                                  )),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: ColorResources.colorA5A5A5,
                                    width: 1.1,
                                  )),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorResources.colorA5A5A5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32.w,
                    ),
                    // rowField(
                    //     title: 'Contact No.',
                    //     keyboardType: TextInputType.phone,
                    //     context: context,
                    //     enabled: enabled,
                    //     controller: contactController,
                    //     hintText: 'Enter phone number'),
                    rowField(
                        maxLength: 50,
                        title: 'Email ID',
                        context: context,
                        enabled: enabled,
                        focusNode: emailFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        controller: emailController,
                        hintText: 'Enter Email ID'),
                    SizedBox(
                      height: 16.w,
                    ),
                    // rowField(
                    //     maxLength: 10,
                    //     title: 'Application No.',
                    //     enabled: enabled,
                    //     context: context,
                    //     controller: applicationIdController,
                    //     hintText: 'Enter Application No'),
                    // SizedBox(
                    //   height: 16.w,
                    // ),

                    // rowField(
                    //     maxLength: 10,
                    //     title: 'Trainee ID',
                    //     keyboardType: null,
                    //     enabled: enabled,
                    //     context: context,
                    //     controller: employeeIdcontroller,
                    //     hintText: 'Enter Trainee ID'),
                    // SizedBox(
                    //   height: 16.w,
                    // ),

                    rowField(
                        title: 'Emirates ID',
                        maxLength: 18,
                        keyboardType: TextInputType.number,
                        enabled: enabled,
                        context: context,
                        controller: emiratedIdController,
                        focusNode: emiratedIdFocusNode,
                        onChanged: (value) {
                          if (value.length == 18) {
                            trainingController.getTraineeDetailsByEmiratesId(
                                emiratesId: value,
                                firstNameController: firstNameController,
                                lastNameController: lastNameController,
                                dobController: dobController,
                                contactNumberController: contactController,
                                emailIdController: emailController,
                                employeeIdController: employeeIdcontroller);
                          }
                        },

                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter emirated Id';
                        //   }

                        //   if (value.length < 10) {
                        //     return 'Please enter a valid Emirates Id';
                        //   }
                        //   return null;
                        // },
                        hintText: 'Enter Emirates ID'),
                    SizedBox(
                      height: 16.w,
                    ),
                    rowLocationWidget(
                      isDropdownEnabled: isDropdownEnabled!,
                      context: context,
                      selectedLocation: selectedLocation,
                      locList: locList!,
                      onChanged: onChanged!,
                    ),

                    SizedBox(
                      height: 16.w,
                    ),

//                    DropdownButtonHideUnderline(
//         child: DropdownButton2<String>(
//           isExpanded: true,
//           hint: Text(
//             'Select Item',
//             style: TextStyle(
//               fontSize: 14,
//               color: Theme.of(context).hintColor,
//             ),
//           ),
//           items: [
//   'A_Item1',
//   'A_Item2',
//   'A_Item3',
//   'A_Item4',
//   'B_Item1',
//   'B_Item2',
//   'B_Item3',
//   'B_Item4',
// ]
//               .map((item) => DropdownMenuItem(
//                     value: item,
//                     child: Text(
//                       item,
//                       style: const TextStyle(
//                         fontSize: 14,
//                       ),
//                     ),
//                   ))
//               .toList(),
//           value: null,
//           onChanged: (value) {

//             // setState(() {
//             //   selectedValue = value;
//             // });
//           },
//           buttonStyleData: const ButtonStyleData(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             height: 40,
//             width: 200,
//           ),
//           dropdownStyleData: const DropdownStyleData(
//             maxHeight: 200,
//           ),
//           menuItemStyleData: const MenuItemStyleData(
//             height: 40,
//           ),
//           dropdownSearchData: DropdownSearchData(
//             searchController: TextEditingController(),
//             searchInnerWidgetHeight: 50,
//             searchInnerWidget: Container(
//               height: 50,
//               padding: const EdgeInsets.only(
//                 top: 8,
//                 bottom: 4,
//                 right: 8,
//                 left: 8,
//               ),
//               child: TextFormField(
//                 onChanged: (value) {
//              trainingController.getSuggestion(value);

//                 },
//                 expands: true,
//                 maxLines: null,
//                 controller: TextEditingController(),
//                 decoration: InputDecoration(
//                   isDense: true,
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 8,
//                   ),
//                   hintText: 'Search for an item...',
//                   hintStyle: const TextStyle(fontSize: 12),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ),
//             searchMatchFn: (item, searchValue) {

//               return item.value.toString().contains(searchValue);
//             },
//           ),
//           //This to clear the search value when you close the menu
//           onMenuStateChange: (isOpen) {
//             if (!isOpen) {
//               // textEditingController.clear();
//             }
//           },
//         ),
//       ),

                    selectedLocation?.locationId == -1
                        ? Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Location Name',
                                  style: GoogleFonts.dmSans(
                                    color: ColorResources.color294C73,
                                    fontSize: 14.sp.h,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 1.7.w,
                                height: 54.h.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(
                                        color: ColorResources.colorA5A5A5)),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 16.w),
                                    child: SizedBox(
                                      width: 230.w,
                                      child: SafeArea(
                                        child: Container(
                                          // height: 20.w,
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),

                                          child:
                                              GooglePlaceAutoCompleteTextField(
                                            containerVerticalPadding: 0,

                                            textEditingController:
                                                customLocationController,
                                            googleAPIKey:
                                                'AIzaSyA_bzviLciEVnc8Hv-s11zlYvUBIBhTpls',
                                            // "AIzaSyCRKwhGwhXBzmCx4pA5rUYgnSDeMbVkClc  ",
                                            textStyle: GoogleFonts.dmSans(
                                              color: ColorResources.colorBlack,
                                              fontSize: 14.sp.h,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            boxDecoration: const BoxDecoration(
                                                border: Border(
                                                    left: BorderSide.none,
                                                    right: BorderSide.none,
                                                    bottom: BorderSide.none,
                                                    top: BorderSide.none)),
                                            inputDecoration: InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              disabledBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              hintText: 'Search Location',
                                              hintStyle: GoogleFonts.dmSans(
                                                color:
                                                    ColorResources.colorA5A5A5,
                                                fontSize: 14.sp.h,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),

                                            debounceTime: 600,
                                            placeType: PlaceType.establishment,
                                            countries: const [], // optional by default null is set
                                            isLatLngRequired:
                                                true, // if you required coordinates from place detail
                                            getPlaceDetailWithLatLng:
                                                (Prediction prediction) {
                                              // this method will return latlng with place detail
                                              print(
                                                  "placeDetails${prediction.lng}");
                                              selectedLocation?.latitude =
                                                  prediction.lat ?? '';
                                              selectedLocation?.longitude =
                                                  prediction.lng ?? '';
                                              print(
                                                  'latitude ${prediction.lat}');
                                              print(
                                                  'longitude ${prediction.lng}');
                                            }, // this callback is called when isLatLngRequired is true
                                            itemClick: (Prediction prediction) {
                                              customLocationController.text =
                                                  prediction.description ?? '';

                                              print(
                                                  'latitude ${prediction.lat}');

                                              // customLocationController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length));
                                            },
                                            // if we want to make custom list item builder
                                            itemBuilder: (context, index,
                                                Prediction prediction) {
                                              return Container(
                                                // height: 200.w,
                                                // padding: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.location_on),
                                                    const SizedBox(
                                                      width: 7,
                                                    ),
                                                    Expanded(
                                                        child: Text(prediction
                                                                .description ??
                                                            ""))
                                                  ],
                                                ),
                                              );
                                            },
                                            // if you want to add seperator between list items
                                            seperatedBuilder: const Divider(),
                                            // want to show close icon
                                            isCrossBtnShown: true,
                                            // optional container padding
                                            containerHorizontalPadding: 10,
                                            // place type
                                            // placeType: PlaceType.geocode,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    //  rowLocationWidget(
                    //       isDropdownEnabled: isDropdownEnabled!,
                    //       context: context,
                    //       selectedLocation: selectedLocation,
                    //       locList: locList!,
                    //       onChanged: onChanged!,
                    //     ),
                    // : rowField(
                    //     title: 'Location',
                    //     enabled: enabled,
                    //     context: context,
                    //     controller: customLocationController,
                    //     focusNode: customLocationFocusNode,
                    //     hintText: 'Enter your location '),
                    SizedBox(
                      height: 32.w,
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 15.h.w,
                          width: 20.w.h,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/icon.png'),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          traineecount,
                          style: GoogleFonts.dmSans(
                            color: ColorResources.color294C73,
                            fontSize: 16.sp.h,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    rowViewTraineeField(
                      title: 'First Name',
                      context: context,
                      text: traineeDetailModel!.employeeFirstname,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    rowViewTraineeField(
                      title: 'Last Name',
                      context: context,
                      text: traineeDetailModel.employeeLastname,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    rowViewTraineeField(
                      title: 'Date Of Birth',
                      context: context,
                      text: traineeDetailModel.dateofBirth,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    rowViewTraineeField(
                      text: traineeDetailModel.mobileNo,
                      title: 'Contact No.',
                      context: context,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    rowViewTraineeField(
                      text: traineeDetailModel.emailId,
                      title: 'Email ID',
                      context: context,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    // rowViewTraineeField(
                    //   text: traineeDetailModel.employeeId.toString(),
                    //   title: 'Trainee ID',
                    //   context: context,
                    // ),
                    // SizedBox(
                    //   height: 12.h,
                    // ),
                    rowViewTraineeField(
                      text: traineeDetailModel.emirateId,
                      title: 'Emirates ID',
                      context: context,
                    ),
                  ],
                )),
    ),
  );
}

Widget traineeDetailAddWidget(
    {required BuildContext context,
    required String frstname,
    required String lastName,
    required String imgUrl,
    required String dob,
    required String mobile,
    required String email,
    required String location,
    required String applicationId,
    required String empId,
    required String emiratedId,
    required String locationName,
    required String traineecount}) {
  return Container(
    // height: 380.h,
    decoration: BoxDecoration(
        color: ColorResources.whiteColor,
        borderRadius: BorderRadius.circular(12.r)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.h.w,
                width: 20.w.h,
                child: Icon(
                  Icons.person_4_rounded,
                  size: 27.w,
                  color: ColorResources.color294C73,
                ),
                // decoration: const BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage('assets/images/icon.png'),
                //         fit: BoxFit.contain)),
              ),
              SizedBox(
                width: 12.w,
              ),
              Container(
                padding: EdgeInsets.only(top: 15.w),
                child: Text(
                  traineecount.toString(),
                  style: GoogleFonts.dmSans(
                    color: ColorResources.color294C73,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.w,
          ),
          imgUrl.isEmpty
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 80.r,
                      width: 80.r,
                      decoration: const BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle)),
                )
              : SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        height: 100.r,
                        width: 100.r,
                        decoration: const BoxDecoration(color: Colors.grey),
                        child: Image.network(
                          '${HttpUrls.imageBase}$imgUrl',
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
          SizedBox(
            height: 15.h,
          ),
          rowViewTraineeField(
            title: 'First Name',
            context: context,
            text: frstname,
          ),
          SizedBox(
            height: 8.h,
          ),
          rowViewTraineeField(
            title: 'Last Name',
            context: context,
            text: lastName,
          ),
          SizedBox(
            height: 8.h,
          ),
          rowViewTraineeField(title: 'DOB', context: context, text: dob),
          SizedBox(
            height: 8.h,
          ),
          rowViewTraineeField(
            text: mobile,
            title: 'Contact No.',
            context: context,
          ),
          SizedBox(
            height: 8.h,
          ),
          rowViewTraineeField(
            text: email,
            title: 'Email ID',
            context: context,
          ),
          SizedBox(
            height: 8.h,
          ),
          // rowViewTraineeField(
          //   text: applicationId,
          //   title: 'Application No',
          //   context: context,
          // ),
          // SizedBox(
          //   height: 8.h,
          // ),
          // rowViewTraineeField(
          //   text: empId,
          //   title: 'Trainee ID',
          //   context: context,
          // ),
          // SizedBox(
          //   height: 8.h,
          // ),
          rowViewTraineeField(
            text: emiratedId,
            title: 'Emirates ID',
            context: context,
          ),
          SizedBox(
            height: 8.h,
          ),
          rowViewTraineeField(
            text: location,
            title: 'Location',
            context: context,
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    ),
  );
}

Widget rowField(
    {required BuildContext context,
    required TextEditingController? controller,
    required String hintText,
    TextInputType? keyboardType,
    required bool? enabled,
    FocusNode? focusNode,
    int? maxLength,
    void Function(String)? onChanged,
    String? errorText,
    String? Function(String?)? validator,
    required String title}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 15.w),
          child: Text(
            title,
            style: GoogleFonts.dmSans(
              color: ColorResources.color294C73,
              fontSize: 14.sp.h,
              fontWeight: FontWeight.w800,
            ),
            softWrap: true,
          ),
        ),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width / 1.7.w,
          child: textFieldTraineeWidget(
            focusNode: focusNode,
            validator: validator,
            onChanged: onChanged,
            maxLength: maxLength,
            errorText: errorText,
            enabled: enabled,
            keyboardType: keyboardType,
            controller: controller,
            hintText: hintText,
          ))
    ],
  );
}

Widget dobWidget({required BuildContext context}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          'Date of Birth',
          style: GoogleFonts.dmSans(
            color: ColorResources.color294C73,
            fontSize: 14.sp.h,
            fontWeight: FontWeight.w500,
          ),
          softWrap: true,
        ),
      ),
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: ColorResources.colorA5A5A5, width: .2),
            borderRadius: BorderRadius.circular(8)),
        height: 38.h.w,
        width: MediaQuery.of(context).size.width / 1.7.w,
        child: DatePickerExample(
          onDateSelected: (DateTime selectedDate) {
            print('Selected date: $selectedDate');
          },
        ),
      ),
    ],
  );
}

Widget rowViewTraineeField(
    {required BuildContext context,
    required String text,
    required String title}) {
  return Row(
    children: [
      SizedBox(
        width: 120.w,
        child: Text(
          title,
          style: GoogleFonts.dmSans(
            color: ColorResources.color294C73,
            fontSize: 14.sp.h,
            fontWeight: FontWeight.w500,
          ),
          softWrap: true,
        ),
      ),
      SizedBox(
        width: 5.w,
      ),
      const Text(
        ':',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
      ),
      SizedBox(
        width: 15.w,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 160.w,
          child: Text(
            text,
            style: GoogleFonts.dmSans(
              color: ColorResources.colorBlack,
              fontSize: 14.sp.h,
              fontWeight: FontWeight.w500,
            ),
            softWrap: true,
          ),
        ),
      )
    ],
  );
}

Widget certificateContainerWidget({
  required String courseName,
  required String traineeName,
  required Color borderColor,
}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: ColorResources.whiteColor),
    child: Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              courseName,
              style: GoogleFonts.dmSans(
                color: ColorResources.color294C73,
                fontSize: 18.sp.h,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8.h.w,
            ),
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 8.h,
                );
              },
              itemCount: 4,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  height: 90.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorResources.colorF1F8FF),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                traineeName,
                                style: GoogleFonts.dmSans(
                                  color: ColorResources.color294C73,
                                  fontSize: 17.sp.h,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            containerWidget(
                                text: 'Passed',
                                height: 22.w.h,
                                width: 65.w.h,
                                bgColor: ColorResources.colorD2EAFF,
                                textColor: ColorResources.colorBlue),
                          ],
                        ),
                        Row(
                          children: [
                            certificateButtonWidget(
                                borderColor: borderColor,
                                onTap: () {},
                                text: 'View Certificate',
                                color: ColorResources.whiteColor,
                                textColor: ColorResources.colorFF0950A0),
                            SizedBox(
                              width: 10.w,
                            ),
                            certificateButtonWidget(
                                borderColor: borderColor,
                                onTap: () {},
                                text: 'Download certificate',
                                color: ColorResources.colorFF0950A0,
                                textColor: ColorResources.whiteColor)
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget certificateButtonWidget(
    {required String text,
    required Color color,
    required Color textColor,
    required Color borderColor,
    void Function()? onTap}) {
  return Material(
    child: InkWell(
      onTap: onTap,
      splashColor: ColorResources.colorDCCCFF,
      highlightColor: ColorResources.colorBlue,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                color: textColor,
                fontSize: 10.sp.h,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// Widget certificateContentWidget() {
//   return Container(
//     height: 90.h,
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: ColorResources.colorF1F8FF),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   'Niranjana Roys',
//                   style: GoogleFonts.dmSans(
//                     color: ColorResources.color294C73,
//                     fontSize: 17.sp.h,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               containerWidget(
//                   text: 'Passed',
//                   height: 22.w.h,
//                   width: 65.w.h,
//                   bgColor: ColorResources.colorD2EAFF,
//                   textColor: ColorResources.colorBlue),
//             ],
//           ),
//           Row(
//             children: [
//               certificateButtonWidget(
//                   text: 'View Certificate',
//                   color: ColorResources.whiteColor,
//                   textColor: ColorResources.colorFF0950A0),
//               SizedBox(
//                 width: 10.w,
//               ),
//               certificateButtonWidget(
//                   text: 'Download certificate',
//                   color: ColorResources.colorFF0950A0,
//                   textColor: ColorResources.whiteColor)
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }

// Widget certificateListviewWidget() {
//   return ListView.separated(
//     separatorBuilder: (context, index) {
//       return SizedBox(
//         height: 8.h,
//       );
//     },
//     itemCount: 4,
//     shrinkWrap: true,
//     physics: const ClampingScrollPhysics(),
//     itemBuilder: (context, index) {
//       return certificateContentWidget();
//     },
//   );
// }

Widget dropDownContainerWidget(
    {required BuildContext context,
    required String text,
    required int itemcount,
    required void Function(String?)? onChanged,
    required String dropDownValue}) {
  return Container(
    decoration: BoxDecoration(
      color: ColorResources.whiteColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              text,
              style: GoogleFonts.dmSans(
                color: ColorResources.color294C73,
                fontSize: 15.sp.h,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // ListView.builder(
          //   itemCount: itemcount,
          //   shrinkWrap: true,
          //   physics: const ClampingScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return dropdownWidget(
          //       text: 'trainee-${index + 1}',
          //       context: context,
          //       onChanged: onChanged,
          //       dropDownValue: dropDownValue,
          //       itemsList: itemsList,
          //     );
          //   },
          // )
        ],
      ),
    ),
  );
}

Widget dropdownWidget({
  required BuildContext context,
  required void Function(String?)? onChanged,
  required String dropDownValue,
  required List<String> itemsList,
  required String text,
}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.dmSans(
                color: ColorResources.color294C73,
                fontSize: 14.sp.h,
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
          ),
          Expanded(
            child: dropDownButtonWidget(
              context: context,
              dropDownValue: dropDownValue,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget dropdownExamWidget({
  required BuildContext context,
  required void Function(String?)? onChanged,
  required String dropDownValue,
  required List<String> itemsList,
  required String text,
}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.dmSans(
                color: ColorResources.color294C73,
                fontSize: 14.sp.h,
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
          ),
          Expanded(
            child: dropDownExamButtonWidget(
              context: context,
              dropDownValue: dropDownValue,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget dropDownButtonWidget(
    {required BuildContext context,
    required String dropDownValue,
    required void Function(String?)? onChanged}) {
  return Container(
      width: MediaQuery.of(context).size.width / 1.7.w,
      height: 40.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: ColorResources.colorA5A5A5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: const Text('Attendance'),
          disabledHint: const Text('data'),
          isExpanded: true,
          style: GoogleFonts.dmSans(
            color: ColorResources.colorBlack,
            fontSize: 14.sp.h,
            fontWeight: FontWeight.w700,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.topRight,
          value: dropDownValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: itemsList.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ));
}

Widget dropDownExamButtonWidget(
    {required BuildContext context,
    required String dropDownValue,
    required void Function(String?)? onChanged}) {
  return Container(
      width: MediaQuery.of(context).size.width / 1.7.w,
      height: 40.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: ColorResources.colorA5A5A5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: const Text('Exam Attendance'),
          isExpanded: true,
          style: GoogleFonts.dmSans(
            color: ColorResources.colorBlack,
            fontSize: 14.sp.h,
            fontWeight: FontWeight.w700,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.topRight,
          value: dropDownValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: eligibleList.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ));
}

Widget taskWidget(
    {required String text, required String number, required Color color}) {
  return Container(
    height: 72.h.w,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.dmSans(
                  color: ColorResources.color294C73,
                  fontSize: 15.sp.h,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GetBuilder<TrainingControllerHomee>(
                init: TrainingControllerHomee(),
                builder: (context) {
                  return Container(
                    width: 26.h.w,
                    height: 26.h.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorResources.colorD2EAFF),
                    child: Center(
                        child: Text(
                      number,
                      style: GoogleFonts.dmSans(
                        color: ColorResources.color294C73,
                        fontSize: 13.sp.h,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  );
                }),
          ],
        ),
      ),
    ),
  );
}

Widget profileTextFieldWidget(
    {required String hintText,
    required String title,
    Widget? suffixIcon,
    int? maxLength,
    String? errorText,
    Function(String)? onChanged,
    // Function(String?)? validator,
    TextInputType? keyboardType,
    bool? enabled,
    required TextEditingController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.dmSans(
          color: ColorResources.color294C73,
          fontSize: 14.sp.h,
          fontWeight: FontWeight.w900,
        ),
      ),
      SizedBox(
        height: 8.h,
      ),
      TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        maxLength: maxLength,
        enabled: enabled,

        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          errorText: errorText,
          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorResources.colorBlack,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFCECECE),
            ),
          ),
        ),
        // validator: validator,
        onChanged: onChanged,
      )
    ],
  );
}

Widget rowTextfieldWidget(
    {required TextEditingController mobileController,
    required bool enabled,
    required String? initialSelection}) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Code',
            style: GoogleFonts.dmSans(
              color: ColorResources.colorFF0950A0,
              fontSize: 14.sp.h,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color(0xFFCECECE),
                  ),
                ),
                child: CountryCodePicker(
                  enabled: enabled,
                  padding: const EdgeInsets.all(0),
                  onChanged: (value) {
                    print(value);

                    loginController.countryCode.value = value.toString();
                  },
                  initialSelection:
                      homeController.currentCountryCode.value == ''
                          ? 'AE'
                          : homeController.currentCountryCode.value,
                  favorite: const ['+91', '+971'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  showFlag: false,
                ),
              ),
            ],
          ),
        ],
      ),
      SizedBox(
        width: 16.w,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mobile No',
              style: GoogleFonts.dmSans(
                color: ColorResources.color294C73,
                fontSize: 14.sp.h,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            TextField(
              enabled: enabled,
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorResources.colorBlack,
                  ), // Set border color here
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFCECECE),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // const Expanded(
      //   child: SizedBox(),
      // )
    ],
  );
}

Widget datePickerWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Emirated ID expiry',
        style: GoogleFonts.dmSans(
          color: ColorResources.color294C73,
          fontSize: 14.sp.h,
          fontWeight: FontWeight.w900,
        ),
      ),
      SizedBox(
        height: 8.h,
      ),
      DatePickerExample(
        onDateSelected: (DateTime selectedDate) {
          print('Selected date: $selectedDate');
        },
      ),
    ],
  );
}

Table tableRowWidget({required String text, required String data}) {
  return Table(
    children: [
      TableRow(children: [
        Text(
          text,
          style: GoogleFonts.dmSans(
            color: ColorResources.color294C73,
            fontSize: 15.sp.h,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          data,
          style: GoogleFonts.dmSans(
            color: ColorResources.colorBlack,
            fontSize: 16.sp.h,
            fontWeight: FontWeight.w700,
          ),
        ),
      ]),
    ],
  );
}

Widget dropDownLocationWidget({
  required BuildContext context,
  required List<LocationListModel> locList,
  required String? selectedLocation,
  required void Function(String?) onChanged,
}) {
  return Container(
      width: MediaQuery.of(context).size.width / 1.7.w,
      height: 40.w.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: ColorResources.colorA5A5A5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text(
            'Select one location',
            style: GoogleFonts.dmSans(
              color: ColorResources.colorA5A5A5,
              fontSize: 14.sp.h,
              fontWeight: FontWeight.w400,
            ),
          ),
          isExpanded: true,
          style: GoogleFonts.dmSans(
            color: ColorResources.colorBlack,
            fontSize: 14.sp.h,
            fontWeight: FontWeight.w400,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          value: selectedLocation,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: locList.map((location) {
            return DropdownMenuItem<String>(
              value: location.locationName,
              child: Text(location.locationName),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ));
}

Widget rowLocationWidget(
    {required BuildContext context,
    required LocationListModel? selectedLocation,
    required List<LocationListModel> locList,
    required bool isDropdownEnabled,
    FocusNode? focusNode,
    required void Function(LocationListModel?) onChanged}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              'Location',
              style: GoogleFonts.dmSans(
                color: ColorResources.color294C73,
                fontSize: 14.sp.h,
                fontWeight: FontWeight.w800,
              ),
              softWrap: true,
            ),
          ),
          // if (trainingController.locList.isEmpty)
          //   SizedBox(
          //       height: 38.h.w,
          //       width: MediaQuery.of(context).size.width / 1.7.w,
          //       child: TextField(
          //         controller: trainingController.locController,
          //         onChanged: (value) {},
          //         style: GoogleFonts.dmSans(
          //           color: ColorResources.colorBlack,
          //           fontSize: 14.sp.h,
          //           fontWeight: FontWeight.w400,
          //         ),
          //         decoration: InputDecoration(
          //           errorStyle: GoogleFonts.dmSans(
          //             color: ColorResources.colorBlack,
          //             fontSize: 14.sp.h,
          //             fontWeight: FontWeight.w400,
          //           ),
          //           hintText: 'Enter Your Location',
          //           contentPadding:
          //               const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          //           hintStyle: GoogleFonts.dmSans(
          //             color: ColorResources.colorA5A5A5,
          //             fontSize: 14.sp.h,
          //             fontWeight: FontWeight.w400,
          //           ),
          //           enabledBorder: OutlineInputBorder(
          //             borderSide: const BorderSide(
          //               color: ColorResources.colorA5A5A5,
          //               width: 1.1,
          //             ),
          //             borderRadius: BorderRadius.circular(4.r),
          //           ),
          //           focusedBorder: OutlineInputBorder(
          //             borderSide: const BorderSide(
          //               color: ColorResources.colorA5A5A5,
          //               width: 1.1,
          //             ),
          //             borderRadius: BorderRadius.circular(8.r),
          //           ),
          //         ),
          //       ))
          // else
          Container(
              width: MediaQuery.of(context).size.width / 1.7.w,
              height: 54.h.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: ColorResources.colorA5A5A5)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<LocationListModel>(
                  focusNode: focusNode,
                  hint: Text(
                    selectedLocation == null
                        ? 'Select Location'
                        : selectedLocation.locationName,
                    style: GoogleFonts.dmSans(
                      color: selectedLocation == null
                          ? ColorResources.colorA5A5A5
                          : Colors.black,
                      fontSize: 14.sp.h,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  isExpanded: true,
                  style: GoogleFonts.dmSans(
                    color: ColorResources.colorBlack,
                    fontSize: 14.sp.h,
                    fontWeight: FontWeight.w400,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  // value: selectedLocation,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: locList.map((location) {
                    return DropdownMenuItem<LocationListModel>(
                      value: location,
                      child: Text(location.locationName),
                    );
                  }).toList(),
                  onChanged: isDropdownEnabled ? onChanged : null,
                ),
              )),
        ],
      ),
      SizedBox(
        height: 16.w,
      ),
    ],
  );
}

Widget examFailedWidget(
    {required Color textColor,
    required String courseName,
    required String categoryName,
    required String amount,
    required BuildContext context,
    required void Function()? onTap}) {
  return Column(
    children: [
      Container(
          height: 118.h.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorResources.whiteColor),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.h),
            child: Row(
              children: [
                // Container(
                //   width: 90.h.w,
                //   decoration: BoxDecoration(
                //     image: const DecorationImage(
                //         image: AssetImage('assets/images/zipline_image.png'),
                //         fit: BoxFit.cover),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),
                SizedBox(
                  width: 8.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      courseName,
                      style: GoogleFonts.dmSans(
                        color: ColorResources.color294C73,
                        fontSize: 14.sp.h,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      categoryName,
                      style: GoogleFonts.dmSans(
                        color: textColor,
                        fontSize: 14.sp.h,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      amount,
                      style: GoogleFonts.dmSans(
                        color: ColorResources.colorBlack,
                        fontSize: 15.sp.h,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    ],
  );
}

Widget loginBtnWidget(
    {required String text,
    required Color? backgroundColor,
    required Color? txtcolor,
    required void Function()? onPressed,
    required Color borderColor}) {
  return SizedBox(
    width: Get.width / 2.3,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            // side: BorderSide(color: borderColor, width: 1),
            backgroundColor: backgroundColor),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            color: ColorResources.colorBlack,
            fontSize: 15.sp.h,
            fontWeight: FontWeight.w700,
          ),
        )),
  );
}

Widget trostunIndustries() {
  return Center(
    child: CircleAvatar(
      radius: 10,
      child: Column(
        children: [
          const Text('Circle avatar'),
          Container(
            decoration: const BoxDecoration(
                color: ColorResources.color0d0d0d,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.amber,
                      blurStyle: BlurStyle.outer),
                ]),
          ),
          const ListTile(
            leading: Icon(Icons.alarm),
          )
        ],
      ),
    ),
  );
}
