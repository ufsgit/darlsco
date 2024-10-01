import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/view_certificate_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EquipmentDetailScreen extends StatefulWidget {
  const EquipmentDetailScreen({super.key, required this.equipmentId});
  final String equipmentId;
  @override
  State<EquipmentDetailScreen> createState() => _EquipmentDetailScreenState();
}

class _EquipmentDetailScreenState extends State<EquipmentDetailScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.getSingleEquipMentData(widget.equipmentId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(70.w, 70.h),
        child: commonBackgroundLinearColor(
          childWidget: AppBar(
            leading: IconButton(
                onPressed: () {
                  homeController.inspectionDropdownValue.value = '';
                  homeController.equipmentListCustomer = {};
                  homeController.inspectionDateController.clear();
                  homeController.inspectionMessageController.clear();
                  homeController.isChooseEquipment.value = false;
                  homeController.update();

                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            backgroundColor: ColorResources.colorTransparent,
          ),
        ),
      ),
      body: commonBackgroundLinearColorHome(
        childWidget: Obx(
          () {
            if (homeController.isLoadingEquipmentDetailsscreen.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                padding: const EdgeInsets.all(18),
                children: List.generate(
                    homeController
                        .equipmentDetailModel.returnvalue?.leads.length??0,
                    (index) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                              children: [
                                element(
                                    keyText: 'Certificate Number',
                                    valueText: homeController
                                        .equipmentDetailModel
                                        .returnvalue!
                                        .leads[index]
                                        .certificateNumber),
                                         element(
                                    keyText: 'Issue Date',
                                    valueText: homeController
                                        .equipmentDetailModel
                                        .returnvalue!
                                        .leads[index]
                                        .issueDateG),
                                    //      element(
                                    // keyText: 'Period From',
                                    // valueText: homeController
                                    //     .equipmentDetailModel
                                    //     .returnvalue!
                                    //     .leads[index]
                                    //     .periodFromG),
                                         element(
                                    keyText: 'Expiry Date',
                                    valueText: homeController
                                        .equipmentDetailModel
                                        .returnvalue!
                                        .leads[index]
                                        .periodToG),
                                            element(
                                              name:homeController
                                        .equipmentDetailModel
                                        .returnvalue!
                                        .leads[index].certificateNumber ,
                                    keyText: 'View Certificate',
                                    pdfPath:homeController
                                        .equipmentDetailModel
                                        .returnvalue!
                                        .leads[index].fileKey,
                                    valueText: '',
                                    
                                    ),
                              ],
                            ),
                          ),
                        ),),
              );
            }
          },
        ),
      ),
    );
  }

  Padding element({required String keyText, required String valueText,  String ?pdfPath, String ?name}) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 48.0, top: 19.0, bottom: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 12.sp,
          ),
          const SizedBox(width: 2),
          Text(
            keyText,
            style: TextStyle(
                fontFamily: "DM Sans",
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: ColorResources.color294C73),
          ),
          const Spacer(),
         if (valueText.isEmpty) ElevatedButton(onPressed: ()=>Get.to(()=>PDFViewerPage(fileName: 'Certifiacte $name', pdfPath: pdfPath??'')), child: const Text('View')) else Text(valueText),
        ],
      ),
    );
  }
}
