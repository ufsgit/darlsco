// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/model/home/reschedule_model.dart';
import 'package:darlsco/model/training/get_location_count_model.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:darlsco/view/widgets/common_back_button_phase2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/training/specific_order_details_model.dart';

class Trostun_Industries extends StatefulWidget {
  final SpecificOrderDetailsModel orderItem;
  final GetLocationCountModel getLocationCountModel;
  final previousPageSetState;
  const Trostun_Industries(
      {super.key,
      required this.previousPageSetState,
      required this.orderItem,
      required this.getLocationCountModel});

  @override
  State<Trostun_Industries> createState() => _Trostun_IndustriesState();
}

class _Trostun_IndustriesState extends State<Trostun_Industries> {
  @override
  void initState() {

     trainingController.trainingRescheduleController.clear();
   
    super.initState();
  }
  TextEditingController notesController = TextEditingController();
  DateTime? selectDate;
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(now);
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          commonBackgroundLinearColorCart(
            childWidget: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // InkWell(
                            //   onTap: () {
                            //     Get.back();
                            //   },
                            //   child: CircleAvatar(
                            //       radius: 18.h,
                            //       backgroundColor: ColorResources.colorDBE8FC,
                            //       child: Padding(
                            //         padding: const EdgeInsets.only(left: 8),
                            //         child: Icon(
                            //           Icons.arrow_back_ios,
                            //           size: 30.h,
                            //           color: ColorResources.color294C73,
                            //         ),
                            //       ),
                            //     ),
                            // ),
                            SizedBox(
                              height: 35.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget
                                          .getLocationCountModel.trainingCourseName,
                                      style: TextStyle(
                                          fontSize: 35.sp.h,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF294C73)),
                                    ),
                                  ),
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35.sp.h,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 0.1
                                      ..color = Color(0xFF294C73),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Text(
                                      //     widget.getLocationCountModel
                                      //         .trainingCourseName,
                                      //     style: TextStyle(
                                      //       fontSize: 16.sp.h,
                                      //       color: Color(0xFF294C73),
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Requesting Date",
                                          style: TextStyle(
                                            fontSize: 14.sp.h,
                                            color: Color(0xFF294C73),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                    
                    
                    
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 16.w),
                                        width: Get.width,
                                        child: TextField(
                                          controller: trainingController.trainingRescheduleController,
                                          style: TextStyle(fontSize: 14.sp),
                                          
                                          decoration: InputDecoration(
                    
                    
                    
                    
                    
                                              focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(
                                                      0xFFCECECE)), // Set border color here
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(
                                                      0xFFCECECE)), // Set border color here
                                            ),
                                              // focusedBorder:
                                              //     const OutlineInputBorder(
                                              //   borderSide: BorderSide(
                                              //     color: ColorResources.colorBlack,
                                              //   ),
                                              // ),
                                              // enabledBorder:
                                              //     const OutlineInputBorder(
                                              //   borderSide: BorderSide(
                                              //     color: Color(0xFFCECECE),
                                              //   ),
                                              // ),
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 8.h, horizontal: 8.w),
                                              suffixIcon: Icon(
                                                Icons.calendar_today,
                                                size: 18.sp,
                                                color: ColorResources.color294C73,
                                              ),
                                              border: const OutlineInputBorder(),
                                              hintText:
                                                  'Requesting Date'),
                                          readOnly: true,
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2101));
                    
                                            print(pickedDate);
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(pickedDate!);
                                                    print(formattedDate);
                                                    selectDate=pickedDate;
                  
                                                    // selectDate= DateTime.parse(formattedDate);
                                                    trainingController.trainingRescheduleController.text=formattedDate;
                                           
                                           
                                                                                    },
                                        ),
                                      ),
                    
                    
                    
                    
                    
                                      
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: DatePickerExample(
                                      //     hintText: 'Requesting Date',
                                          
                                      //     onDateSelected: (DateTime selectedDate) {
                                      //       selectDate = selectedDate;
                                      //       print(selectDate);
                                      //     },
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 8),
                                      //   child: Text(
                                      //     "Date may vary based on availability of trainer",
                                      //     style: TextStyle(
                                      //         fontSize: 12.sp.h,
                                      //         color: Colors.grey),
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Reason",
                                          style: TextStyle(
                                            fontSize: 12.sp.h,
                                            color: Color(0xFF294C73),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: notesController,
                                          maxLength: 800,
                                          decoration: InputDecoration(
                                            hintText: "Reason",
                                            hintStyle: TextStyle(fontSize: 16.sp.h),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(
                                                      0xFFCECECE)), // Set border color here
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(
                                                      0xFFCECECE)), // Set border color here
                                            ),
                                          ),
                                          // maxLines: 3,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    commonBackButton(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: elevatedButtonWidget(
              context: context,
              text: 'Submit',
              width: Get.width,
              backgroundColor: ColorResources.colorE5AA17,
              txtColor: ColorResources.colorBlack,
              onPressed: () async {
                if ( trainingController.trainingRescheduleController.text.isNotEmpty&&notesController.text.isNotEmpty ) {
                  print('Selected Date: $selectDate');
                  print('Notes: ${notesController.text}');

                  try {
                    await trainingController.rescheduleCourse( 



                        RescheduleUser(
                          
                          orderDetailsId:
                              widget.getLocationCountModel.orderDetailsId,
                          trainingCourseId:
                              widget.getLocationCountModel.trainingCourseId,
                          trainingCourseCategoryId: widget
                              .getLocationCountModel.trainingCourseCategoryId,
                              orderNo: widget.orderItem.orderNo,
                              orderLocationName: widget.getLocationCountModel.locationName,
                              startTime: widget.getLocationCountModel.startTime,
                              endTime: widget.getLocationCountModel.endTime,
                          trainingCourseName:
                              widget.getLocationCountModel.trainingCourseName,
                          categoryName:
                              widget.getLocationCountModel.categoryName,
                          rescheduleDate: selectDate.toString(),
                          trainerId: widget.getLocationCountModel.trainerId,
                          trainerName: widget.getLocationCountModel.trainerName,
                          notes: notesController.text,
                          currentStatusId:
                              widget.getLocationCountModel.currentStatusId,
                          currentStatusName:
                              widget.getLocationCountModel.currentStatusName,
                          // userId: 0,
                          // remarks: widget.orderItem.currentStatusName,
                          orderLocationId: widget.getLocationCountModel.orderLocationId,
                          quantity: widget.orderItem.quantity,
                          orderDetailsSubId: widget.getLocationCountModel.orderDetailsSubId
                        ),
                        context);
                  } catch (e) {
                    Get.snackbar(
                      'Failed',
                      'Failed to reschedule course: $e',
                  
                      colorText: Colors.black,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                  trainingController.update();
                } else if(trainingController.trainingRescheduleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Choose Requesting Date!')));
                }else if(notesController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Reason is Required!')));
                }
               widget.previousPageSetState((){});

                trainingController.update();
              },
            ),
          )
        ],
      )),
    );
  }
}
