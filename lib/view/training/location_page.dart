import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/location_reschedule_page.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:darlsco/view/widgets/common_back_button_phase2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/training/specific_order_details_model.dart';

class LocationPage extends StatefulWidget {
  final SpecificOrderDetailsModel orderItem;
  const LocationPage({super.key, required this.orderItem});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final trainingController = Get.put(TrainingControllerHomee());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        trainingController
                                          .getLocationsCount(
                                                 widget.  orderItem.orderDetailsId.toString(),widget.  orderItem.orderLocationId.toString());
     
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => commonBackgroundLinearColorCart(
              childWidget: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.h, vertical: 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     Get.back();
                          //   },
                          //   child: CircleAvatar(
                          //     radius: 18.h,
                          //     backgroundColor: ColorResources.colorDBE8FC,
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 8),
                          //       child: Icon(
                          //         Icons.arrow_back_ios,
                          //         size: 30.h,
                          //         color: ColorResources.color294C73,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 28.h,
                          ),
                          if (trainingController.locationCountDetails.isNotEmpty)
                            ListView.builder(
                              itemCount:
                                  trainingController.locationCountDetails.length,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    await trainingController.getLocationsCount(
                                        trainingController
                                            .locationCountDetails[index]
                                            .orderDetailsId
                                            .toString(),trainingController
                                            .locationCountDetails[index]
                                            .orderLocationId
                                            .toString());
                  
                                    Get.to(
                                      () => LocationReSchedulePage(
                                        orderItem: widget.orderItem,
                                        locationModel: trainingController
                                            .locationCountDetails[index],
                                        index: index,
                                      ),
                                    );
                                  },
                                  child: locationTileWidget(
                                    locationName: trainingController
                                        .locationCountDetails[index].locationName,
                                    amtColor: ColorResources.color294C73,
                                    imageName: 'uyuyu',
                                    orderNumber: widget.orderItem.orderNo,
                                    // fileName: trainingController
                                    //     .locationCountDetails[index].fileName,
                                    fileName: trainingController
                                        .locationCountDetails[index].fileName,
                                    onTap: () {},
                  
                                    textColor: ColorResources.color294C73,
                                    courseName: trainingController
                                        .locationCountDetails[index]
                                        .trainingCourseName,
                                    categoryName: trainingController
                                        .locationCountDetails[index].categoryName,
                  
                                    quantity: trainingController
                                        .locationCountDetails[index]
                                        .traineeInLocationCount
                                        .toString(),
                                    context: context,
                                  ),
                                );
                              },
                            )
                          else
                            Column(
                              children: [
                                SizedBox(
                                  height: Get.height / 2.5,
                                ),
                                Center(
                                  child: Text(
                                    'Training details yet to update',
                                    style: GoogleFonts.dmSans(
                                      color: ColorResources.color294C73,
                                      fontSize: 16.sp.h,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 16.h,
                          ),
                        ],
                      ),
                    ),
                  ),

                  commonBackButton(),
                ],
              ),
            )),
        //  GetBuilder(
        //     init: trainingController,
        //     builder: (context) {
        //       return
        //     }),
      ),
    );
  }
}
