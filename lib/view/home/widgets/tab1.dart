import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/home/home_controller.dart';
import '../../../core/constants/color_resources.dart';
import '../../../core/constants/common_widgets.dart';
import 'common_bottom_widget.dart';
import 'common_carousel_tile_tab1.dart';

class Tab1 extends StatelessWidget {
   Tab1({
    super.key,
  });
 final HomeController homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    
    return commonBackgroundLinearColorHome(
      childWidget: Container(
        padding: EdgeInsets.all(10.w),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
           if (  homeController.isuserLogin.value==true ) Wrap(
                  spacing: 15.w,
                  runSpacing: 15.h,
                  
                  children: List.generate(2, (index) => 
            homeColorContainer(contentText:   homeController.contentTextTrainingTab1[index], numberText: '${index+1}', cBgColor:homeController.cBgColorTrainingTab1[index] , numBgColor: homeController.numBgColorTrainingTab1[index] )
            ),),
            SizedBox(height: 20.h,),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Explore our\nvarious',
                style: GoogleFonts.roboto(
                    color: ColorResources.color294C73,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w700),
              ),
              TextSpan(
                text: ' training',
                style: GoogleFonts.roboto(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w700,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = ColorResources.color294C73,
                ),
              ),
            ])),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Training',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                  ),
                  // const Spacer(),
                  IconButton(
                    onPressed: () {
                      homeController.homeTab1CarouselController.nextPage();
                    },
                    icon: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: const BoxDecoration(
                            color: ColorResources.whiteColor,
                            shape: BoxShape.circle),
                        child: Center(
                            child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 19.h,
                        ))),
                  ),
                  // SizedBox(
                  //   width: 50.w,
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
CarouselSlider(
  
                carouselController: homeController.homeTab1CarouselController,
                options: CarouselOptions(
                    initialPage: 0,
                    height: 292.h,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.78),
                items: List.generate(2, (index) {
                  return carouselTileTab1(
                      text1: ['Zipline Training', 'Climbing Traning'][index],
                      text2: [
                        'Experience the ultimate thrill\nwith our Zipline Training\nprogram',
                        'Experience the ultimate thrill\nwith our Zipline Training\nprogram'
                      ][index],
                      imgUrl: [
                        'https://s3-alpha-sig.figma.com/img/5fc1/8a42/72affeae751de87be5a775b042d40388?Expires=1701648000&Signature=M24cYO9WLhC43cATULU~7IoXQodqtvIUZNcTFhkjK-JrqANrpNdeYDgrRJ0Do1ommNYt5~2YivB2K~MqQLvLfTG5Ca59xk1G7kZDV2REkO9zGQiyRIJv40gB-NnTzo1CgWKv~AzoZrHHoe948I6U~XHZVJ-6J9LkjgSKwaf4PAkAiloIzyJTS1L~Oan4e9aeVbxIlHxHR~C0mSWVWBNa5loTTq~GO-ORyKFQH4duwL3sQzwXxkl-8zEbKZc4dIgB68y8IdzMYXCySxcs8kXiLcd6Ym1L7yCGoJ8Z0DQznS0G2Web0pdUemvmPnhUQK1kcBmZCiQn6euEIMCDmCm~4w__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
                        'https://geographical.co.uk/wp-content/uploads/Photographing-mountains-in-spring-1200x800.jpg',
                      ][index]);
                })),
            commonBottomWidget(),
          ]),
        ),
      ),
    );
  }

 
}
 Container homeColorContainer({
    required String contentText,
    required String numberText,
    required Color cBgColor,
    required Color numBgColor,





  }) {
    return Container(
            width: 170.w,
            height: 100.w,
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(color:cBgColor,borderRadius: BorderRadius.circular(10.r)),
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 98.w,
                  child: Text(
                    contentText,
                    style: TextStyle(
                      fontFamily: "DM Sans",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.color294C73,
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor:numBgColor,
                  radius: 20.r,
                  child: Text(
                    numberText,
                    style: TextStyle(
                      fontFamily: "DM Sans",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.color294C73,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )),
          );
  }
