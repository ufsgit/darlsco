import 'package:darlsco/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_resources.dart';
import '../../core/constants/common_widgets.dart';
import 'company_location_screen.dart';

class BasicDetailsScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
   BasicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return commonBackgroundLinearColor(
        childWidget: Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(70.w, 70.h),
          child: commonBackgroundLinearColor(
              childWidget: AppBar(
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
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Enter your basic',
                    style: GoogleFonts.roboto(
                        color:  ColorResources.color294C73,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: ' details',
                    style: GoogleFonts.roboto(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color =  ColorResources.color294C73,
                    ),
                  ),
                ])),
              ),
              SizedBox(
                height: 30.h,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  decoration: BoxDecoration(
                      color: ColorResources.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.sp),
                          topRight: Radius.circular(40.sp))),
                  child: Form(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                         Text(
                          "FILL THE FORM",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorResources.color294C73,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: 'Full Name',
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.mail_outline_outlined),
                              labelText: 'Email Address',
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: Icon(Icons.remove_red_eye_outlined),
                              labelText: 'Mobile Number',
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: Container(
                                height: 50.h,
                                width: 163.w,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xff0950A0)),
                                    borderRadius: BorderRadius.circular(43.sp)),
                                child:  Center(
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff0950A0),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            IconButton(
                              onPressed: (){
                                Get.to(()=> CompanyLocationScreen());
                              },
                              icon: Container(
                                height: 50.h,
                                width: 158.w,
                                decoration: BoxDecoration(
                                    color:ColorResources.colorE5AA17 ,
                                    borderRadius: BorderRadius.circular(43.sp)),
                                child:  Center(
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color:  ColorResources.color0d0d0d,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
