import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/model/training/get_today_task_model.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TraineeViewPage extends StatefulWidget {
  final GetTodayTaskModel data;
  const TraineeViewPage({super.key, required this.data});

  @override
  State<TraineeViewPage> createState() => _TraineeViewPageState();
}

class _TraineeViewPageState extends State<TraineeViewPage> {
  late bool dataLoaded = false;
  final TrainingControllerHomee trainingHomeController =
      Get.put(TrainingControllerHomee());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      trainingHomeController.getTraineeDetails(
          widget.data.orderDetailsId.toString(),
          widget.data.orderLocationId.toString(),
          widget.data.examMasterId.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<TrainingControllerHomee>(
         
          builder: (controller) {
            return commonBackgroundLinearColorCart(
                childWidget: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 16.h,
                    // ),
                    // InkWell(
                    //     onTap: () {
                    //       Get.back();
                    //     },
                    //     child: const Icon(
                    //       Icons.arrow_back,
                    //       color: ColorResources.color294C73,
                    //     )),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: 18.h,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 30.h,
                          color: ColorResources.color294C73,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    richTextWidget(
                        text: widget.data.customerName, spanText: ''),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      widget.data.trainingCourseName,
                      style: GoogleFonts.dmSans(
                          color: ColorResources.color294C73,
                          fontSize: 15.sp.h,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    if (controller.traineeDetails.isNotEmpty)
                      GetBuilder<TrainingControllerHomee>(
                        builder: (traineeData) {
                          return ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 24.h,
                              );
                            },
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: traineeData.traineeDetails.length,
                            itemBuilder: (context, index) {
                              return traineeDetailsWidget(
                                  index: index,
                                  customLocationController: TextEditingController(),
                                  contactController: TextEditingController(),
                                  dobController: TextEditingController(),
                                  emailController: TextEditingController(),
                                  emiratedIdController: TextEditingController(),
                                  employeeIdcontroller: TextEditingController(),
                                  firstNameController: TextEditingController(),
                                  lastNameController: TextEditingController(),
                                  applicationIdController: TextEditingController(),
                                  traineeDetailModel:
                                      traineeData.traineeDetails[index],
                                  imageListUrl: traineeData.traineeImgUrl,
                                  context: context,
                                  traineecount: 'Trainee-${index + 1}',
                                  isTraineeView: true);
                            },
                          );
                        }
                      )
                    // else
                    //   Column(
                    //     children: [
                    //       SizedBox(
                    //         height: Get.height / 3,
                    //       ),
                    //       Center(
                    //           child: Text(
                    //         'No trainees to view',
                    //         style: GoogleFonts.dmSans(
                    //           color: ColorResources.color294C73,
                    //           fontSize: 15.sp.h,
                    //           fontWeight: FontWeight.w700,
                    //         ),
                    //       ))
                    //     ],
                    //   )
                  ],
                ),
              ),
            ));
          },
        ),
        // bottomNavigationBar: elevatedButtonWidget(
        //   context: context,
        //   text: 'Start',
        //   backgroundColor: ColorResources.colorE5AA17,
        //   width: Get.width,
        //   txtColor: ColorResources.colorBlack,
        //   onPressed: () {
        //     Get.to(() => const AttendancePage());
        //   },
        // ),
      ),
    );
  }
}
