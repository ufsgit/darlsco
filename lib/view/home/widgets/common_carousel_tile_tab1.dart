import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_resources.dart';

Container carouselTileTab1(
    {required String text1, required String text2, required String imgUrl}) {
  return Container(
      padding: EdgeInsets.only(left: 20.w, top: 30.h, right: 20.h),
      width: 263.w,
      height: 292.h,
      decoration: BoxDecoration(
       
          image:
              DecorationImage(fit: BoxFit.cover, image: NetworkImage(imgUrl)),
          borderRadius: BorderRadius.circular(16.sp)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text1,
                style: TextStyle(
                  fontFamily: "Helvetica Neue",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffe0e0e0),
                ),
                // style: TextStyle(fontSize: 16.sp),
              ),
              Container(
                height: 21.h,
                width: 21.w,
                decoration: const BoxDecoration(
                    color: ColorResources.colorE5AA17, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.star,
                    size: 12.sp,
                    color: ColorResources.whiteColor,
                  ),
                ),
              )
            ],
          ),
          Text(
            text2,
            style: TextStyle(
              fontFamily: "Helvetica Neue",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xffe0e0e0),
            ),
          ),
          SizedBox(
            height: 90.h,
          ),
          Container(
            width: 268.w,
            height: 43.h,
            decoration: BoxDecoration(
                color: ColorResources.colorA5A5A5.withOpacity(0.50),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 104.w,
                      height: 43.h,
                      decoration: BoxDecoration(
                          color: ColorResources.colorE5AA17,
                          borderRadius: BorderRadius.circular(20)),
                      child:  Center(
                        child: Text('Take a look',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400),),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 18.w),
                      child:  Text(
                        'AED 1500',
                        style: TextStyle(fontSize: 16.sp,  color: ColorResources.whiteColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ));
}
