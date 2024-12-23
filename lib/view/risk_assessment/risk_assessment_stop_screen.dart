import 'package:darlsco/controller/risk_assessment/risk_assessment_controller.dart';
import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/view/training/training_inspection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/upcoming_inspections/upcoming_inspection_controller.dart';

class RiskAssesmentStopScreen extends StatefulWidget {
  const RiskAssesmentStopScreen({super.key});

  @override
  State<RiskAssesmentStopScreen> createState() =>
      _RiskAssesmentStopScreenState();
}

class _RiskAssesmentStopScreenState extends State<RiskAssesmentStopScreen> {
  final TrainingController tcontoller = Get.put(TrainingController());

  final RiskAssessmentController riskAssessmentController =
      Get.put(RiskAssessmentController());
  final UpcomingInspectionsController upcomingInspectionController =
      Get.put(UpcomingInspectionsController());
  final TrainingController tcontroller = Get.put(TrainingController());
  @override
  void initState() {
    initfn();

    tcontoller.stopScreenTextController = TextEditingController();
    riskAssessmentController.stopnoteController.clear();
    tcontoller.selectedStatusValue.value = '';
    upcomingInspectionsController.isEquipmentSelected.value = false;

    upcomingInspectionsController.eqList =
        upcomingInspectionsController.taskEquipmentListData;

    upcomingInspectionsController.eqList
        .removeWhere((element) => element['Equipment_Id'] == 0);
    upcomingInspectionsController.eqList =
        upcomingInspectionsController.eqList.map((e) {
      return {
        "Task_Equipment_Id": e['Task_Equipment_Id'],
        "Equipment_Id": e['Equipment_Id'],
        "Equipment_Name": e['Equipment_Name'],
        "Checked": 0,
        "Task_Status_Name": "",
        "Task_Status_Id": 0,
      };
    }).toList();

    super.initState();
  }

  initfn() async {
    await tcontoller.loadTaskStatus();
    await tcontoller.getAllUserTaskStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              upcomingInspectionsController.getUserTaskDetails(
                taskId: int.parse(upcomingInspectionsController
                    .taskDetailsData[0]['Task_Id']
                    .toString()),
                isNotPageNavigation: true,
              );
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      // bottomNavigationBar: SizedBox(
      //   height: 115.h,
      //   child: Column(
      //     children: [

      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Container(
            padding: EdgeInsets.all(15.sp),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<TrainingController>(
                            init: TrainingController(),
                            builder: (tData) {
                              return DropdownButtonFormField(
                                  value: tData.selectedStatusValue.value == ''
                                      ? null
                                      : tData.selectedStatusValue.value,
                                  decoration: const InputDecoration(

                                      // hintText: data.inspectionDropdownValue.value
                                      //     .isEmpty? 'Location':'',
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                  onChanged: (value) {
                                    print(
                                        "printed statyus  ${value.toString()}");
                                    if (value != null) {
                                      tcontoller.selectedStatusValue.value =
                                          value.toString();
                                    }
                                    // if (value == 'Finished') {
                                    //   customEquipmentDialogue(context);
                                    // }

                                    print(tData.selectedStatusValue.value);
                                  },
                                  hint: const Text(
                                    'Task Status',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  items: tData.taskStatusList
                                      .map((e) => DropdownMenuItem(
                                            value: e['Task_Status_Name'],
                                            child: SizedBox(
                                                width: Get.width > 615
                                                    ? 600.w
                                                    : 250.w,
                                                child: Text(
                                                  e['Task_Status_Name'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                )),
                                          ))
                                      .toList());
                            }),
                        SizedBox(
                          height: 15.w,
                        ),

                        upcomingInspectionsController.taskUserDetails[0]
                                        ['Role_Id']
                                    .toString() ==
                                '38'
                            ? SizedBox(
                                // height: 200.w,
                                // width: 500.w,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.settings,
                                          size: 20.sp,
                                          color: ColorResources.color294C73,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          'Equipment Status',
                                          style: TextStyle(
                                              color: ColorResources.color294C73,
                                              fontSize: 16.sp),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.w,
                                    ),
                                    GetBuilder<UpcomingInspectionsController>(
                                        builder: (eqlistData) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            eqlistData.eqList.length,
                                            (index) => Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width > 615
                                                            ? 400.w
                                                            : 200.w,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 10,
                                                                child: Icon(
                                                                  Icons.circle,
                                                                  size: 10.w,
                                                                )),
                                                            Expanded(
                                                              flex: 70,
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 10
                                                                            .w),
                                                                child: Text(eqlistData
                                                                            .eqList[
                                                                        index][
                                                                    'Equipment_Name']),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Container(
                                                          width: Get.width > 615
                                                              ? 200.w
                                                              : 150.w,
                                                          height: 40
                                                              .w, // Set the desired width here
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.w),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          child: GetBuilder<
                                                                  UpcomingInspectionsController>(
                                                              builder:
                                                                  (eqStatus) {
                                                            return DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton<
                                                                      dynamic>(
                                                                isExpanded:
                                                                    true,
                                                                hint: Text(
                                                                  eqStatus.eqList[index]['Task_Status_Name'] ==
                                                                              null ||
                                                                          eqStatus
                                                                              .eqList[index][
                                                                                  'Task_Status_Name']
                                                                              .isEmpty
                                                                      ? 'status'
                                                                      : eqStatus
                                                                              .eqList[index]
                                                                          [
                                                                          'Task_Status_Name'],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12.sp),
                                                                ),
                                                                items: eqStatus
                                                                    .equipmentStatusLIst
                                                                    .map(
                                                                        (value) {
                                                                  return DropdownMenuItem<
                                                                      dynamic>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value[
                                                                            'Task_Status_Name']),
                                                                  );
                                                                }).toList(),
                                                                onChanged:
                                                                    (newValue) {
                                                                  if (newValue !=
                                                                      null) {
                                                                    eqStatus.eqList[index]
                                                                            [
                                                                            'Task_Status_Id'] =
                                                                        newValue[
                                                                            'Task_Status_Id'];

                                                                    eqStatus.eqList[index]
                                                                            [
                                                                            'Task_Status_Name'] =
                                                                        newValue[
                                                                            'Task_Status_Name'];
                                                                  }
                                                                  upcomingInspectionsController
                                                                      .update();

                                                                  print(eqStatus
                                                                      .eqList);
                                                                },
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                      );
                                    }),
                                  ],
                                ),
                              )
                            : Container()

                        // Obx(
                        //   () => SizedBox(
                        //     width: Get.width,
                        //     child:
                        //         tcontoller.selectedStatusValue.value == 'Finished'
                        //             ? Column(
                        //                 children: [
                        //                   Text(
                        //                     'Equipment List',
                        //                     style: TextStyle(
                        //                         color: ColorResources.color294C73),
                        //                   ),
                        //                   SizedBox(
                        //                     height: 15.w,
                        //                   ),
                        //                   Wrap(
                        //                     spacing: 15.w,
                        //                     runSpacing: 15.w,

                        //                     // crossAxisAlignment: CrossAxisAlignment.start,
                        //                     children: List.generate(
                        //                      eqList
                        //                             .length, (index) {
                        //                       return GetBuilder<
                        //                               UpcomingInspectionsController>(
                        //                           builder: (eqpmentListData) {
                        //                         return SizedBox(
                        //                           width: 150.w,
                        //                           child: Row(
                        //                             crossAxisAlignment: CrossAxisAlignment.start,
                        //                             children: [
                        //                               Checkbox(
                        //                                   value: eqList[
                        //                                                   index][
                        //                                                   'Checked']
                        //                                               .toString() ==
                        //                                           '1'
                        //                                       ? true
                        //                                       : false,
                        //                                   onChanged: (value) {
                        //                                     print(value);

                        //                                     if (eqList[
                        //                                                 index][
                        //                                             'Equipment_Name'] !=
                        //                                         'Other') {
                        //                                     eqList[
                        //                                                   index]
                        //                                               ['Checked'] =
                        //                                           (value == true
                        //                                               ? 1
                        //                                               : 0);
                        //                                     } else {
                        //                                     eqList[
                        //                                                   index]
                        //                                               ['Checked'] =
                        //                                           (value == true
                        //                                               ? 1
                        //                                               : 0);

                        //                                       if (eqList[
                        //                                                   index][
                        //                                                   'Checked']
                        //                                               .toString() ==
                        //                                           '1') {
                        //                                         tcontoller
                        //                                             .othersChecked
                        //                                             .value = true;
                        //                                       } else {
                        //                                         tcontoller
                        //                                             .othersChecked
                        //                                             .value = false;
                        //                                       }
                        //                                     }
                        //                                     setState(() {

                        //                                     });

                        //                                     // upcomingInspectionsController
                        //                                     //     .update();
                        //                                     // tcontoller.update();

                        //                                     //  upcomingInspectionsController.taskEquipmentListData=upcomingInspectionsController.taskEquipmentListData.map((e) => {

                        //                                     //    "Task_Equipment_Id" :  e['Task_Equipment_Id'],
                        //                                     //    "Equipment_Id": e['Equipment_Id'],
                        //                                     //    "Equipment_Name":e['Equipment_Name'],
                        //                                     //    "Checked":0

                        //                                     //  }).toList();
                        //                                   }),
                        //                               SizedBox(
                        //                                 width: 5.w,
                        //                               ),
                        //                               SizedBox(
                        //                                 width: 100.w,
                        //                                 child: Text(
                        //                                   ' ${eqList[index]['Equipment_Name']}',
                        //                                   style: TextStyle(
                        //                                     fontFamily: "Roboto",
                        //                                     fontSize: 13.sp,
                        //                                     fontWeight:
                        //                                         FontWeight.w400,
                        //                                     color: ColorResources
                        //                                         .color0d0d0d,
                        //                                   ),
                        //                                 ),
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         );
                        //                       });
                        //                     }),
                        //                   ),
                        //                 ],
                        //               )
                        //             : Container(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.w,
                  ),

                  //   Obx(
                  //  ()=>  tcontoller.selectedStatusValue.value.toString()=='Completed'&&upcomingInspectionsController.taskUserDetails[0]
                  //                             ['Role_Id']
                  //                         .toString() ==
                  //                     '38'?Container(

                  //             decoration: BoxDecoration(

                  //                color: Colors.green,
                  //                borderRadius: BorderRadius.circular(15.w)

                  //             ),
                  //             child: IconButton(
                  //               onPressed: () {

                  //                  customEquipmentDialogue(context);

                  //               },
                  //               icon: SizedBox(
                  //                 height: 35.h,
                  //                 child: Center(
                  //       child: Text("Finish",
                  //           style: TextStyle(
                  //             color: ColorResources.whiteColor,
                  //             fontSize: 16.sp,
                  //             fontWeight: FontWeight.w500,
                  //           ))),
                  //               ),
                  //             ),
                  //           ):Container(),
                  //   ),
                  //    SizedBox(
                  //     height: 15.w,
                  //   ),

                  // Obx(() => upcomingInspectionsController
                  //                 .isEquipmentSelected.value ==
                  //             true
                  //         ? InkWell(
                  //             onTap: () {
                  //               customEquipmentDialogue(context);
                  //             },
                  //             child: Container(
                  //               padding: EdgeInsets.all(10.w),
                  //               decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10.w)),
                  //               height: 40.h,
                  //               child: Center(
                  //                   child: Text('View Selected Equipments')),
                  //             ),
                  //           )
                  //         : Container()),
                  // SizedBox(
                  //           height: 15.w,
                  //         ),

                  SizedBox(
                    child: Column(children: [
                      TextFormField(
                        // controller: tcontoller.stopScreenTextController,
                        controller: riskAssessmentController.stopnoteController,
                        maxLines: 6,
                        onChanged: (value) {
                          print(
                              riskAssessmentController.stopnoteController.text);
                        },
                        maxLength: 800,
                        style: TextStyle(fontSize: 14.sp),
                        decoration: InputDecoration(
                          focusColor: Colors.grey,
                          hintText: 'Enter Comments',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                      ),

                      // Obx(
                      //   () {
                      //     if (tcontoller.selectedStatusValue.value ==
                      //             'Completed' &&
                      //         upcomingInspectionsController.taskUserDetails[0]
                      //                     ['Role_Id']
                      //                 .toString() ==
                      //             '38') {
                      //       return Column(
                      //         children: [
                      //           SizedBox(
                      //             height: 15.h,
                      //           ),
                      //           Container(
                      //             color: Colors.green,
                      //             child: IconButton(
                      //               onPressed: () {
                      //                 customEquipmentDialogue(context);
                      //               },
                      //               icon: SizedBox(
                      //                 height: 50.h,
                      //                 child: Center(
                      //                     child: Text("Finish your job order",
                      //                         style: TextStyle(
                      //                           color:
                      //                               ColorResources.whiteColor,
                      //                           fontSize: 20.sp,
                      //                           fontWeight: FontWeight.w500,
                      //                         ))),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       );
                      //     } else {
                      //       return Container();
                      //     }
                      //   },
                      // ),
                      // InkWell(
                      //     onTap: () {
                      //       customEquipmentDialogue(context);
                      //     },
                      //     child: Container(
                      //       color: Colors.green,
                      //       child: Text(
                      //         'Finish your job order',
                      //         style: TextStyle(fontSize: 20.sp),
                      //       ),
                      //     )),
                      SizedBox(
                        height: 15.h,
                      ),

                      // if(isbtton)    Align(
                      //       alignment: Alignment.bottomRight,
                      //       child: IconButton(
                      //         onPressed: () {
                      //           //need to add  (add note function)
                      //         },
                      //         icon: Container(
                      //           width: 103.w,
                      //           height: 40.h,
                      //           decoration: BoxDecoration(
                      //               border: Border.all(color: Colors.grey),
                      //               borderRadius: BorderRadius.circular(5.r),
                      //               color: Colors.black.withOpacity(0.08)),
                      //           child: Center(
                      //             child: Text(
                      //               "Add Note",
                      //               style: TextStyle(
                      //                 fontFamily: "Roboto",
                      //                 fontSize: 14.sp,
                      //                 fontWeight: FontWeight.w400,
                      //                 color: Colors.black,
                      //               ),
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                    ]),
                  ),

                  // commonNoteWidget(isReadOnly: false),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.red,
        child: IconButton(
          onPressed: () {
            final equipmentCheck = upcomingInspectionsController.eqList
                .where((element) => element['Checked'].toString() == '1')
                .toList();

            if (tcontoller.selectedStatusValue.value == '') {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Choose Task Status!')));
            } else if (upcomingInspectionsController.eqList
                    .where((element) => element['Task_Status_Name'] == '')
                    .toList()
                    .isNotEmpty &&
                upcomingInspectionsController.taskUserDetails[0]['Role_Id']
                        .toString() ==
                    '38') {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('All equipment statuses should be selected!')));
            } else if (riskAssessmentController
                .stopnoteController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please Enter Comments!')));
            } else if (tcontoller.getAllStaffStatus
                    .where((element) =>
                        element['Task_Status_Id'].toString() == '4' ||
                        element['Task_Status_Id'].toString() == '1')
                    .toList()
                    .isNotEmpty &&
                upcomingInspectionsController.taskUserDetails[0]['Role_Id']
                        .toString() ==
                    '38') {
              //  print(tcontoller.getAllStaffStatus.where((element) => element['Task_Status_Id'].toString() == '4'||element['Task_Status_Id'].toString() == '1').toList());

              showDialog(
                barrierDismissible: true,
                context: Get.context!,
                builder: (ctx) => AlertDialog(
                  // title: const Text(
                  //   'Logout',
                  //   style: TextStyle(fontWeight: FontWeight.w800),
                  // ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(tcontoller.getAllStaffStatus
                    .where((element) =>
                        element['Task_Status_Id'].toString() == '4'
                       )
                    .toList()
                    .isNotEmpty &&
                upcomingInspectionsController.taskUserDetails[0]['Role_Id']
                        .toString() ==
                    '38'?"You can't stop your task if any other team member's task status is 'In Progress'. The members' statuses are:":
                          "Are you sure you want to stop your task while another team member's status is 'Not Started'?",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                tcontoller.getAllStaffStatus.length,
                                (index) => Column(
                                      children: [
                                        Text(
                                          '${tcontoller.getAllStaffStatus[index]['User_Details_Name']}  - ${tcontoller.getAllStaffStatus[index]['Task_Status_Name']}',
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ))),
                        TextButton(
                          child: Text(tcontoller.getAllStaffStatus
                                      .where((element) =>
                                          element['Task_Status_Id']
                                              .toString() ==
                                          '4')
                                      .toList()
                                      .isNotEmpty &&
                                  upcomingInspectionsController
                                          .taskUserDetails[0]['Role_Id']
                                          .toString() ==
                                      '38'
                              ? 'Ok'
                              : 'Stop'),
                          onPressed: () {
                            Get.back();

                            if (tcontoller.getAllStaffStatus
                                    .where((element) =>
                                        element['Task_Status_Id'].toString() ==
                                        '4')
                                    .toList()
                                    .isNotEmpty &&
                                upcomingInspectionsController.taskUserDetails[0]
                                            ['Role_Id']
                                        .toString() ==
                                    '38') {
                              Get.to(() => const TrainingInspectionScreen());
                            } else {
                              riskAssessmentController.saveTaskStop(
                                  tcontoller.selectedStatusValue.value,
                                  riskAssessmentController
                                      .stopnoteController.text);
                            }

                            // Get.to(()=>TrainingInspectionScreen());
                          },
                        ),

                     tcontoller.getAllStaffStatus
                                      .where((element) =>
                                          element['Task_Status_Id']
                                              .toString() ==
                                          '4')
                                      .toList()
                                      .isNotEmpty &&
                                  upcomingInspectionsController
                                          .taskUserDetails[0]['Role_Id']
                                          .toString() ==
                                      '38'?   Container():TextButton(onPressed: (){
                                         Get.to(()=>const TrainingInspectionScreen());
                          

                        }, child: Text('Cancel',style: TextStyle(fontSize: 12.sp),))
                      ],
                    ),
                  ),
                  // actions: [
                  //   TextButton(
                  //     child: const Text('OK'),
                  //     onPressed: () {
                  //       Get.back();

                  //       Get.to(()=>TrainingInspectionScreen());
                  //     },
                  //   ),
                  // ],
                ),
              );
            } else {
              riskAssessmentController.saveTaskStop(
                  tcontoller.selectedStatusValue.value,
                  riskAssessmentController.stopnoteController.text);

              // api stop
            }
          },
          icon: SizedBox(
            height: 50.h,
            child: Center(
                child: Text("Stop",
                    style: TextStyle(
                      color: ColorResources.whiteColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ))),
          ),
        ),
      ),
    );
  }

  Future<dynamic> customEquipmentDialogue(BuildContext context) {
    return showDialog(
        barrierColor: ColorResources.color294C73.withOpacity(0.2),
        barrierDismissible: false,
        context: context,
        builder: (ctx) => Center(
              child: AlertDialog(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                alignment: Alignment.center,
                actions: [
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 15.w),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {
                          final equipmentCheck = upcomingInspectionsController
                              .eqList
                              .where((element) =>
                                  element['Checked'].toString() == '1')
                              .toList();

                          if (equipmentCheck.isEmpty) {
                            tcontoller.equipmentValidationStop.value = true;

                            // ScaffoldMessenger.of(ctx).showSnackBar(
                            //     const SnackBar(
                            //         content:
                            //             Text('Choose atleast one equipment!')));
                          } else if (tcontoller
                              .stopScreenFinishTextController.text.isEmpty) {
                            tcontoller.finishNoteValidationStop.value = true;

                            // ScaffoldMessenger.of(ctx).showSnackBar(
                            //     const SnackBar(
                            //         content: Text('Please Enter Feedback!')));
                          } else {
                            Get.back();

                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (ctx) => AlertDialog(
                                // title: const Text(
                                //   'Logout',
                                //   style: TextStyle(fontWeight: FontWeight.w800),
                                // ),
                                content: const SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Are you sure you want to finish your job order? Click the stop button after clicking 'Yes' to complete your task.")
                                      ]),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () {
                                      upcomingInspectionsController.eqList
                                          .removeWhere((element) =>
                                              element['Equipment_Id'] == 0);
                                      upcomingInspectionsController.eqList =
                                          upcomingInspectionsController.eqList
                                              .map((e) {
                                        return {
                                          "Task_Equipment_Id":
                                              e['Task_Equipment_Id'],
                                          "Equipment_Id": e['Equipment_Id'],
                                          "Equipment_Name": e['Equipment_Name'],
                                          "Checked": 0,
                                        };
                                      }).toList();

                                      upcomingInspectionsController
                                          .isEquipmentSelected.value = false;
                                      tcontoller.stopScreenFinishTextController
                                          .clear();
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () async {
                                      upcomingInspectionsController
                                          .isEquipmentSelected.value = true;
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                ],
                contentPadding: EdgeInsets.all(10.sp),
                content: SingleChildScrollView(
                  child: Container(
                    // height: 400.w,
                    // margin: EdgeInsets.symmetric(horizontal: 20.w),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      final equipmentCheck =
                                          upcomingInspectionsController.eqList
                                              .where((element) =>
                                                  element['Checked']
                                                      .toString() ==
                                                  '1')
                                              .toList();

                                      if (equipmentCheck.isEmpty) {
                                        upcomingInspectionsController
                                            .isEquipmentSelected.value = false;
                                      }
                                      tcontoller.stopScreenFinishTextController
                                          .clear();
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.close))),

                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Equipment List',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: ColorResources.color294C73),
                              ),
                            ),
                            SizedBox(
                              height: 15.w,
                            ),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  upcomingInspectionsController.eqList.length,
                                  (index) {
                                return GetBuilder<
                                        UpcomingInspectionsController>(
                                    builder: (eqpmentListData) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 15.w),
                                    width: 300.w,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                            value: eqpmentListData.eqList[index]
                                                            ['Checked']
                                                        .toString() ==
                                                    '1'
                                                ? true
                                                : false,
                                            onChanged: (value) {
                                              // ScaffoldMessenger.of(ctx).showSnackBar(
                                              //     const SnackBar(
                                              //         content:
                                              //             Text('Choose atleast one equipment!')));

                                              tcontoller.equipmentValidationStop
                                                  .value = false;

                                              print(value);

                                              if (eqpmentListData.eqList[index]
                                                      ['Equipment_Name'] !=
                                                  'Other') {
                                                eqpmentListData.eqList[index]
                                                        ['Checked'] =
                                                    (value == true ? 1 : 0);
                                              } else {
                                                eqpmentListData.eqList[index]
                                                        ['Checked'] =
                                                    (value == true ? 1 : 0);

                                                if (eqpmentListData
                                                        .eqList[index]
                                                            ['Checked']
                                                        .toString() ==
                                                    '1') {
                                                  tcontoller.othersChecked
                                                      .value = true;
                                                } else {
                                                  tcontoller.othersChecked
                                                      .value = false;
                                                }
                                              }
                                              setState(() {});

                                              upcomingInspectionsController
                                                  .update();
                                              // tcontoller.update();

                                              //  upcomingInspectionsController.taskEquipmentListData=upcomingInspectionsController.taskEquipmentListData.map((e) => {

                                              //    "Task_Equipment_Id" :  e['Task_Equipment_Id'],
                                              //    "Equipment_Id": e['Equipment_Id'],
                                              //    "Equipment_Name":e['Equipment_Name'],
                                              //    "Checked":0

                                              //  }).toList();
                                            }),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 240.w,
                                            child: Text(
                                              ' ${eqpmentListData.eqList[index]['Equipment_Name']}',
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorResources.color0d0d0d,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              }),
                            ),
                            // SizedBox(height: 50.h,),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        TextFormField(
                          controller: tcontoller.stopScreenFinishTextController,
                          maxLines: 6,
                          maxLength: 250,
                          style: TextStyle(fontSize: 14.sp),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              tcontoller.finishNoteValidationStop.value = false;
                            } else {
                              tcontoller.finishNoteValidationStop.value = true;
                            }
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.grey,
                            hintText: 'Enter Feedback',
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                        ),
                        Obx(() => tcontoller.equipmentValidationStop.value ==
                                true
                            ? Text(
                                'Choose atleast one equipment!',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.sp),
                              )
                            : tcontoller.finishNoteValidationStop.value == true
                                ? Text('Please Enter Feedback!',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14.sp))
                                : Container())
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
