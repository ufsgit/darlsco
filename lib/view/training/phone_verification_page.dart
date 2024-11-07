// import 'package:darlsco/controller/login/login_controller.dart';
// import 'package:darlsco/controller/tainning/training_controller_home.dart';
// import 'package:darlsco/core/constants/color_resources.dart';
// import 'package:darlsco/core/constants/common_widgets.dart';
// import 'package:darlsco/view/training/verify_otp_page.dart';
// import 'package:darlsco/view/training/widgets/training_widgets.dart';
// import 'package:darlsco/view/training_phase2/payment_details.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';

// import '../home/bottom_navigation_screen.dart';

// class PhoneVerificationPage extends StatefulWidget {
//   const PhoneVerificationPage({super.key});

//   @override
//   State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
// }

// class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(FocusNode());
//         },
//         child: commonBackgroundLinearColorCart(
//           childWidget: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 authenticationImageWidget(
//                     context: context,
//                     isPhoneNumberPage: true,
//                     image: 'assets/images/auth_image.png'),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                   child: verificationContentWidget(
//                       isphone: true,
//                       text: 'OTP',
//                       spanText: 'Verification',
//                       title:
//                           'Enter your mobile number to get the\nverification code'),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(left: 16, right: 16, bottom: 16),
//                   child: textFieldWidget(
//                     context: context,
//                     controller: trainingController.numberHomeController,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: elevatedButtonWidget(
//         context: context,
//         text: 'Continue',
//         backgroundColor: ColorResources.colorE5AA17,
//         width: Get.width,
//         txtColor: ColorResources.colorBlack,
//         onPressed: () async {
//           if (trainingController.numberHomeController.text.isEmpty) {
//             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                 duration: Duration(milliseconds: 400),
//                 content: Text('Enter your mobile no!')));
//           } else if (trainingController.numberHomeController.text.length < 7) {
//             ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Enter vaild mobile no!')));
//           } else {
//             print(trainingController.numberHomeController.text);
//             await
//                           trainingController
//                 .getOtp(trainingController.numberHomeController.text,loginController.countryCode.value.isEmpty?'+91':loginController.countryCode.value);
//             Future.delayed(
//               const Duration(milliseconds: 600),
//               () {
//                 Get.to(() => const OtpVerifyPage());
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:country_code_picker/country_code_picker.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/main.dart';
import 'package:darlsco/view/training/verify_otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/bottom_navigation_screen.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  @override
  void initState() {
    getcountry(context);
     homeController.isFromPurchase.value =true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commonBackgroundLinearColor(
      childWidget: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(80.w, 80.h),
            child: commonBackgroundLinearColor(
                childWidget: AppBar(
              leading: IconButton(
                  onPressed: () {
                                        homeController.isFromPurchase.value = false;

                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined)),
              backgroundColor: ColorResources.colorTransparent,
            ))),
        body: commonBackgroundLinearColorHome(
          childWidget: SizedBox(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Enter your mobile number to',
                          style: GoogleFonts.roboto(
                              color: ColorResources.color294C73,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: ' verify',
                          style: GoogleFonts.roboto(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w700,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = ColorResources.color294C73,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.w, right: 15.w),
                  child: Text(
                    "We will send you a confirmation code with a 4-digit number to your registered mobile number. If it is not verified, please contact the Darlsco team.",
                    style: TextStyle(
                      fontFamily: "Helvetica Neue",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorResources.color294C73,
                    ),
                    textAlign:
                        Get.width > 615 ? TextAlign.center : TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                        color: ColorResources.whiteColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.sp),
                            topRight: Radius.circular(40.sp))),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                            child: Image.asset(
                          'assets/images/login_img_phn.png',
                        )),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: trainingController.numberHomeController,
                          maxLength: 14,
                          decoration: InputDecoration(
                              prefixIcon: Obx(
                                () => CountryCodePicker(
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
                                      : homeController.currentCountryCode.value,
                                  favorite: const ['+91', '+971'],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                              ),
                              labelText: 'Mobile No',
                              border: const OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        InkWell(
                          onTap: () async {
                            if (trainingController
                                .numberHomeController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(milliseconds: 400),
                                      content: Text('Enter your mobile no!')));
                            } else if (trainingController
                                    .numberHomeController.text.length <
                                7) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Enter vaild mobile no!')));
                            } else {
                              print(
                                  trainingController.numberHomeController.text);
                              print(
                                  'Cartlength otp${trainingController.cartPriceList.length}');
                              await trainingController.getOtp(
                                  trainingController.numberHomeController.text,
                                  loginController.countryCode.isEmpty
                                      ? homeController.currentCountryCode.value
                                      : loginController.countryCode.value);
                              print(
                                  'Cartlength otp after api${trainingController.cartPriceList.length}');
                              Future.delayed(
                                const Duration(milliseconds: 600),
                                () {
                                  Get.to(() => const OtpVerifyPage());
                                },
                              );
                            }
                          },
                          child: Container(
                            height: 50.h,
                            width: 346.w,
                            decoration: BoxDecoration(
                                color: ColorResources.colorE5AA17,
                                borderRadius: BorderRadius.circular(43.sp)),
                            child: const Center(
                              child: Text(
                                "Verify",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorResources.color0d0d0d,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
