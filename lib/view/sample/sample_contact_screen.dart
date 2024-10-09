import 'package:country_code_picker/country_code_picker.dart';
import 'package:darlsco/controller/contact_us_controller/contact_us_controller.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SampleContactScreen extends StatelessWidget {
  const SampleContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 100,
            child: Center(
                child: Text('Contact Us',
                    style: AppStyles.getHeadingTextStyle()))),
        Container(
          padding: const EdgeInsets.all(18),
          margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 8.9),
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
          child: Column(
            children: [
              Form(
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
                      controller: contactUsController.additionMessageController,
                      maxLines: 3,
                      maxLength: 250,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.chat_bubble_outline),
                          labelText: 'Message',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: contactUsController.mobileNumberController,
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
                            initialSelection:
                                homeController.currentCountryCode.value == ''
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
                    // SizedBox(
                    //   height: 16.h,
                    // ),
                    ElevatedButton(
                      onPressed: () =>
                          contactUsController.contactFormValidation(
                        contactUsController.fullnameController.text,
                        contactUsController.mobileNumberController.text,
                        contactUsController.emailController.text,
                        contactUsController.additionMessageController.text,
                        context,
                      ),
                      style: AppStyles.getPrimaryButtonStyle(context),
                      child: const Text('Send'),
                    ),
                  ],
                ),
              )),
            ],
          ),
        )
      ],
    ));
  }
}
