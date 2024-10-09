import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class SampleOTPScreen extends StatelessWidget {
  const SampleOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    loginController.pinPutOtpController.clear();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(18),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: RichText(
                    textAlign:
                        Get.width > 615 ? TextAlign.center : TextAlign.left,
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                            'Enter 4 digit verification code sent to your number',
                        style: AppStyles.getHeadingTextStyle(
                            fontSize: 30.sp, fontColor: Colors.black),
                      ),
                    ])),
              ),
              SizedBox(
                height: 22.h,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.sp),
                          topRight: Radius.circular(40.sp))),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      SizedBox(
                          child: Hero(
                        tag: '1',
                        child: Image.asset(
                          'assets/images/phone_illu.png',
                          height: 120,
                          width: 140,
                        ),
                      )),
                      SizedBox(
                        height: 25.h,
                      ),
                      Pinput(
                        enabled: !loginController.isLoading.value,
                        controller: loginController.pinPutOtpController,
                        onCompleted: (value) {
                          if (value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Enter the otp ')));
                          } else {
                            loginController.agentLogin(
                                phNo:
                                    loginController.mobileNumberController.text,
                                otp: value,
                                context: context);
                          }
                        },
                      ),
                      SizedBox(
                        height: 34.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the OTP ?",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          IconButton(
                            onPressed: () async {
                              loginController.pinPutOtpController.clear();

                              await loginController.getOtp(
                                  mobileNumber: loginController
                                      .mobileNumberController.text,
                                  context: context);
                            },
                            icon: Text(
                              "Resend OTP",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.primaryBlue),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ],
          ),
          Align(
              child: loginController.isLoading.value
                  ? const CircularProgressIndicator()
                  : const SizedBox()),
        ],
      ),
    );
  }
}
