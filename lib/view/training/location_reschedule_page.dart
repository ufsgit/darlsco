import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/model/training/get_location_count_model.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:darlsco/view/training_phase2/trostun_industries.dart';
import 'package:darlsco/view/widgets/common_back_button_phase2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/training/specific_order_details_model.dart';

class LocationReSchedulePage extends StatefulWidget {
  final SpecificOrderDetailsModel orderItem;
  final GetLocationCountModel locationModel;
  final int index;
  const LocationReSchedulePage(
      {super.key, required this.orderItem, required this.locationModel,required this.index});

  @override
  State<LocationReSchedulePage> createState() => _LocationReSchedulePageState();
}

class _LocationReSchedulePageState extends State<LocationReSchedulePage> {
  @override
  void initState() {
    // init();
    super.initState();

     }
  // init()async{
  //   await trainingController
  //       .getLocationsCount(widget.locationModel.orderDetailsId.toString());
 
  // }

  @override
  Widget build(BuildContext context) {
    widget.locationModel.startDate != 'Not assigned yet'
        ? tcontoller.isRescheduled.value = true
        : false;
    // DateTime parsedDate = DateTime.parse(widget.locationModel.startDate!);

    // String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    return SafeArea(
      child: Scaffold(
        body: commonBackgroundLinearColorCart(
            childWidget: Stack(
              children: [
                Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                          child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.w,),
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Get.back();
                    //     },
                    //     child: CircleAvatar(
                    //               radius: 18.h,
                    //               backgroundColor: ColorResources.colorDBE8FC,
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(left: 8),
                    //                 child: Icon(
                    //                   Icons.arrow_back_ios,
                    //                   size: 30.h,
                    //                   color: ColorResources.color294C73,
                    //                 ),
                    //               ),
                    //             ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 1, color: ColorResources.color294C73)
                          ],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 24.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.locationModel.trainingCourseName,
                                  style: TextStyle(
                                    fontSize: 20.sp.h,
                                    color: const Color(0xFF294C73),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GetBuilder<TrainingControllerHomee>(
                                      
                                      // initState: (state) {
                                      //   trainingController.getLocationsCount(widget
                                      //       .locationModel.orderDetailsId
                                      //       .toString());
                                      // },
                                      builder: (context) {
                                        return Column(
                                          children: [
                                            tableRowWidget(
                                              text: 'Order No',
                                              data: widget.locationModel.orderNo
                                                  .toString(),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            tableRowWidget(
                                              text: 'Category',
                                              data: widget
                                                  .locationModel.categoryName
                                                  .toString(),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                             tableRowWidget(
                                              text: 'Quantity',
                                              data: widget.locationModel
                                                  .traineeInLocationCount
                                                  .toString(),
                                            ),
                                            
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                             tableRowWidget(
                                              text: 'Duration',
                                              data:
                                                  "${widget.locationModel.duration} Hrs",
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                             tableRowWidget(
                                              text: 'Trainer Name',
                                              data:
                                                  widget.locationModel.trainerName,
                                            ),
                                             SizedBox(
                                              height: 16.h,
                                            ),
                                            
                                           
                                            GetBuilder<TrainingControllerHomee>(
                                               
                                                
                                                builder: (context) {
                                                  return tableRowWidget(
                                                    text: 'Start Date',
                                                    data: widget.locationModel
                                                            .startDate ??
                                                        'Not assigned yet',
                                                  );
                                                }),
                                                SizedBox(
                                              height: 16.h,
                                            ),
                
                
                                             tableRowWidget(
                                              text: 'Start Time',
                                              data:
                                                  widget.locationModel.startTime,
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                
                
                                             tableRowWidget(
                                              text: 'End Date',
                                              data:
                                                  widget.locationModel.endDate,
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                             tableRowWidget(
                                              text: 'End Time',
                                              data:
                                                  widget.locationModel.endTime,
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                           
                                            
                                            //  tableRowWidget(
                                            //   text: 'End Date',
                                            //   data:
                                            //       widget.locationModel.endDate,
                                            // ),
                                            // SizedBox(
                                            //   height: 16.h,
                                            // ),
                                            //  tableRowWidget(
                                            //   text: 'End Time',
                                            //   data:
                                            //       widget.locationModel.endTime,
                                            // ),
                                            // SizedBox(
                                            //   height: 16.h,
                                            // ),
                
                                           
                                            GetBuilder<TrainingControllerHomee>(
                                              builder: (data) {
                                                return tableRowWidget(
                                                    text: 'Current Status',
                                                    data:  data.locationCountDetails[widget.index]
                                                        .statusName);
                                              }
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                             tableRowWidget(
                                              text: 'Location',
                                              data:
                                                  widget.locationModel.locationName,
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                          ],
                                        );
                                      })),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GetBuilder<TrainingControllerHomee>(
                                      // init: trainingController,
                                      builder: (locationRescheduleData) {
                                        return 

                                        locationRescheduleData.locationCountDetails[widget.index].statusId==1||locationRescheduleData.locationCountDetails[widget.index].statusId==6||locationRescheduleData.locationCountDetails[widget.index].statusId==5?
                                        
                                        
                                        
                                        Column(
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 12.w,
                                                        horizontal: 32.w),
                                                    backgroundColor:
                                                        ColorResources.colorE5AA17),
                                                onPressed: locationRescheduleData.locationCountDetails[widget.index]
                                                                .startDate !=
                                                            'Not assigned yet' &&
                                                     locationRescheduleData.locationCountDetails[widget.index].rescheduleRequestedId!=5
                                                    ? () {
                                                        Get.to(() => Trostun_Industries(
                                                          previousPageSetState: setState,
                                                              orderItem:
                                                                  widget.orderItem,
                                                              getLocationCountModel:
                                                                  widget.locationModel,
                                                            )); 
                                                      }
                                                    : null,
                                                child: Text(
                                                  "Reschedule",
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources.colorBlack,
                                                    fontSize: 14.sp.h,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )),
                
                                              locationRescheduleData.locationCountDetails[widget.index].rescheduleRequestedId==5?  Text('Reschedule Requested',style: TextStyle(color: Colors.red,fontSize: 14.sp),):Container()
                                          ],
                                        ):Container();
                                      }),
                                ],
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
            )),
      ),
    );
  }
}
