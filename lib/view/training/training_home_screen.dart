import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/http/http_request.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TrainingHomeScreen extends StatefulWidget {
  const TrainingHomeScreen({super.key});

  @override
  State<TrainingHomeScreen> createState() => _TrainingHomeScreenState();
}

final TrainingControllerHomee trainingHomeController =
    Get.put(TrainingControllerHomee());

class _TrainingHomeScreenState extends State<TrainingHomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
    super.initState();
  }

  bool isLoading = false;

  Future<void> getData() async {
    try {
      setState(() {
        isLoading = true;
      });
    } catch (e) {}
    trainingController.priceList.value = 0;
    print('getItemCart2');
    await trainingController.fetchTrainingHomeData();
    await trainingController.getItemCart();
    try {
      setState(() {
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: GetBuilder<TrainingControllerHomee>(
          init: trainingHomeController,
          builder: (controller) {
            return commonBackgroundLinearColorTab(
              childWidget: RefreshIndicator(
                onRefresh: () async {
                  trainingController.fetchTrainingHomeData();
                },
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 32.w),                            children: [
                        !HttpRequest.isNetworkConnected
                            ? Container(
                              height: MediaQuery.sizeOf(context).height/2,
                              child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('No data found',
                                      style: TextStyle(
                                        color: Colors.blue.shade600,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                            )
                            : SizedBox(
                                child: gridViewWidget(context: context),
                              )
                      ],
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
