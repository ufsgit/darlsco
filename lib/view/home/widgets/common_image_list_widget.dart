import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

SizedBox commonImageListWidget({required List<String> imgList}) {
  return SizedBox(
    width: Get.width,
    height: 75.8.h,
    child: CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 0.335,
        autoPlayCurve: Curves.linear,
        pageSnapping: false,
       
      
    



      ),
      // padding: const EdgeInsets.all(0),
      // shrinkWrap: true,
      // scrollDirection: Axis.horizontal,
      items: List.generate(
          imgList.length,
          (index) => Container(
                margin: EdgeInsets.only(right: 20.w),
                height: 75.h,
                width: 141.8.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  image: DecorationImage(
                
                    
                    image: AssetImage(imgList[index])),
                ),
              )),
    ),
  );
}
