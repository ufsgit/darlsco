import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:flutter/material.dart';

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
          onPressed: () {},
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
        
        ],
      ),
    );
  }
}
