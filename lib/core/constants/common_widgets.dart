import 'package:darlsco/core/constants/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Container commonBackgroundLinearColor({required Widget childWidget}) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorResources.backgroundColors)),
    child: childWidget,
  );
}

Container commonBackgroundLinearColorHome({required Widget childWidget}) {
  return Container(
    width: Get.width,
    height: Get.height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorResources.backgroundColors1)),
    child: childWidget,
  );
}

Container commonBackgroundLinearColorCart({required Widget childWidget}) {
  return Container(
    width: Get.width,
    height: Get.height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorResources.backgroundColors3)),
    child: childWidget,
  );
}

Container commonBackgroundLinearColorBill({required Widget childWidget}) {
  return Container(
    width: Get.width,
    height: Get.height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorResources.backgroundColors4)),
    child: childWidget,
  );
}

Container commonBackgroundLinearColorTab({required Widget childWidget}) {
  return Container(
    width: Get.width,
    height: Get.height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorResources.backgroundColors5)),
    child: childWidget,
  );
}

Widget customDrawerIcon({required BuildContext context}) {
  return IconButton(
    splashColor: Colors.blue,
    onPressed: () async {
      // await HttpRequest.httpPostRequest(
      //   bodyData: {
      //     "Task_Id": "1",
      //     "User_Details_Id_": "0",
      //     "physical_hazard_": {},
      //     "safety_hazard_": {},
      //     "chemical_hazard_": {},
      //     "biological_hazard_": {},
      //     "ergonomics_hazard_": {},
      //   },
      //   endPoint: HttpUrls.saveTaskRiskAssistants,
      // ).then((value) {
      //   print('customer task save int details $value');
      //   if (value != null) {
      //     if (value.statusCode == 200) {
      //       print('value inside button');
      //     }
      //   }
      // });

      //  Scaffold.of(context).openDrawer();
    },
    icon: Center(
      child: CircleAvatar(
        radius: 40.r,
        backgroundImage: const AssetImage('assets/images/drawer_icon.png'),
      ),
    ),
  );
}

// Widget bottomNavigationTabWidget() {
//   return Material(
//     color: Colors.white,
//     child: TabBar(
//       unselectedLabelColor: ColorResources.color294C73,
//       labelColor: ColorResources.colorE5AA17,
//       indicator: TopIndicator(),
//       labelStyle: GoogleFonts.dmSans(
//         color: ColorResources.color294C73,
//         fontSize: 15.sp.w.h,
//         fontWeight: FontWeight.w500,
//       ),
//       indicatorPadding: const EdgeInsets.symmetric(horizontal: 14),
//       indicatorSize: TabBarIndicatorSize.tab,
//       tabs: const <Widget>[
//         Tab(
//             icon: Icon(
//               Icons.home_outlined,
//               size: 30,
//             ),
//             text: 'Home'),
//         Tab(
//             icon: Icon(
//               Icons.view_comfortable_rounded,
//               size: 30,
//             ),
//             text: 'My order'),
//         Tab(
//             icon: Icon(
//               Icons.search,
//               size: 30,
//             ),
//             text: 'Search'),
//         Tab(
//             icon: Icon(
//               Icons.account_circle_outlined,
//               size: 30,
//             ),
//             text: 'Account'),
//       ],
//     ),
//   );
// }
