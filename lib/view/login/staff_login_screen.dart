// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:darlsco/controller/login/login_controller.dart';
// import 'package:darlsco/view/home/bottom_navigation_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../controller/button/button_click_controller.dart';
// import '../../core/constants/color_resources.dart';
// import '../../core/constants/common_widgets.dart';

// class StaffLoginScreen extends StatefulWidget {
//   const StaffLoginScreen({super.key});

//   @override
//   State<StaffLoginScreen> createState() => _StaffLoginScreenState();
// }

// class _StaffLoginScreenState extends State<StaffLoginScreen> {
//   @override
//   void initState() {
//     loginController.mobileNumberController.clear();
//     codes.toList().sort((a, b) => a['name']
//         .toString()
//         .toLowerCase()
//         .compareTo(b['name'].toString().toLowerCase()));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return commonBackgroundLinearColor(
//         childWidget: Scaffold(
//       appBar: PreferredSize(
//           preferredSize: Size(80.w, 80.h),
//           child: commonBackgroundLinearColor(
//               childWidget: AppBar(
//             leading: IconButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 icon: Icon(Icons.arrow_back_ios_new_outlined)),
//             backgroundColor: ColorResources.colorTransparent,
//           ))),
//       body: commonBackgroundLinearColorHome(
//         childWidget: SizedBox(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20.h,
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 10.w),
//                 child: RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'Enter your mobile number to',
//                         style: GoogleFonts.roboto(
//                             color: ColorResources.color294C73,
//                             fontSize: 40.sp,
//                             fontWeight: FontWeight.w700),
//                       ),
//                       TextSpan(
//                         text: ' verify',
//                         style: GoogleFonts.roboto(
//                           fontSize: 40.sp,
//                           fontWeight: FontWeight.w700,
//                           foreground: Paint()
//                             ..style = PaintingStyle.stroke
//                             ..strokeWidth = 1
//                             ..color = ColorResources.color294C73,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 10.w, right: 15.w),
//                 child: Text(
//                   "We will send you a confirmation code with a 4-digit number to your registered mobile number. If it is not verified, please contact the Darlsco team.",
//                   style: TextStyle(
//                     fontFamily: "Helvetica Neue",
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w400,
//                     color: ColorResources.color294C73,
//                   ),
//                   textAlign:
//                       Get.width > 615 ? TextAlign.center : TextAlign.left,
//                 ),
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
//                         'assets/images/login_img_phn.png',
//                       )),
//                       TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: loginController.mobileNumberController,
//                         maxLength: 14,
//                         decoration: InputDecoration(
//                             prefixIcon: Obx(
//                               () => CountryCodePicker(
//                                 padding: EdgeInsets.all(0),
//                                 onChanged: (value) {
//                                   print(value);

//                                   loginController.countryCode.value =
//                                       value.toString();
//                                 },
//                                 initialSelection: homeController
//                                             .currentCountryCode.value ==
//                                         ''
//                                     ? 'AE'
//                                     : homeController.currentCountryCode.value,
//                                 favorite: ['+91', '+971'],
//                                 showCountryOnly: false,
//                                 showOnlyCountryWhenClosed: false,
//                                 alignLeft: false,
//                               ),
//                             ),
//                             labelText: 'Mobile No',
//                             border: OutlineInputBorder()),
//                       ),
//                       SizedBox(
//                         height: 25.h,
//                       ),
//                       InkWell(
//                         onTap: () async {
//                           if (loginController
//                               .mobileNumberController.text.isEmpty) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     duration: Duration(milliseconds: 400),
//                                     content: Text('Enter your mobile no!')));
//                           } else if (loginController
//                                   .mobileNumberController.text.length <
//                               7) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text('Enter vaild mobile no!')));
//                           } else {
//                             loginController.getStaffOtp(
//                                 mobileNumber:
//                                     loginController.mobileNumberController.text,
//                                 context: context);
//                           }

//                           Future.delayed(
//                             const Duration(milliseconds: 600),
//                             () {},
//                           );

//                           // loginController.signup();
//                           // Get.to(() => const OtpScreen());
//                         },
//                         child: Container(
//                           height: 50.h,
//                           width: 346.w,
//                           decoration: BoxDecoration(
//                               color: ColorResources.colorE5AA17,
//                               borderRadius: BorderRadius.circular(43.sp)),
//                           child: const Center(
//                             child: Text(
//                               "Verify",
//                               style: TextStyle(
//                                 fontFamily: "Roboto",
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                                 color: ColorResources.color0d0d0d,
//                               ),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                         ),
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
