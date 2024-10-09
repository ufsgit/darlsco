import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/model/home/location_model.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class SampleInspectionForm extends StatefulWidget {
  const SampleInspectionForm(
      {super.key, required this.inspectionDateController});
  final TextEditingController inspectionDateController;
  @override
  State<SampleInspectionForm> createState() => _SampleInspectionFormState();
}

class _SampleInspectionFormState extends State<SampleInspectionForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          if (homeController.isuserLogin.value == true)
            GetBuilder<HomeController>(builder: (data) {
              return DropdownButtonFormField(
                  value: data.inspectionDropdownValue.value == ''
                      ? null
                      : data.inspectionDropdownValue.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  onChanged: (value) {
                    homeController.isChooseEquipment.value = false;
                    data.equipmentListCustomer.clear();
                    data.equipmentCheckValue.clear();
                    data.inspectionDropdownValue.value = value.toString();
                  },
                  hint: const Text(
                    'Location',
                    style: TextStyle(color: Colors.black),
                  ),
                  items: data.customerLocations
                      .map((e) => DropdownMenuItem(
                            value: e.locationName,
                            child: SizedBox(
                                width: Get.width > 615 ? 600.w : 250.w,
                                child: Text(
                                  e.locationName,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                )),
                          ))
                      .toList());
            }),
          SizedBox(
            height: 11.h,
          ),
          if (homeController.isuserLogin.value == true)
            ElevatedButton(
                style: AppStyles.getPrimaryButtonStyle(context),
                onPressed: () {
                  if (homeController.inspectionDropdownValue.value == '') {
                    homeController.isChooseEquipment.value = true;
                  } else {
                    final List<CustomerLocations> loctionIdSearch =
                        homeController.customerLocations.where((element) {
                      return element.locationName ==
                          homeController.inspectionDropdownValue.value;
                    }).toList();

                    homeController.getCustomerEquipments(
                        context, loctionIdSearch[0].locationId);
                  }
                },
                child: Text('Choose Equipment')),
          Obx(() => homeController.isChooseEquipment.value == true &&
                  homeController.isuserLogin.value == true
              ? Text(
                  'Select Location First!',
                  style: TextStyle(color: Colors.red, fontSize: 12.sp),
                )
              : Container()),
          SizedBox(
            height: 5.h,
          ),
          GetBuilder<HomeController>(builder: (selectData) {
            return selectData.isuserLogin.value == true &&
                    selectData.equipmentListCustomer.isNotEmpty
                ? Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      collapsedShape: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(197, 22, 22, 22))),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      title: Text(
                        "View Selected Equipments",
                        style: TextStyle(
                          fontFamily: "Helvetica Neue",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorResources.color294C73,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              selectData.equipmentListCustomer.length,
                              (index) => Container(
                                margin: EdgeInsets.only(
                                    left: 15.w, right: 15.w, bottom: 10.h),
                                width: Get.width,
                                padding: EdgeInsets.all(10.sp),
                                decoration: BoxDecoration(
                                    color: ColorResources.whiteColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all()),
                                child: Text(
                                  '${selectData.equipmentListCustomer.elementAt(index)['Equipment_Name']}',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container();
          }),
          if (homeController.isuserLogin.value == true)
            datepickerWidget(
                titleSpacing: 0,
                initialDate: DateTime.now(),
                startDate: DateTime.now(),
                context: context,
                datePickController: homeController.inspectionDateController,
                labelText: 'Inspection Date',
                titleText: ''),
          if (homeController.isuserLogin.value == true)
            SizedBox(
              height: 11.h,
            ),
          if (homeController.isuserLogin.value == true)
            TextFormField(
              controller: homeController.inspectionMessageController,
              maxLines: 3,
              maxLength: 250,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.chat_bubble_outline),
                  labelText: 'Remark',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 27, 27, 27)))),
            ),
          ElevatedButton(
            style: AppStyles.getPrimaryButtonStyle(context),
            onPressed: () {
              print('fdere');
              if (homeController.isuserLogin.value == true) {

                if (homeController.inspectionDropdownValue.value == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Select location!')));
                } else if (homeController.equipmentListCustomer.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Choose Equipment!')));
                } else if (homeController
                    .inspectionDateController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Choose Inspection Date!')));
                } else if (homeController
                    .inspectionMessageController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Remark!')));
                }

                if (homeController.inspectionDropdownValue.value != '' &&
                    homeController
                        .inspectionMessageController.text.isNotEmpty &&
                    homeController.inspectionDateController.text.isNotEmpty &&
                    homeController.equipmentListCustomer.isNotEmpty) {
                  homeController.saveCustomerRequest(context: context);
                }
              } else {
                // homeController.publicTextboxValidation();

                homeController.pageIndex.value = 1;

                globalHomeController.pageIndex.value = 1;
              }

              // Get.to(()=>const  ExpiringEquipmentScreen(),);
            },
            child: Text('Enquire Now'),
          ),
        ],
      ),
    );
  }

  Column datepickerWidget(
      {required BuildContext context,
      required String labelText,
      required DateTime initialDate,
      required DateTime startDate,
      required double titleSpacing,
      required TextEditingController datePickController,
      required String titleText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: titleSpacing.h,
        ),
        SizedBox(
          height: 80.h,
          child: TextField(
            style: TextStyle(fontSize: 14.sp),
            controller: datePickController,
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18.sp,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black)),
                label: Text(
                  labelText,
                  style: const TextStyle(color: Colors.black),
                )),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  barrierDismissible: false,
                  context: context,
                  initialDate: initialDate,
                  firstDate: startDate,
                  lastDate: DateTime(2101));

              String formattedDate =
                  DateFormat('dd-MM-yyyy').format(pickedDate!);

              setState(() {
                datePickController.text = formattedDate;
              });
            },
          ),
        ),
      ],
    );
  }
}

List<String> data = ['Trans Asia', 'Uduppi'];
