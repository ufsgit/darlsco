// import 'package:darlsco/controller/home/home_controller.dart';
// import 'package:darlsco/controller/login/login_controller.dart';
// import 'package:darlsco/controller/tainning/training_controller_home.dart';
// import 'package:darlsco/core/constants/color_resources.dart';
// import 'package:darlsco/core/constants/common_widgets.dart';
// import 'package:darlsco/view/home/home_screen.dart';
// import 'package:darlsco/view/training/billing_page.dart';
// import 'package:darlsco/view/training/widgets/bottom_navigation_widget.dart';
// import 'package:darlsco/view/training/widgets/training_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pinput/pinput.dart';

// import '../home/bottom_navigation_screen.dart';

// class OtpVerifyPage extends StatefulWidget {
//   const OtpVerifyPage({super.key});

//   @override
//   State<OtpVerifyPage> createState() => _OtpVerifyPageState();
// }

// class _OtpVerifyPageState extends State<OtpVerifyPage> {
//   final focusNode = FocusNode();
//   final formKey = GlobalKey<FormState>();
//   bool isFocused = false;

//   @override
//   void initState() {
//     super.initState();
//     focusNode.addListener(() {
//       setState(() {
//         isFocused = focusNode.hasFocus;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 55.h,
//       height: 55.h,
//       textStyle: const TextStyle(
//         fontSize: 22,
//         color: Color.fromRGBO(30, 60, 87, 1),
//       ),
//       decoration: BoxDecoration(
//         color: ColorResources.whiteColor,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//             color: isFocused
//                 ? ColorResources.color294C73
//                 : ColorResources.whiteColor,
//             width: isFocused ? 2 : 1),
//       ),
//     );
//     return SafeArea(
//       child: Scaffold(
//         body: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).requestFocus(FocusNode());
//           },
//           child: commonBackgroundLinearColorCart(
//             childWidget: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   authenticationImageWidget(
//                       context: context,
//                       isPhoneNumberPage: true,
//                       image: 'assets/images/auth_image.png'),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 16),
//                     child: verificationContentWidget(
//                         isphone: false,
//                         text: 'Enter Verification',
//                         spanText: '\nCode',
//                         title:
//                             'Please enter the verification code send to your\nmobile number.'),
//                   ),
//                   Center(
//                     child: Form(
//                       key: formKey,
//                       child: Directionality(
//                         textDirection: TextDirection.ltr,
//                         child: Pinput(
//                           controller: trainingController.otpController,
//                           focusNode: focusNode,
//                           defaultPinTheme: defaultPinTheme,
//                           androidSmsAutofillMethod:
//                               AndroidSmsAutofillMethod.smsUserConsentApi,
//                           listenForMultipleSmsOnAndroid: true,
//                           hapticFeedbackType: HapticFeedbackType.lightImpact,
//                           onCompleted: (String verificationCode) {},
//                           onChanged: (code) {},
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Didn’t receive the OTP ?",
//                         style: GoogleFonts.dmSans(
//                             color: ColorResources.color8D8D8D,
//                             fontSize: 14.sp.h,
//                             fontWeight: FontWeight.w600),
//                         textAlign: TextAlign.left,
//                       ),
//                       SizedBox(
//                         width: 10.w,
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           trainingController.getOtp(
//                               trainingController.numberHomeController.text,
//                               loginController.countryCode.value.isEmpty
//                                   ? '+91'
//                                   : loginController.countryCode.value);
//                         },
//                         icon: Text(
//                           "Resend OTP",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14.sp,
//                               color: ColorResources.color294C73),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         bottomNavigationBar: elevatedButtonWidget(
//             context: context,
//             text: 'Submit',
//             backgroundColor: ColorResources.colorE5AA17,
//             width: Get.width,
//             txtColor: ColorResources.colorBlack,
//             onPressed: () async {
//               if (trainingController.otpController.text ==
//                   trainingController.receivedOtp) {
//                 loginController.agentLogin(
//                   otp: trainingController.otpController.text,
//                   context: context,
//                   phNo: trainingController.numberHomeController.text,
//                 );
//                 trainingController.numberHomeController.clear();
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Entered OTP is incorrect'),
//                   ),
//                 );
//               }
//             }),
//       ),
//     );
//   }
// }

import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../home/bottom_navigation_screen.dart';

class OtpVerifyPage extends StatelessWidget {
  const OtpVerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    trainingController.otpController.clear();
    return commonBackgroundLinearColor(
        childWidget: Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(70.w, 70.h),
          child: commonBackgroundLinearColor(
              childWidget: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            backgroundColor: ColorResources.colorTransparent,
          ))),
      body: commonBackgroundLinearColorHome(
        childWidget: SizedBox(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: RichText(
                    textAlign:
                        Get.width > 615 ? TextAlign.center : TextAlign.left,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Enter 4 digit verification code sent to your',
                        style: GoogleFonts.roboto(
                            color: ColorResources.color294C73,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: ' number',
                        style: GoogleFonts.roboto(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w700,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = ColorResources.color294C73,
                        ),
                      ),
                    ])),
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
                        'assets/images/login_otp_img.png',
                      )),
                      Pinput(
                          controller: trainingController.otpController,
                          onCompleted: (value) async {
                            if (trainingController.otpController.text ==
                                trainingController.receivedOtp) {
                              loginController.agentLogin(
                                otp: trainingController.otpController.text,
                                context: context,
                                phNo: trainingController
                                    .numberHomeController.text,
                              );
                              trainingController.numberHomeController.clear();
                              trainingController.otpController.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Entered OTP is incorrect'),
                                ),
                              );
                            }
                          }),
                      SizedBox(
                        height: 34.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn’t receive the OTP ?",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          IconButton(
                            onPressed: () async {
                              trainingController.otpController.clear();
                              print(
                                  'Cartlength otp${trainingController.cartPriceList.length}');
                              await trainingController.getOtp(
                                  trainingController.numberHomeController.text,
                                  loginController.countryCode.isEmpty
                                      ? homeController.currentCountryCode.value
                                      : loginController.countryCode.value);
                              print(
                                  'Cartlength otp${trainingController.cartPriceList.length}');
                            },
                            icon: Text(
                              "Resend OTP",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: ColorResources.colorBlue),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
