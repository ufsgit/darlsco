import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/home/widgets/common_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_resources.dart';

class AboutUsScreenTab extends StatelessWidget {
  const AboutUsScreenTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(70.w, 70.h),
          child: commonBackgroundLinearColor(
              childWidget: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ColorResources.colorTransparent,
          ))),
      body: commonBackgroundLinearColorHome(
        childWidget: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 50.h,),

                Container(
                  width: Get.width,
                  // height: Get.height,
                  // margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                  decoration: BoxDecoration(
                      color: ColorResources.whiteColor,
                      borderRadius: BorderRadius.circular(13.r)),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'About',
                          style: GoogleFonts.roboto(
                              color: ColorResources.color294C73,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: ' Us',
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
                        height: 20.h,
                      ),
                      Container(
                        width: Get.width,
                        height: 500.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.r),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    homeController.isCalibrationSection.value
                                        ? 'assets/images/calib_2.png'
                                        : 'assets/images/about_us_img.png'))),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      SizedBox(
                        width: 800.w,
                        child: Text(
                          "DARLSCO is a member of diversified group launched/registered in Dubai, United Arab Emirates providing corporate professional and customized services in the field of Third Party Inspection, Testing and Certification (TPI) for Equipments and Machineries which includes but not limited to Fairground and Amusement rides and devices.",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff0d0d0d),
                            height: 2,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              height: 150.w,
                              width: 240.w,
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide())),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Experience",
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 1
                                          ..color = ColorResources.color294C73,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.w,
                                    ),
                                    Text(
                                      "20+ Years",
                                      style: TextStyle(
                                        color: ColorResources.color294C73,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 15.w,
                            ),
                            Container(
                              height: 150.w,
                              width: 240.w,
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide())),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Presence",
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 1
                                          ..color = ColorResources.color294C73,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.w,
                                    ),
                                    Text(
                                      "10+ Countries",
                                      style: TextStyle(
                                        color: ColorResources.color294C73,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 15.w,
                            ),
                            Container(
                              height: 150.w,
                              width: 240.w,
                              decoration: const BoxDecoration(),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Served",
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 1
                                          ..color = ColorResources.color294C73,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.w,
                                    ),
                                    Text(
                                      "2000+ Customers",
                                      style: TextStyle(
                                        color: ColorResources.color294C73,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.w,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Success',
                    style: GoogleFonts.roboto(
                        color: ColorResources.color294C73,
                        fontSize: 29.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: ' Story',
                    style: GoogleFonts.roboto(
                      fontSize: 29.sp,
                      fontWeight: FontWeight.w700,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = ColorResources.color294C73,
                    ),
                  ),
                ])),
                // Text("Success Story",
                //     style: TextStyle(
                //       color: ColorResources.color294C73,
                //       fontSize: 29.sp,
                //       fontWeight: FontWeight.w700,
                //     )),
                SizedBox(
                  height: 30.w,
                ),
                const HistoryContainerWidget(),
                SizedBox(
                  height: 20.w,
                ),
                const CoFounderBottomWidget(),

                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: commonBottomWidgetTab()),

                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CoFounderBottomWidget extends StatelessWidget {
  const CoFounderBottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(15.r),
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      decoration: BoxDecoration(
        color: ColorResources.whiteColor,
        borderRadius: BorderRadius.circular(13.sp),
      ),
      child: Column(children: [
        SizedBox(
          height: 15.w,
        ),
        Align(
          alignment: Alignment.center,
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: 'Our Leaders ',
              style: GoogleFonts.roboto(
                  color: ColorResources.color294C73,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: 'Speak',
              style: GoogleFonts.roboto(
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = ColorResources.color294C73,
              ),
            ),
          ])),

          // Column(
          //   children: [
          //     Text(
          //       'OUR Leaders ',
          //       style: TextStyle(
          //           color: ColorResources.color294C73,
          //           fontWeight: FontWeight.w700,
          //           fontSize: 20.sp),
          //     ),

          //     Text(
          //                           "Served",
          //                           style: GoogleFonts.roboto(
          //                             fontSize: 20.sp,
          //                             fontWeight: FontWeight.w700,
          //                             foreground: Paint()
          //                               ..style = PaintingStyle.stroke
          //                               ..strokeWidth = 1
          //                               ..color = ColorResources.color294C73,
          //                           ),
          //                         ),
          //     // Text(
          //     //   'Speaks',
          //     //   style: TextStyle(
          //     //       color: ColorResources.color294C73,
          //     //       fontWeight: FontWeight.w700,
          //     //       fontSize: 20.sp),
          //     // ),
          //   ],
          // ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          width: Get.width,
          height: 600.w,
          decoration: const BoxDecoration(
              // color: Colors.amber,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/images/327282549_1520796901776159_8317464268160495359_n.jpg'))),
        ),
        // Text(
        //   'Chairman & Managing Director',
        //   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
        // ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          "“At DARLSCO, we deliver excellence and swift service. Welcome to our online home of quality. With over a decade of experience, we're committed to exceeding expectations. Thank you for choosing DARLSCO services.”",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 20.h,
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Founders',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                // width: 150.w,

                child: Text(
                  "Eng. Leo G. Clements,",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
                ),
              ),

              Text(
                "Mr.Suresh Manayankath",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
              ),

              SizedBox(
                height: 5.h,
              ),

              // Text(
              //   'Chairman & Managing Director',
              //   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
              // ),
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ]),
    );
  }
}

class HistoryContainerWidget extends StatelessWidget {
  const HistoryContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Column(
                children: [
                  pathLinewidget(
                    isLine: true,
                    title: "The Beginning (2000-2010)",
                    imgUrl: 'assets/images/about_us_icon.png',
                    lineHeight: 100,
                    subTitle:
                        'To provide continuous support to all our Customer/clients through a systemized quality driven health, Safety and Environment initiative and thus to minimize the potential risk of work related hazards',
                  ),
                  pathLinewidget(
                    isLine: true,
                    title: "The Gulf Chapter (2011-2015)",
                    imgUrl: 'assets/images/about_us_icon1.png',
                    lineHeight: 100,
                    subTitle:
                        'We will service the customer/client by continuously improving and updating the skills and resources needed for demand driven Third Party Inspection, Testing and Certification, Safety Training for persons, Certification and Development.',
                  ),
                  pathLinewidget(
                    isLine: true,
                    title: "New Brand (2016-2020)",
                    lineHeight: 110,
                    imgUrl: 'assets/images/about_us_icon2.png',
                    subTitle:
                        'We offer Calibration of Instruments and equipments pertaining to Temperature, Mass, Pressure & flow, Torque & Force, Dimensional, electrical, humidity, oil fields, Industrial & marine fields.',
                  ),
                  pathLinewidget(
                    isLine: false,
                    title: "Era Of Expansion (2021-2024)",
                    lineHeight: 100,
                    imgUrl: 'assets/images/about_us_icon3.png',
                    subTitle:
                        'Our services are Accredited by Dubai Accreditation Centre (DAC)/Dubai Municipality (DM) - (i.e. Public Health and Safety Department, Building Department, Environmental Department).',
                  ),

                  //          Row(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Column(
                  //               children: [
                  //                 Container(
                  //                   width: 55.w,
                  //                   height: 55.h,
                  //                   decoration: const BoxDecoration(
                  //                       color: ColorResources.color294C73, shape: BoxShape.circle),
                  //                   child:  Center(
                  //                     child:Image(
                  //                       fit: BoxFit.cover,

                  //                        width: 25.w,
                  //                       height: 25.w,

                  //                       image: AssetImage('assets/images/lightbulb (1).png'))

                  //                     //  Icon(
                  //                     //   Icons.lightbulb,
                  //                     //   color: ColorResources.colorE5AA17,
                  //                     // ),
                  //                   ),
                  //                 ),
                  //                 Container(
                  //               width: 2.w,
                  //               height: 134.w,
                  //               color: ColorResources.color0d0d0d,
                  //             ),
                  //               ],
                  //             ),
                  //               Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("The Beginning (2000-2010)",
                  //                 style: TextStyle(
                  //                   color: ColorResources.color294C73,
                  //                   fontSize: 14.sp,
                  //                   fontWeight: FontWeight.w600,
                  //                 )),
                  //             SizedBox(
                  //               width: 250.w,
                  //               child:  Text(
                  //                   'To provide continuous support to all our Customer/ clients through a systemized quality driven health, Safety and Environment initiative and thus to minimize the potential risk of work related hazards',
                  //                   style: TextStyle(
                  //                     fontSize: 13.sp,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: ColorResources.color294C73,
                  //                   )),
                  //             )
                  //           ],
                  //         ),
                  //           ],
                  //         ),
                  //         Container(
                  //           width: 2.w,
                  //           height: 134.w,
                  //           color: ColorResources.color0d0d0d,
                  //         ),
                  //         Container(
                  //           width: 55.w,
                  //           height: 55.h,
                  //           decoration: const BoxDecoration(
                  //               color: ColorResources.color294C73, shape: BoxShape.circle),
                  //           child:  Center(

                  //             child:Image(

                  //               width: 25.w,
                  //               height: 25.w,

                  //               image: AssetImage('assets/images/building.png')) ,
                  //             // child: Icon(
                  //             //   Icons.apartment,
                  //             //   color: ColorResources.colorE5AA17,assets\images\building2.png
                  //             // ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 2.w,
                  //           height: 134.w,
                  //           color: ColorResources.color0d0d0d,
                  //         ),
                  //         Container(
                  //           width: 55.w,
                  //           height: 55.h,
                  //           decoration: const BoxDecoration(
                  //               color: ColorResources.color294C73, shape: BoxShape.circle),
                  //           child:  Center(
                  //             child: Image(

                  //               width: 25.w,
                  //               height: 25.w,

                  //               image: const AssetImage('assets/images/building2.png')) ,
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 2.w,
                  //           height: 134.w,
                  //           color: ColorResources.color0d0d0d,
                  //         ),
                  //         Container(
                  //           width: 55.w,
                  //           height: 55.h,
                  //           decoration: const BoxDecoration(
                  //               color: ColorResources.color294C73, shape: BoxShape.circle),
                  //           child:  Center(
                  //             child: Image(

                  //                width: 25.w,
                  //               height: 25.w,

                  //               image:const AssetImage('assets/images/building3.png'))
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(
                  //       width: 15.w,
                  //     ),
                  //     Column(
                  //       children: [
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("The Beginning (2000-2010)",
                  //                 style: TextStyle(
                  //                   color: ColorResources.color294C73,
                  //                   fontSize: 14.sp,
                  //                   fontWeight: FontWeight.w600,
                  //                 )),
                  //             SizedBox(
                  //               width: 250.w,
                  //               child:  Text(
                  //                   'To provide continuous support to all our Customer/ clients through a systemized quality driven health, Safety and Environment initiative and thus to minimize the potential risk of work related hazards',
                  //                   style: TextStyle(
                  //                     fontSize: 13.sp,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: ColorResources.color294C73,
                  //                   )),
                  //             )
                  //           ],
                  //         ),
                  //         SizedBox(
                  //           height: 90.w,
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("The Gulf Chapter (2011-2015)",
                  //                 style: TextStyle(
                  //                   color: ColorResources.color294C73,
                  //                   fontSize: 14.sp,
                  //                   fontWeight: FontWeight.w600,
                  //                 )),
                  //             SizedBox(
                  //               width: 250.w,
                  //               child:  Text(
                  //                   'We will service the customer/ client by continuously improving and updating the skills and resources needed for demand driven Third Party Inspection, Testing and Certification, Safety Training for persons, Certification and Development.',
                  //                   style: TextStyle(
                  //                     fontSize: 13.sp,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: ColorResources.color294C73,
                  //                   )),
                  //             )
                  //           ],
                  //         ),
                  //         SizedBox(
                  //           height: 65.w,
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("New Brand (2016-2020)",
                  //                 style: TextStyle(
                  //                   color: ColorResources.color294C73,
                  //                   fontSize: 14.sp,
                  //                   fontWeight: FontWeight.w600,
                  //                 )),
                  //             SizedBox(
                  //               width: 250.w,
                  //               child:  Text(
                  //                   'We offer Calibration of Instruments and equipments pertaining to Temperature, Mass, Pressure & flow, Torque & Force, Dimensional, electrical, humidity, oil fields, Industrial & marine fields.',
                  //                   style: TextStyle(
                  //                     fontSize: 13.sp,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: ColorResources.color294C73,
                  //                   )),
                  //             )
                  //           ],
                  //         ),
                  //         SizedBox(
                  //           height: 80.w,
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("Era Of Expansion (2021-2024)",
                  //                 style: TextStyle(
                  //                   color: ColorResources.color294C73,
                  //                   fontSize: 14.sp,
                  //                   fontWeight: FontWeight.w600,
                  //                 )),
                  //             SizedBox(
                  //               width: 250.w,
                  //               child:  Text(
                  //                   'Our services are Accredited by Dubai Accreditation Centre (DAC) / Dubai Municipality (DM) - (i.e. Public Health and Safety Department, Building Department, Environmental Department).',
                  //                   style: TextStyle(
                  //                     fontSize: 13.sp,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: ColorResources.color294C73,
                  //                   )),
                  //             )
                  //           ],
                  //         ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row pathLinewidget({
    required bool isLine,
    required String title,
    required String imgUrl,
    required String subTitle,
    required double lineHeight,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 55.w,
              height: 55.w,
              decoration: const BoxDecoration(
                  color: ColorResources.color294C73, shape: BoxShape.circle),
              child: Center(
                  child: Image(
                      fit: BoxFit.cover,
                      width: 25.w,
                      height: 25.w,
                      image: AssetImage(imgUrl))

                  //  Icon(
                  //   Icons.lightbulb,
                  //   color: ColorResources.colorE5AA17,
                  // ),
                  ),
            ),
            if (isLine)
              Container(
                width: 2.w,
                height: lineHeight.w,
                color: ColorResources.color0d0d0d,
              ),
          ],
        ),
        SizedBox(
          width: 15.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  color: ColorResources.color294C73,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(
              width: 700.w,
              child: Text(subTitle,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorResources.color294C73,
                  )),
            )
          ],
        ),
      ],
    );
  }
}
