import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/sample/sample_login_screen.dart';
import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:darlsco/view/sample/widgets/inspection_card_widget.dart';
import 'package:darlsco/view/sample/widgets/sample_inspection_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SampleHomeScreen extends StatefulWidget {
  const SampleHomeScreen(
      {super.key, this.isLoggedIn = false, required this.onClickEnquire});
  final bool isLoggedIn;
  final void Function() onClickEnquire;
  @override
  State<SampleHomeScreen> createState() => _SampleHomeScreenState();
}

class _SampleHomeScreenState extends State<SampleHomeScreen> {
  TextEditingController inspectionDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actions: [
          widget.isLoggedIn
              ? IconButton.filledTonal(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white)),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.power_settings_new_rounded,
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    homeController.checkCountryCode(context);

                    Get.to(() => const SampleLoginScreen());
                  },
                  style: AppStyles.getPrimaryButtonStyle(context).copyWith(
                      fixedSize: const WidgetStatePropertyAll(Size(80, 36)),
                      side: const WidgetStatePropertyAll(
                          BorderSide(color: Colors.white)),
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.white)),
                  child: Text(
                    'Login',
                    style: AppStyles.getBodyTextStyle(
                        fontColor: AppColors.primaryBlue),
                  )),
          const SizedBox(width: 16, height: 10),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/inspection_logo.png',
                height: 30,
                width: 30,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: 5),
              Text(
                'Inspection',
                style: AppStyles.getHeadingTextStyle(
                    fontColor: AppColors.primaryBlue),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (widget.isLoggedIn) const InspectionCardWidget(),
          Text(
            "  We’re ready to Inspect",
            style: AppStyles.getHeadingTextStyle(),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.isLoggedIn
                        ? Image.asset(
                            'assets/images/inspection_cover_image.png')
                        : Image.asset('assets/images/Rectangle 161296.png'),
                    const SizedBox(height: 16),
                    if (widget.isLoggedIn)
                      SampleInspectionForm(
                          inspectionDateController: inspectionDateController)
                    else
                      Column(
                        children: [
                          Text(
                            'Building trust through perfection.',
                            style: AppStyles.getHeadingTextStyle(),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            inspectionText,
                            style: AppStyles.getBodyTextStyle(),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: AppStyles.getPrimaryButtonStyle(context),
                            onPressed: widget.onClickEnquire,
                            child: const Text('Enquire Now'),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

String get inspectionText =>
    '''Our Services are lasting, tangible, benefits that address Quality, Financial, health & Safety concerns. Darlsco has independent Inspections to cater to the requirements of clients and customers.''';
