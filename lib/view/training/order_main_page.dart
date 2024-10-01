// import 'package:darlsco/core/constants/color_resources.dart';
// import 'package:darlsco/core/constants/common_widgets.dart';
// import 'package:darlsco/view/training/order_page.dart';
// import 'package:darlsco/view/training/widgets/training_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class OrderMainPage extends StatelessWidget {
//   const OrderMainPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: commonBackgroundLinearColorCart(
//           childWidget: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 16.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: CircleAvatar(
//                   radius: 18.h,
//                   backgroundColor: Colors.transparent,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: Icon(
//                       Icons.arrow_back_ios,
//                       size: 30.h,
//                       color: ColorResources.color294C73,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               ListView.separated(
//                 itemCount: 3,
//                 shrinkWrap: true,
//                 physics: const ClampingScrollPhysics(),
//                 separatorBuilder: (context, index) {
//                   return const SizedBox(
//                     height: 16,
//                   );
//                 },
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                       onTap: () {
//                         Get.to(() => OrderPage());
//                       },
//                       child: examFailedWidget(
//                         textColor: ColorResources.colorBlack,
//                         courseName: 'ORD 1212121212',
//                         categoryName: 'Bungee Jumping',
//                         amount: 'Courses',
//                         context: context,
//                         onTap: () {},
//                       ));
//                 },
//               )
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
