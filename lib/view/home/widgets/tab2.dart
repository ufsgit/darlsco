import 'package:darlsco/model/home/location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/home/home_controller.dart';
import '../../../core/constants/color_resources.dart';
import '../../../core/constants/common_widgets.dart';

import 'common_bottom_widget.dart';

class Tab2 extends StatefulWidget {
  final List<String> imgurlList;
  final RichText mainTitleWidget;
  final Widget cContainer;
  final String btnText;
  const Tab2(
      {super.key,
      required this.imgurlList,
      required this.mainTitleWidget,
      required this.cContainer,
      required this.btnText});

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  @override
  void initState() 
  {
    homeController.checkCountryCode(context);
    homeController.inspectionDropdownValue.value = '';
    homeController.equipmentListCustomer = {};
    homeController.inspectionDateController.clear();
    homeController.inspectionMessageController.clear();
    homeController.isChooseEquipment.value = false;
    super.initState();
  }

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return commonBackgroundLinearColorTab(
      childWidget: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: RefreshIndicator(
          onRefresh: () async {
            if (homeController.isuserLogin.value == true) {
              await homeController.initfunction();
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                widget.cContainer,
                Container(
                    margin: EdgeInsets.only(top: 20.h),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: widget.mainTitleWidget),
                SizedBox(
                  height: 15.w,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: ColorResources.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.sp),
                          topRight: Radius.circular(20.sp))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width,
                        height: Get.width > 615 ? 400.w : 179.w,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.imgurlList.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.h,
                          ),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: Get.width > 615 ? 400.w : 179.w,
                              width: Get.width > 615 ? 750.w : 320.w,
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.width > 615 ? 400.w : 163.w,
                                    width: Get.width > 615 ? 750.w : 347.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                        image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/inspection home image.png')
                                            // NetworkImage(imgurlList[index])

                                            )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 24.w),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: 58.h,
                                        width: 58.w,
                                        decoration: const BoxDecoration(
                                            color: ColorResources.colorE5AA17,
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_downward,
                                            size: 38.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      if (homeController.isuserLogin.value == true)
                        Text(
                          "Please fill out the form",
                          style: TextStyle(
                            fontFamily: "Helvetica Neue",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorResources.color294C73,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      SizedBox(
                        height: 15.w,
                      ),
                      Form(
                          child: Column(
                        children: [
                          // SizedBox(
                          //   height: 11.h,
                          // ),
                          // TextFormField(
                          //   controller:
                          //       homeController.inspectionFullNameController,
                          //   decoration: const InputDecoration(
                          //       prefixIcon: Icon(Icons.person_outline_outlined),
                          //       labelText: 'Full Name',
                          //       border: OutlineInputBorder()),
                          // ),
                          // SizedBox(
                          //   height: 11.h,
                          // ),

                          if (homeController.isuserLogin.value == true)
                            GetBuilder<HomeController>(builder: (data) {
                              return DropdownButtonFormField(
                                  value:
                                      data.inspectionDropdownValue.value == ''
                                          ? null
                                          : data.inspectionDropdownValue.value,
                                  decoration: const InputDecoration(

                                      // hintText: data.inspectionDropdownValue.value
                                      //     .isEmpty? 'Location':'',
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                  onChanged: (value) {
                                    homeController.isChooseEquipment.value =
                                        false;
                                    data.equipmentListCustomer.clear();
                                    data.equipmentCheckValue.clear();
                                    data.inspectionDropdownValue.value =
                                        value.toString();
                                  },
                                  hint: const Text(
                                    'Location',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  items: data.customerLocations
                                      .map((e) => DropdownMenuItem(
                                            value: e.locationName,
                                            child: SizedBox(
                                                width: Get.width > 615
                                                    ? 600.w
                                                    : 250.w,
                                                child: Text(
                                                  e.locationName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                )),
                                          ))
                                      .toList());
                            }),
                          // : TextFormField(
                          //     controller:
                          //         homeController.inspectionLocationController,
                          //     decoration: const InputDecoration(
                          //         prefixIcon:
                          //             Icon(Icons.location_on_outlined),
                          //         labelText: 'Location',
                          //         border: OutlineInputBorder()),
                          //   ),

                          // TextFormField(
                          //   controller: homeController.inspectionLocationController,

                          //   decoration: const InputDecoration(
                          //       prefixIcon: Icon(Icons.mail_outline_outlined),
                          //       labelText: 'Location',
                          //       border: OutlineInputBorder()),
                          // ),
                          SizedBox(
                            height: 11.h,
                          ),
                          if (homeController.isuserLogin.value == true)
                            commonHmeButtonWidget(
                                ontap: () {

// ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(

              
              
//               content: Text('homeController.inspectionDropdownValue.value')));

                                  if (homeController
                                          .inspectionDropdownValue.value ==
                                      '') {
                                    homeController.isChooseEquipment.value =
                                        true;
                                  } else {
                                    final List<CustomerLocations>
                                        loctionIdSearch = homeController
                                            .customerLocations
                                            .where((element) {
                                      return element.locationName ==
                                          homeController
                                              .inspectionDropdownValue.value;
                                    }).toList();

                                    homeController.getCustomerEquipments(
                                        context, loctionIdSearch[0].locationId);
                                  }
                                },
                                buttonTxt: 'Choose Equipment'),
                          // : SizedBox(),

                          // TextFormField(
                          //     controller:
                          //         homeController.inspectionLocationController,
                          //     decoration: const InputDecoration(
                          //         prefixIcon:
                          //             Icon(Icons.mail_outline_outlined),
                          //         labelText: 'Location',
                          //         border: OutlineInputBorder()),
                          //   ),

                          Obx(() =>
                              homeController.isChooseEquipment.value == true &&
                                      homeController.isuserLogin.value == true
                                  ? Text(
                                      'Select Location First!',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12.sp),
                                    )
                                  : Container()),
                          SizedBox(
                            height: 5.h,
                          ),
                          GetBuilder<HomeController>(builder: (selectData) {
                            return selectData.isuserLogin.value == true &&
                                    selectData.equipmentListCustomer.isNotEmpty
                                ? Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      collapsedShape: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  197, 22, 22, 22))),
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                              selectData
                                                  .equipmentListCustomer.length,
                                              (index) => Container(
                                                margin: EdgeInsets.only(
                                                    left: 15.w,
                                                    right: 15.w,
                                                    bottom: 10.h),
                                                width: Get.width,
                                                padding: EdgeInsets.all(10.sp),
                                                decoration: BoxDecoration(
                                                    color: ColorResources
                                                        .whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    border: Border.all()),
                                                child: Text(
                                                  '${selectData.equipmentListCustomer.elementAt(index)['Equipment_Name']}',
                                                  style: TextStyle(
                                                      fontSize: 14.sp),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container();

                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Container(
                            //                  child:       selectData.isuserLogin.value == true&&selectData.equipmentListCustomer.isNotEmpty?     Column(

                            //                   crossAxisAlignment: CrossAxisAlignment.start,
                            //      children: [
                            //        Text(
                            //                              "Selected Equipments",
                            //                              style: TextStyle(
                            //                                fontFamily: "Helvetica Neue",
                            //                                fontSize: 20.sp,
                            //                                fontWeight: FontWeight.w500,
                            //                                color: ColorResources.color294C73,
                            //                              ),
                            //                              textAlign: TextAlign.left,
                            //                            ),

                            //      ],
                            //    ):Container()),
                            // );
                          }),
                          //for equipment list
                          // homeController.isuserLogin.value == true
                          //     ? GetBuilder<HomeController>(

                          //       builder: (data) {
                          //         return SingleChildScrollView(
                          //           child: Column(
                          //             crossAxisAlignment: CrossAxisAlignment.start,

                          //             children: List.generate(
                          //               data.equipmentListCustomer.length,
                          //               (index) => Container(
                          //                 margin: EdgeInsets.only(top: 10.h),
                          //                 width:  300.w,
                          //                 padding: EdgeInsets.all(10.sp),
                          //                 decoration: BoxDecoration(
                          //                     color: ColorResources.whiteColor,
                          //                     borderRadius:
                          //                         BorderRadius.circular(8.r),
                          //                     border: Border.all()),
                          //                 child: Text(
                          //                   '${data.equipmentListCustomer.elementAt(index)['Equipment_Name']}',
                          //                   style: TextStyle(fontSize: 14.sp),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       })
                          //     : TextFormField(
                          //         controller:
                          //             homeController.inspectionCategoryController,
                          //         decoration: const InputDecoration(
                          //             prefixIcon: Icon(Icons.category_outlined),
                          //             labelText: 'Choose Inspection Category',
                          //             border: OutlineInputBorder()),
                          //       ),

                          if (homeController.isuserLogin.value == true)
                            datepickerWidget(
                                titleSpacing: 0,
                                initialDate: DateTime.now(),
                                startDate: DateTime.now(),
                                context: context,
                                datePickController:
                                    homeController.inspectionDateController,
                                labelText: 'Inspection Date',
                                titleText: ''),
                          if (homeController.isuserLogin.value == true)
                            SizedBox(
                              height: 11.h,
                            ),

                          // TextFormField(
                          //   decoration: const InputDecoration(
                          //       prefixIcon: Icon(Icons.call_outlined),
                          //       labelText: 'Mobile Number',
                          //       border: OutlineInputBorder()),
                          // ),
                          // SizedBox(
                          //   height: 11.h,
                          // ),
                          if (homeController.isuserLogin.value == true)
                            TextFormField(
                              controller:
                                  homeController.inspectionMessageController,
                              maxLines: 3,
                              maxLength: 250,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.chat_bubble_outline),
                                  labelText: 'Remark',
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 27, 27, 27)))),
                            )
                        ],
                      )),
                      if (homeController.isuserLogin.value == true)
                        SizedBox(
                          height: 26.h,
                        ),
                      if (homeController.isuserLogin.value == false)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Building Trust through Perfection',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  color: ColorResources.colorE5AA17),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Our services are lasting, tangible benefits that address Quality, Financial, Health & Safety concerns. DARLSCO has Independent Inspections to cater to the requirements of clients/customers.',
                              textAlign: Get.width > 615
                                  ? TextAlign.center
                                  : TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorResources.color0d0d0d),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      Align(
                        alignment: Alignment.center,
                        child: commonHmeButtonWidget(
                          ontap: () {
                            print('fdere');
                            if (homeController.isuserLogin.value == true) {
                              //  Get.to(()=> DashBoardScreen());
                              // homeController.getCustomerPlace();

                              if (homeController
                                      .inspectionDropdownValue.value ==
                                  '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Select location!')));
                              } else if (homeController
                                  .equipmentListCustomer.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Choose Equipment!')));
                              } else if (homeController
                                  .inspectionDateController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Choose Inspection Date!')));
                              } else if (homeController
                                  .inspectionMessageController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Enter Remark!')));
                              }

                              if (homeController
                                          .inspectionDropdownValue.value !=
                                      '' &&
                                  homeController.inspectionMessageController
                                      .text.isNotEmpty &&
                                  homeController.inspectionDateController.text
                                      .isNotEmpty &&
                                  homeController
                                      .equipmentListCustomer.isNotEmpty) {
                                homeController.saveCustomerRequest(
                                    context: context);
                              }
                            } else {
                              // homeController.publicTextboxValidation();

                              homeController.pageIndex.value = 1;

                              globalHomeController.pageIndex.value = 1;
                            }

                            // Get.to(()=>const  ExpiringEquipmentScreen(),);
                          },
                          buttonTxt: homeController.isuserLogin.value == true
                              ? "${widget.btnText} Request"
                              : 'Enquiry  Now',
                        ),
                      ),
                      if (homeController.isuserLogin.value == false)
                        SizedBox(
                          height: 10.h,
                        ),
                    ],
                  ),
                ),
                if (homeController.isuserLogin.value == true)
                  SizedBox(
                    height: 10.h,
                  ),
                Obx(
                  () => Visibility(
                    visible: homeController.isuserLogin.value == false
                        ? true
                        : false,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Get.width > 615
                            ? commonBottomWidgetTab()
                            : commonBottomWidget()),
                  ),
                ),
              ],
            ),
          ),
        ),
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
            color: ColorResources.color294C73,
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
                  color: ColorResources.color294C73,
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
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

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);

                setState(() {
                  datePickController.text = formattedDate;
                });
              } else {}
            },
          ),
        ),
      ],
    );
  }

  IconButton commonHmeButtonWidget(
      {required ontap, required String buttonTxt}) {
    return IconButton(
      onPressed: ontap,
      icon: Container(
        height: 50.h,
        width: 346.w,
        decoration: BoxDecoration(
            color: ColorResources.colorE5AA17,
            borderRadius: BorderRadius.circular(43.sp)),
        child: Center(
          child: Text(
            buttonTxt,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: ColorResources.color0d0d0d,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
