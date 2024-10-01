import 'package:country_code_picker/country_code_picker.dart';
import 'package:darlsco/controller/contact_us_controller/contact_us_controller.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_resources.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    contactUsController.clearValues();

    codes.toList().sort((a, b) => a['name']
        .toString()
        .toLowerCase()
        .compareTo(b['name'].toString().toLowerCase()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(70.w, 70.h),
            child: commonBackgroundLinearColor(
                childWidget: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorResources.colorTransparent,
            ))),
        body: commonBackgroundLinearColorHome(
          childWidget: Column(
            children: [
              SizedBox(
                height: 20.w,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Contact',
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                  decoration: BoxDecoration(
                      color: ColorResources.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.sp),
                          topRight: Radius.circular(40.sp))),
                  child: Form(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 11.h,
                        ),
                        TextFormField(
                          controller: contactUsController.fullnameController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: 'Contact Name',
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        TextFormField(
                          controller: contactUsController.emailController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.mail_outline_outlined),
                              labelText: 'Email ID',
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller:
                              contactUsController.mobileNumberController,
                          maxLength: 14,
                          decoration: InputDecoration(
                              prefixIcon: CountryCodePicker(
                                countryList: codes,
                                padding: const EdgeInsets.all(0),
                                onChanged: (value) {
                                  print(value);

                                  loginController.countryCode.value =
                                      value.toString();
                                },
                                initialSelection: homeController
                                            .currentCountryCode.value ==
                                        ''
                                    ? 'AE'
                                    : homeController.currentCountryCode.value,
                                favorite: const ['+91', '+971'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                              ),
                              labelText: 'Mobile No',
                              border: const OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        TextFormField(
                          controller:
                              contactUsController.additionMessageController,
                          maxLines: 3,
                          maxLength: 250,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.chat_bubble_outline),
                              labelText: 'Message',
                              border: OutlineInputBorder()),
                        ),
                        // SizedBox(
                        //   height: 16.h,
                        // ),
                        IconButton(
                          onPressed: () {
                            contactUsController.contactFormValidation(
                              contactUsController.fullnameController.text,
                              contactUsController.mobileNumberController.text,
                              contactUsController.emailController.text,
                              contactUsController
                                  .additionMessageController.text,
                              context,
                            );
                          },
                          icon: Container(
                            height: 50.h,
                            width: 346.w,
                            decoration: BoxDecoration(
                                color: ColorResources.colorE5AA17,
                                borderRadius: BorderRadius.circular(43.sp)),
                            child: Center(
                              child: Text(
                                "SEND",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorResources.color0d0d0d,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
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
    );
  }
}
