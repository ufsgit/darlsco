import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/tainning/trainnig_controller.dart';
import '../../controller/upcoming_inspections/upcoming_inspection_controller.dart';
import '../../core/constants/common_widgets.dart';

class EquipmentListTab extends StatelessWidget {
  const EquipmentListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(390.w, 150.h),
        child: commonBackgroundLinearColor(
          childWidget: AppBar(
            backgroundColor: ColorResources.colorTransparent,
            leading: Builder(builder: (ctx) {
              return customDrawerIcon(context: ctx);
            }),
          ),
        ),
      ),
     
      body: commonBackgroundLinearColorHome(
        childWidget: Container(
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
              child: Column(children: [


                 if (upcomingInspectionsController.taskUserDetails[0]
                                        ['Role_Id']
                                    .toString() ==
                                '38' &&
                            upcomingInspectionsController.taskUserDetails[0]
                                        ['Task_Status_Id']
                                    .toString() ==
                                '1')
                          tcontoller.isTaskStarted.value == false
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      homeController.getAllusers();
                                    },
                                    icon: Container(
                                      height: 30.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                          color: ColorResources.color294C73,
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                      child: Center(
                                        child: Text(
                                          'Update Team',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                 SizedBox(
                  height: 20.h,
                ),
            Row(
              children: [
                Icon(
                  Icons.settings_applications_outlined,
                  color: ColorResources.color294C73,
                  size: 20.sp,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  "Equipment List",
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorResources.color294C73,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
               SizedBox(
                  height: 57.h,
                ),
            Container(
              width: 800.w,
              padding: EdgeInsets.symmetric(horizontal: 37.w, vertical: 24.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Equipment Name",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorResources.color294C73,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Text(
                            "Hydraulic Press",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorResources.color0d0d0d,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 161.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Equipment Model",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorResources.color294C73,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Text(
                            "Shearing Machine, CNC Lathe",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorResources.color0d0d0d,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 117.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Equipment Make",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorResources.color294C73,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Text(
                            " CNC Lathe,2008",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorResources.color0d0d0d,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Visual",
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff51688a),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Transform.scale(
                              scale: 0.8,
                            
                            child: Checkbox(
                              splashRadius: 0.r,
                              
                              
                              value: false, onChanged: (value) {})),
                          
                        ],
                      ),
                      SizedBox(
                        width: 90.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Thorough",
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff51688a),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Transform.scale(
                           scale: 0.8,
                            
                            
                            child: Checkbox(value: true, onChanged: (value) {}))
                        ],
                      ),
                      SizedBox(
                        width: 90.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Major",
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff51688a),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Transform.scale(
                            scale: 0.8,
                            
                            child: Checkbox(value: false, onChanged: (value) {}))
                        ],
                      ),
                      SizedBox(
                        width: 90.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Periodic",
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff51688a),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Transform.scale(
                            scale: 0.8,
                            
                            
                            child: Checkbox(value: false, onChanged: (value) {}))
                        ],
                      ),
                      SizedBox(
                        width: 90.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "All",
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff51688a),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Transform.scale(
                             scale: 0.8,
                            
                            
                            child: Checkbox(value: false, onChanged: (value) {}))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ])),
        ),
      ),
    );
  }
}
