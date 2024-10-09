import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:flutter/material.dart';

class SampleAboutUs extends StatelessWidget {
  const SampleAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 100,
            child: Center(
                child:
                    Text('About Us', style: AppStyles.getHeadingTextStyle()))),
        Container(
          padding: const EdgeInsets.all(22),
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
              Image.asset('assets/images/about_us_image.png'),
              const SizedBox(height: 16),
              Text(
                aboutUsText,
                style: AppStyles.getBodyTextStyle(fontColor: AppColors.textGrey)
                    .copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 36),
              const Text('Experience'),
              const SizedBox(height: 4),
              customRichText(firstText: '20+', secondText: 'Years'),
              const SizedBox(height: 16),
              Divider(endIndent: 60, indent: 60),
              const SizedBox(height: 16),
              const Text('Presence'),
              const SizedBox(height: 4),
              customRichText(firstText: '10+', secondText: 'Countries'),
              const SizedBox(height: 16),
              Divider(endIndent: 60, indent: 60),
              const SizedBox(height: 16),
              const Text('Served'),
              const SizedBox(height: 4),
              customRichText(firstText: '2000+', secondText: 'Customers'),
           ],
          ),
        ),
      ],
    );
  }

  RichText customRichText(
      {required String firstText, required String secondText}) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: firstText,
            style: AppStyles.getHeadingTextStyle(fontColor: Colors.black)),
        TextSpan(
            text: ' $secondText',
            style: AppStyles.getHeadingTextStyle(fontColor: Colors.grey))
      ]),
    );
  }
}

String get aboutUsText =>
    '''Darlsco is a member of diversified group launched/ registered in Dubai, United Arab Emirates providing corporate professional and customized services in the field of Third party Inspection, testing and certification (TPI) for equipment's and machineries which includes but not limited to fairground and amusement rides and devices.''';
