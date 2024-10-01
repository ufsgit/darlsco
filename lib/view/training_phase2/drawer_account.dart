// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/view/training/certificate_page.dart';
import 'package:darlsco/view/training/exam_failed_page.dart';
import 'package:darlsco/view/training/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerAccount extends StatefulWidget {
  const DrawerAccount({super.key});

  @override
  State<DrawerAccount> createState() => _DrawerAccountState();
}

class _DrawerAccountState extends State<DrawerAccount> {
  final trainingController = Get.put(TrainingControllerHomee());
  @override
  void initState() {
    _initializeProfile();
    super.initState();
  }

  Future<void> _initializeProfile() async {
    await trainingController.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network(
            //     "https://s3-alpha-sig.figma.com/img/fc12/d2c9/c1b119623f12f2c28de29de3b311f7af?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=EMH24aiN2RQ3ElcfrQW-DnOVUIaZ8CTsfO-ePdEgFVjx2079R3F1FT1dBUpGxQCEYWKXF8jl9fRtEfKEdrRuyGB--XccmxC08Ygz~F2wX873wA85sfsR9ESnXwxqziClaAnJoZ2VkhIWaZ6bIUZnUQ38SMoVhiv98mI4gmXVrgblMvsOFEms7eAtIyFVfXCDUkBxsKbXXn7XifsHYOTRmAKSuRWuvVu1EX6rmAxUUgoGdUuI1tKyDjn2lHYY-YKxxNNbDBDyNEO3Me9WSnc7hNNVMr22ptwpZc3W1rd4PKKISotfd2DraZWZPu6j~ak39yBHTwlfKm1MhkTwdVunqw__",
            //     height: 100.h,
            //     width: 250.w),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorResources.colorA5A5A5.withOpacity(.1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: ColorResources.whiteColor,
                        radius: 30.r,
                        child: Icon(Icons.person),
                      ),
                      // SizedBox(
                      //   width: 10.w,
                      // ),
                      GetBuilder<TrainingControllerHomee>(
                        builder: (profileData) {
                          if (profileData.profileDetails.isNotEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 185.w,
                                child: Text(
                                  profileData.profileDetails[0].customerName,
                                  style: GoogleFonts.dmSans(
                                    color: ColorResources.colorBlack,
                                    fontSize: 18.sp.h,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '',
                                style: GoogleFonts.dmSans(
                                  color: ColorResources.colorBlack,
                                  fontSize: 18.sp.h,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Container(
            //   decoration: BoxDecoration(color: Color(0xFFF8F8F8)),
            //   child: Row(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: ClipRRect(
            //             borderRadius: BorderRadius.circular(90),
            //             child: Image.network(
            //               "https://s3-alpha-sig.figma.com/img/8435/9da2/07aca47cf32367e6fd3d2ccef79a50cc?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=b04eRii6Yl5vawG7OzbPgH6a0I1i9MkVMBXNDmghQrYfnKX0em4mmC0p0WxenwAip3p0SlzedHaghWirGax2nSmctQ2vi42JNdNfpL43VwWXbObcDVJm8WGVtMOCwlBFjtyZShs7zJUnrFQAsUOuHlJTUco9FTeKd7JB-zSynSqr08BW6qv0GaxeR7QhrWrAzhMOsX~aI19F3vJzgzNcfwdiLbpFtWh~27vyPFWXLzz3XT1c4dLpxEt-53dWpMF8mR67SorgHcQnynBF5XS9cpgRqrWHv49K8Kzrem57QmfX9K0M1GU8XKb8-63uCZriU5B6lYO0LtRdztJfpLjr0A__",
            //               height: 100.h,
            //               width: 100.w,
            //               fit: BoxFit.cover,
            //             )),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           "Admin",
            //           style:
            //               TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person_outlined,
                      color: Color(0xFF294C73),
                      size: 25,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ProfileViewPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Profile",
                        style: GoogleFonts.dmSans(
                          color: ColorResources.color294C73,
                          fontSize: 18.sp.h,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Icon(
            //           Icons.notifications_outlined,
            //           color: Color(0xFF294C73),
            //           size: 25,
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           "Notifications",
            //           style: GoogleFonts.dmSans(
            //             color: ColorResources.color294C73,
            //             fontSize: 18.sp.h,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            InkWell(
              onTap: () {
                Get.to(() => ExamFailedPage());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.edit_note_sharp,
                        color: Color(0xFF294C73),
                        size: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Exam failed",
                        style: GoogleFonts.dmSans(
                          color: ColorResources.color294C73,
                          fontSize: 18.sp.h,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.workspace_premium_outlined,
                      color: Color(0xFF294C73),
                      size: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        await trainingController.getCertificate();
                        Get.to(() => CertificatePage());
                      },
                      child: Text(
                        "View certificate",
                        style: GoogleFonts.dmSans(
                          color: ColorResources.color294C73,
                          fontSize: 18.sp.h,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  // Container(
                  //   height: 25,
                  //   width: 25,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12.5),
                  //       color: Color(0xFF09A021)),
                  //   child: Center(
                  //       child: Text(
                  //     "3",
                  //     style: TextStyle(color: Colors.white),
                  //   )),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
