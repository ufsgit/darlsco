import 'package:country_code_picker/country_code_picker.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SampleLoginScreen extends StatelessWidget {
  const SampleLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton.filledTonal(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.keyboard_arrow_left_outlined),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.grey.shade200),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your mobile number \nto verify',
                  style: AppStyles.getHeadingTextStyle(),
                ),
                SizedBox(height: 16),
                Text(
                  'we will send you confirmation code with a 4 digit number  to your registered mobile number. If not verified, please contact the Darlsco team',
                  style: AppStyles.getBodyTextStyle(
                      fontSize: 14, fontColor: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(22),
            margin:
                EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 4.9),
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(

                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            child: Column(
              children: [
                SizedBox(height: 64),
                Hero(
                  tag: '1',
                  child: Image.asset('assets/images/phone_illu.png',
                      height: 116, width: 160),
                ),
                SizedBox(height: 36),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: loginController.mobileNumberController,
                  maxLength: 14,
                  decoration: InputDecoration(
                      prefixIcon: Obx(
                        () => CountryCodePicker(
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
                      ),
                      labelText: 'Mobile No',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(height: 14),
                ElevatedButton(
                  style: AppStyles.getPrimaryButtonStyle(context),
                  onPressed: ()async{
                    if (loginController
                              .mobileNumberController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Duration(milliseconds: 400),
                                    content: Text('Enter your mobile no!')));
                          } else if (loginController
                                  .mobileNumberController.text.length <
                              7) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Enter vaild mobile no!')));
                          } else {
                            await loginController.getOtp(
                                mobileNumber:
                                    loginController.mobileNumberController.text,
                                context: context);
                          }

                          Future.delayed(
                            const Duration(milliseconds: 600),
                            () {},
                          );

                      
                  }, child: Text('Verify'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
