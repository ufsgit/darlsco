import 'package:carousel_slider/carousel_slider.dart';
import 'package:darlsco/view/home/widgets/common_image_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/color_resources.dart';
import '../bottom_navigation_screen.dart';

Widget commonBottomWidget() {
  return Container(
    margin: EdgeInsets.only(top: 40.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Accreditation",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: ColorResources.color294C73,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 24.h,
        ),
        commonImageListWidget(imgList: homeController.accreditationImgList),
        SizedBox(
          height: 41.h,
        ),
        Text(
          "See what our customer says",
          style: TextStyle(
            fontFamily: "Helvetica Neue",
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff333333),
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 31.h,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 250.h,
            autoPlay: true,
            viewportFraction: 1,
            autoPlayCurve: Curves.linear,
            pageSnapping: false,
          ),
          items: List.generate(homeController.googleReview.length, (index) {
            return Container(
              padding: EdgeInsets.all(15.sp),
              margin: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.sp),
                  border: Border.all(
                      color: ColorResources.colorBlack.withOpacity(0.13))),
              child: Row(children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 29.5.r,
                      backgroundImage: AssetImage(
                          homeController.googleReview[index]['imgUrl']),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    // Image.asset('assets/images/Mask group.png',width: 60.h,height: 60.h,),
                  ],
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: SizedBox(
                    width: 220.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.w),
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Color(0xFF0950A0)))),
                          child: Text(
                            homeController.googleReview[index]['name'],
                            style: TextStyle(
                              fontFamily: "Helvetica Neue",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff000000),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(
                                'https://www.google.com/search?q=darlsco+reviews&rlz=1C1YTUH_enIN1065IN1065&oq=darlsco+reviews&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBCTE4MzI3ajBqNKgCALACAA&sourceid=chrome&ie=UTF-8#ip=1&lrd=0x3e5f5c65fb38005f:0x74c8e56ad6b7edea,1,,,,'));
                          },
                          child: Row(
                            children: [
                              Image(
                                  width: 20.w,
                                  height: 20.h,
                                  image: const AssetImage(
                                      'assets/images/google_logo.png')),
                              SizedBox(
                                width: 10.w,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.sp,
                              ),
                            ],
                          ),
                        ),
                        // Image.asset('assets/images/Rectangle 26.png',height: 15.h,),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          width: 240.w,
                          child: Text(
                            homeController.googleReview[index]['message'],
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: "Helvetica Neue",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff565656),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            );
          }),
        ),
        SizedBox(
          height: 38.h,
        ),
        const Text(
          " Our Clients",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorResources.color294C73,
            height: 23 / 20,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 24.h,
        ),
        commonImageListWidget(imgList: homeController.ourClientsImgList),
      ],
    ),
  );
}

Widget commonBottomWidgetTab() {
  return Container(
    margin: EdgeInsets.only(top: 40.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Accreditation",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: ColorResources.color294C73,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 24.w,
        ),
        commonImageListWidget(imgList: homeController.accreditationImgList),
        SizedBox(
          height: 41.w,
        ),
        Text(
          "See what our customer says",
          style: TextStyle(
            fontFamily: "Helvetica Neue",
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff333333),
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 31.w,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 280.w,
            autoPlay: true,
            clipBehavior: Clip.none,
            viewportFraction: 0.5,
          disableCenter: true,
          padEnds: false,
            autoPlayCurve: Curves.linear,
            pageSnapping: false,
          ),
          items: List.generate(homeController.googleReview.length, (index) {
            return Container(
              padding: EdgeInsets.all(15.sp),
              margin: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.sp),
                  border: Border.all(
                      color: ColorResources.colorBlack.withOpacity(0.13))),
              child: Row(children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 29.5.r,
                      backgroundImage: AssetImage(
                          homeController.googleReview[index]['imgUrl']),
                    ),
                    SizedBox(
                      height: 40.w,
                    ),
                    // Image.asset('assets/images/Mask group.png',width: 60.h,height: 60.h,),
                  ],
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: SizedBox(
                    width: 220.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.w),
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Color(0xFF0950A0)))),
                          child: Text(
                            homeController.googleReview[index]['name'],
                            style: TextStyle(
                              fontFamily: "Helvetica Neue",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff000000),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(
                                'https://www.google.com/search?q=darlsco+reviews&rlz=1C1YTUH_enIN1065IN1065&oq=darlsco+reviews&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBCTE4MzI3ajBqNKgCALACAA&sourceid=chrome&ie=UTF-8#ip=1&lrd=0x3e5f5c65fb38005f:0x74c8e56ad6b7edea,1,,,,'));
                          },
                          child: Row(
                            children: [
                              Image(
                                  width: 20.w,
                                  height: 20.h,
                                  image: const AssetImage(
                                      'assets/images/google_logo.png')),
                              SizedBox(
                                width: 10.w,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.sp,
                              ),
                            ],
                          ),
                        ),
                        // Image.asset('assets/images/Rectangle 26.png',height: 15.h,),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          width: 600.w,
                          child: Text(
                            homeController.googleReview[index]['message'],
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: "Helvetica Neue",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff565656),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            );
          }),
        ),
        SizedBox(
          height: 38.h,
        ),
        const Text(
          " Our Clients",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorResources.color294C73,
            height: 23 / 20,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 24.h,
        ),
        commonImageListWidget(imgList: homeController.ourClientsImgList),
      ],
    ),
  );
}
