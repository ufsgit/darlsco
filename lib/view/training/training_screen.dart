import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/controller/upcoming_inspections/upcoming_inspection_controller.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/training_screen_tab.dart';
import 'package:darlsco/view/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'training_screen_mobile.dart';

class TrainningScreen extends StatefulWidget {
  const TrainningScreen({super.key, required this.status, required this.taskId});
  final String status;
  final int taskId;
  @override
  State<TrainningScreen> createState() => _TrainningScreenState();
}

class _TrainningScreenState extends State<TrainningScreen> {
  final UpcomingInspectionsController upcomingInspectionsController =
      Get.put(UpcomingInspectionsController());

  final TrainingController tcontroller = Get.put(TrainingController());
  bool isLoading = false;
  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      await upcomingInspectionsController.getUserTaskDetails(
          status: widget.status, taskId: widget.taskId);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        mobile: isLoading
            ? commonBackgroundLinearColor(
                childWidget: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : TrainingScreenMobile(),
        tab: isLoading
            ? commonBackgroundLinearColor(
                childWidget: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : TrainningScreenTab());

    //   return Scaffold(
    //     appBar: PreferredSize(
    //       preferredSize: Size(390.w, 150.h),
    //       child: commonBackgroundLinearColor(
    //         childWidget: AppBar(
    //           backgroundColor: ColorResources.colorTransparent,
    //           leading: Builder(builder: (ctx) {
    //             return customDrawerIcon(context: ctx);
    //           }),
    //         ),
    //       ),
    //     ),
    //     bottomNavigationBar: GestureDetector(
    //       onTap: () {
    //         print('next');
    //       },
    //       child: Container(
    //         height: 50.h,
    //         color: ColorResources.colorE5AA17,
    //         child: Center(
    //             child: Text(
    //           "Start",
    //           style: TextStyle(
    //             fontFamily: "Roboto",
    //             fontSize: 20.sp,
    //             fontWeight: FontWeight.w500,
    //             color: ColorResources.color0d0d0d,
    //             height: 14.9767427444458 / 20,
    //           ),
    //           textAlign: TextAlign.center,
    //         )),
    //       ),
    //     ),
    //     body: commonBackgroundLinearColorHome(
    //       childWidget: Container(
    //         height: Get.height,
    //         padding: EdgeInsets.symmetric(horizontal: 15.w),
    //         child: SingleChildScrollView(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 height: 20.h,
    //               ),
    //               Container(
    //                 padding:
    //                     EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
    //                 width: 800.w,
    //                 // height: 435.h,
    //                 decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: BorderRadius.circular(20.r),
    //                 ),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Row(
    //                           children: [
    //                             Icon(
    //                               Icons.business,
    //                               color: ColorResources.color294C73,
    //                               size: 21.sp,
    //                             ),
    //                             SizedBox(
    //                               width: 10.w,
    //                             ),
    //                             Text(
    //                               'Trosten Industries',
    //                               style: TextStyle(
    //                                 fontFamily: "DM Sans",
    //                                 fontSize: 16.sp,
    //                                 fontWeight: FontWeight.w700,
    //                                 color: ColorResources.color294C73,
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                         Container(
    //                           width: 143.w,
    //                           height: 32.h,
    //                           decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(43.r),
    //                               color: ColorResources.colorF2ccff),
    //                           child: Center(
    //                               child: Text(
    //                             'visual,periodic',
    //                             style: TextStyle(
    //                               fontFamily: "Roboto",
    //                               fontSize: 14.sp,
    //                               fontWeight: FontWeight.w500,
    //                               color: ColorResources.color0d0d0d,
    //                             ),
    //                           )),
    //                         ),
    //                       ],
    //                     ),
    //                     SizedBox(
    //                       height: 15.h,
    //                     ),
    //                     Text(
    //                       "Industrial Inspection",
    //                       style: TextStyle(
    //                         fontFamily: "Roboto",
    //                         fontSize: 14.sp,
    //                         fontWeight: FontWeight.w400,
    //                         color: ColorResources.color0d0d0d,
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 15.h,
    //                     ),
    //                     Text(
    //                       "Lorem ipsum dolor sit amet consectetur. Nam dictum donec id leo erat aliquam lorem feugiat. Cursus molestie venenatis egestas pulvinar. Tellus tortor egestas rhoncus condimentum duis eget.",
    //                       style: TextStyle(
    //                         fontFamily: "Roboto",
    //                         fontSize: 13.sp,
    //                         fontWeight: FontWeight.w400,
    //                         color: ColorResources.color0d0d0d,
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 25.h,
    //                     ),
    //                     Wrap(
    //                       runSpacing: 15.h,
    //                       spacing: 15.w,
    //                       children: List.generate(
    //                         tcontoller.commonGridTexts.length,
    //                         (index) => trainningGridWidget(
    //                           titleText: tcontoller.commonGridTexts[index]['title'],
    //                           subTitle: tcontoller.commonGridTexts[index]['sub_title'],
    //                           icon: tcontoller.commonGridTexts[index]['icon'],
    //                           border: (index+1)%3!=0?const BorderSide(color: ColorResources.colorD1D1D1):BorderSide.none
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 30.h,
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(left: 20.w),
    //                 child: Text(
    //                   "Enter Notes",
    //                   style: TextStyle(
    //                     fontFamily: "Roboto",
    //                     fontSize: 14.sp,
    //                     fontWeight: FontWeight.w400,
    //                     color: const Color(0xff000000),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }

    // Container trainningGridWidget(
    //     {required String titleText,
    //     required String subTitle,
    //     BorderSide border=BorderSide.none,
    //     required IconData icon}) {
    //   return Container(
    //     margin: EdgeInsets.only(top: 20.h),
    //     width: 230.w,
    //     decoration:  BoxDecoration(
    //       border: Border(
    //         right: border,
    //       ),
    //     ),
    //     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //       Row(
    //         children: [
    //           Icon(
    //            icon,
    //             color: ColorResources.color294C73,
    //             size: 21.sp,
    //           ),
    //           SizedBox(
    //             width: 10.w,
    //           ),
    //           Text(
    //             titleText,
    //             style: TextStyle(
    //               fontFamily: "Roboto",
    //               fontSize: 14.sp,
    //               fontWeight: FontWeight.w600,
    //               color: ColorResources.color294C73,
    //             ),
    //           )
    //         ],
    //       ),
    //       SizedBox(
    //         height: 15.h,
    //       ),
    //       Text(
    //        subTitle,
    //         style: TextStyle(
    //           fontFamily: "Roboto",
    //           fontSize: 13.sp,
    //           fontWeight: FontWeight.w400,
    //           color: ColorResources.color0d0d0d,
    //         ),
    //       ),
    //     ]),
    //   );
  }
}
