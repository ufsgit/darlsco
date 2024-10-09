import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/login/login_screen.dart';
import 'package:darlsco/view/sample/sample_login_screen.dart';
import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:darlsco/view/sample/widgets/inspection_card_widget.dart';
import 'package:darlsco/view/sample/widgets/sample_inspection_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    print('getItemCart3');
    homeController.isHomeLoading.value = true;
    await trainingController.getItemCart();

    if (globalHomeController.isTraineeLogin.value) {
      await trainingController.getProfile();
      await trainingController.getIndividualTrainee();
    }
    if (homeController.isuserLogin.value) {
      await trainingController.getIndividualTrainee();
    }
    await homeController.checkUserTypeChanged(context);
    await globalHomeController.initfunction();
  }

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
                      backgroundColor: MaterialStatePropertyAll(Colors.white)),
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) => AlertDialog(
                        // title: const Text(
                        //   '',
                        //   style: TextStyle(fontWeight: FontWeight.w800),
                        // ),
                        content: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                const Text("Are you sure to logout?")
                              ]),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          TextButton(
                            child: const Text('Logout'),
                            onPressed: () async {
                              await loginController.logout(context);
                              globalHomeController.isTrainingSection.value =
                                  false;

                              Get.back();
                            },
                          ),
                        ],
                      ),
                    );
                  },
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
                      fixedSize: const MaterialStatePropertyAll(Size(80, 36)),
                      side: const MaterialStatePropertyAll(
                          BorderSide(color: Colors.white)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white)),
                  child: Text(
                    'Login',
                    style: AppStyles.getBodyTextStyle(
                        fontColor: AppColors.primaryBlue),
                  )),
          const SizedBox(width: 16, height: 10),
        ],
      ),
      body: GetBuilder<HomeController>(builder: (loginDatas) {
        return homeController.isHomeLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
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
                                : Image.asset(
                                    'assets/images/Rectangle 161296.png'),
                            const SizedBox(height: 16),
                            if (widget.isLoggedIn)
                              SampleInspectionForm(
                                  inspectionDateController:
                                      inspectionDateController)
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
                                    style: AppStyles.getPrimaryButtonStyle(
                                        context),
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
              );
      }),
    );
  }
}

String get inspectionText =>
    '''Our Services are lasting, tangible, benefits that address Quality, Financial, health & Safety concerns. Darlsco has independent Inspections to cater to the requirements of clients and customers.''';
