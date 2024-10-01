// import 'package:darlsco/controller/login/login_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pinput/pinput.dart';

// import '../../controller/button/button_click_controller.dart';
// import '../../core/constants/color_resources.dart';
// import '../../core/constants/common_widgets.dart';

// class StaffOtpScreen extends StatelessWidget {
//   const StaffOtpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     loginController.pinPutOtpController.clear();
//     return commonBackgroundLinearColor(
//         childWidget: Scaffold(
//       appBar: PreferredSize(
//           preferredSize: Size(70.w, 70.h),
//           child: commonBackgroundLinearColor(
//               childWidget: AppBar(
//             leading: IconButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 icon: const Icon(Icons.arrow_back_ios_new_outlined)),
//             backgroundColor: ColorResources.colorTransparent,
//           ))),
//       body: commonBackgroundLinearColorHome(
//         childWidget: SizedBox(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                 child: RichText(
//                     textAlign:
//                         Get.width > 615 ? TextAlign.center : TextAlign.left,
//                     text: TextSpan(children: [
//                       TextSpan(
//                         text: 'Enter 4 digit verification code sent to your',
//                         style: GoogleFonts.roboto(
//                             color: ColorResources.color294C73,
//                             fontSize: 40.sp,
//                             fontWeight: FontWeight.w700),
//                       ),
//                       TextSpan(
//                         text: ' number',
//                         style: GoogleFonts.roboto(
//                           fontSize: 40.sp,
//                           fontWeight: FontWeight.w700,
//                           foreground: Paint()
//                             ..style = PaintingStyle.stroke
//                             ..strokeWidth = 1
//                             ..color = ColorResources.color294C73,
//                         ),
//                       ),
//                     ])),
//               ),
//               SizedBox(
//                 height: 22.h,
//               ),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 30.w),
//                   decoration: BoxDecoration(
//                       color: ColorResources.whiteColor,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(40.sp),
//                           topRight: Radius.circular(40.sp))),
//                   child: SingleChildScrollView(
//                     child: Column(children: [
//                       SizedBox(
//                         height: 25.h,
//                       ),
//                       SizedBox(
//                           child: Image.asset(
//                         'assets/images/login_otp_img.png',
//                       )),
//                       Pinput(
//                         controller: loginController.pinPutOtpController,
//                         onCompleted: (value) {
//                           if (value.isEmpty) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text('Enter the otp ')));
//                           } else {
//                             loginController.adminLogin(
//                                 phNo:
//                                     loginController.mobileNumberController.text,
//                                 otp: value,
//                                 context: context);
//                           }
//                         },
//                       ),
//                       SizedBox(
//                         height: 34.h,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Didn’t receive the OTP ?",
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                             ),
//                             textAlign: TextAlign.left,
//                           ),
//                           SizedBox(
//                             width: 10.w,
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               loginController.pinPutOtpController.clear();

//                               loginController.getOtp(
//                                   mobileNumber: loginController
//                                       .mobileNumberController.text,
//                                   context: context);
//                             },
//                             icon: Text(
//                               "Resend OTP",
//                               style: TextStyle(
//                                   fontSize: 14.sp,
//                                   color: ColorResources.colorBlue),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                         ],
//                       )
//                     ]),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
