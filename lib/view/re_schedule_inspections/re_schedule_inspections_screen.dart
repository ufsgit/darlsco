import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controller/reschedule_inspection/reshedule_inspection_controller.dart';
import '../../core/constants/color_resources.dart';
import '../../core/constants/common_widgets.dart';

class ReScheduleInspectionsScreen extends StatefulWidget {
  const ReScheduleInspectionsScreen(
      {required this.taskId, required this.inspectionDate, super.key});

  final String taskId;
  final String inspectionDate;

  @override
  State<ReScheduleInspectionsScreen> createState() =>
      _ReScheduleInspectionsScreenState();
}

class _ReScheduleInspectionsScreenState
    extends State<ReScheduleInspectionsScreen> {
  @override
  void initState() {

     resheduleInspectionController
                                .rescheduleTimeContorller.clear();
    resheduleInspectionController.reschudleDateController.clear();
    resheduleInspectionController.resonController.clear();

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
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                )),
            backgroundColor: ColorResources.colorTransparent,
          ))),
      body: commonBackgroundLinearColorHome(
        childWidget: Container(
            padding: EdgeInsets.all(15.sp),
            width: Get.width,
            height: Get.height,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'Re-Schedule',
                        style: GoogleFonts.roboto(
                            color: ColorResources.color294C73,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: ' Inspection',
                        style: GoogleFonts.roboto(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w700,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = ColorResources.color294C73,
                        ),
                      ),
                    ])),
                    SizedBox(
                      height: 44.h,
                    ),
                    SizedBox(
                     
                      width: 800.w,
                     
                
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                
                        
                 
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.w),
                            width:Get.width>615?400.w: 346.w,
                            child: TextField(
                              style: TextStyle(fontSize: 14.sp),
                              controller: resheduleInspectionController
                                  .reschudleDateController,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    size: 18.sp,
                                    color: ColorResources.color294C73,
                                  ),
                                  border: const OutlineInputBorder(),
                                  label: const Text('Requesting Date')),
                              readOnly: true,
                              onTap: () async {
                                print(
                                  DateFormat('yyyy-MM-dd')
                                      .parse(widget.inspectionDate),
                                );
                                DateTime? pickedDate = await showDatePicker(
                                    barrierDismissible: false,
                                    context: context,
                                    initialDate: DateFormat('dd-MM-yyyy')
                                        .parse(widget.inspectionDate)
                                        .add(const Duration(days: 1)),
                                    firstDate: DateFormat('dd-MM-yyyy')
                                        .parse(widget.inspectionDate)
                                        .add(const Duration(days: 1)),
                                    lastDate: DateTime(2101));
                      
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate!);
                                resheduleInspectionController
                                        .reschudleDateController.text =
                                    DateFormat('dd-MM-yyyy').format(
                                        DateFormat('yyyy-MM-dd')
                                            .parse((formattedDate)));
                                // setState(() {
                                //   datePickController.text = formattedDate;
                                // });
                                                            },
                            ),
                          ),
                      
                          Container(
                            padding: EdgeInsets.all(10.w),
                             width:Get.width>615?400.w: 346.w,
                            child: TextField(
                              style: TextStyle(fontSize: 14.sp),
                              controller: resheduleInspectionController
                                  .rescheduleTimeContorller,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.av_timer_sharp,
                                    size: 25.sp,
                                    color: ColorResources.color294C73,
                                  ),
                                  border: const OutlineInputBorder(),
                                  label: const Text('Requesting Time')),
                              readOnly: true,
                              onTap: () async {
                                TimeOfDay initialTime = TimeOfDay.now();
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: initialTime,
                                );
                      
                                if(pickedTime!=null){
                                   resheduleInspectionController
                                  .rescheduleTimeContorller.text = pickedTime.format(context).toLowerCase();
                      
                               
                      
                      
                                }
                      
                               
                      
                      
                              },
                            ),
                          ),
                      
                          // rescheduleMainWidget(
                          //     titleText: 'Proposed Date',
                          //     icon: Icons.calendar_month,
                          //     contentText: '11/12/2023'),
                          SizedBox(
                            height: 5.h,
                          ),
                          customResonNoteWidget(context,Get.width>615?true:false),
                        Get.width<615?   Container(
                          alignment: Alignment.bottomRight,
                                  margin: EdgeInsets.only(bottom: 25.w),

                                   child: IconButton(
                                     onPressed: () {
                                       if (resheduleInspectionController
                                               .reschudleDateController.text.isEmpty || resheduleInspectionController
                                             .rescheduleTimeContorller.text.isEmpty||
                                           resheduleInspectionController
                                               .resonController.text.isEmpty) {
                                         ScaffoldMessenger.of(context).showSnackBar(
                                             const SnackBar(
                                                 duration: Duration(milliseconds: 400),
                                                 content: Text('All fields are required')));
                                         Future.delayed(
                                             const Duration(milliseconds: 600), () {});
                                       } else {
                                         resheduleInspectionController
                                             .saveCustomerReschedule(widget.taskId);
                                       }
                                     },
                                     icon: Container(
                                       
                                       width: 100.w,
                                       height: 40.h,
                                       decoration: BoxDecoration(
                                           color: ColorResources.color32C000,
                                           borderRadius: BorderRadius.circular(15.r)),
                                       child: Center(
                                           child: Text(
                                         'Submit',
                                         style: TextStyle(
                                             color: ColorResources.whiteColor,
                                             fontSize: 14.sp),
                                       )),
                                     ),
                                   ),
                                 ):Container(),
                      
                      
                                  
                        ],
                      ),
                    ),
                   
                  ]),
            )),
      ),
    );
  }

  Row customResonNoteWidget(BuildContext context,isRowButton) {
    return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // alignment: WrapAlignment.end,
                          // runAlignment: WrapAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            rescheduleMainWidget(
                                controller:
                                    resheduleInspectionController.resonController,
                                titleText: 'Reason ',
                                icon: Icons.add_comment_outlined,
                                maxLine: 5,
                                maxLength: 250,
                                contentText:
                                    'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500sLorem Ipsum has been the industry\'s standard dummy text ever since the 1500s'),

                               isRowButton?      Container(
                                  margin: EdgeInsets.only(bottom: 25.w),

                                   child: IconButton(
                                     onPressed: () {
                                       if (resheduleInspectionController
                                               .reschudleDateController.text.isEmpty || resheduleInspectionController
                                             .rescheduleTimeContorller.text.isEmpty||
                                           resheduleInspectionController
                                               .resonController.text.isEmpty) {
                                         ScaffoldMessenger.of(context).showSnackBar(
                                             const SnackBar(
                                                 duration: Duration(milliseconds: 400),
                                                 content: Text('All fields are required')));
                                         Future.delayed(
                                             const Duration(milliseconds: 600), () {});
                                       } else {
                                         resheduleInspectionController
                                             .saveCustomerReschedule(widget.taskId);
                                       }
                                     },
                                     icon: Container(
                                       
                                       width: 100.w,
                                       height: 40.h,
                                       decoration: BoxDecoration(
                                           color: ColorResources.color32C000,
                                           borderRadius: BorderRadius.circular(15.r)),
                                       child: Center(
                                           child: Text(
                                         'Submit',
                                         style: TextStyle(
                                             color: ColorResources.whiteColor,
                                             fontSize: 14.sp),
                                       )),
                                     ),
                                   ),
                                 ):Container(),
                          ],
                        );
  }

  Container rescheduleMainWidget(
      {required String titleText,
      required IconData icon,
      required String contentText,
      int? maxLength,
      required controller,
      int maxLine = 1}) {
    return Container(
        width: Get.width>615?400.w:346.w,
        padding: EdgeInsets.all(10.sp),
        // decoration: BoxDecoration(
        //     border: Border.all(color: ColorResources.color294C73),
        //     borderRadius: BorderRadius.circular(5.r)),
        child: TextFormField(
          controller: controller,
          maxLines: maxLine,
          maxLength: maxLength,
          decoration: InputDecoration(
              label: Text(
                titleText,
                
                textAlign: TextAlign.left,
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorResources.color294C73),
                borderRadius: BorderRadius.circular(8.r),
              ),
             ),
        )
        // Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //    Icon(
        //    icon,
        //     color: ColorResources.color294C73,
        //   ),
        //   SizedBox(
        //     width: 6.w,
        //   ),
        //   Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //       titleText,
        //         style: TextStyle(
        //           fontFamily: "Roboto",
        //           fontSize: 12.sp,
        //           fontWeight: FontWeight.w500,
        //           color: const Color(0xff878787),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 14.h,
        //       ),
        //       SizedBox(
        //         width: 264.w,
        //         child: Text(
        //          contentText,
        //           style: TextStyle(
        //             fontFamily: "Roboto",
        //             fontSize: 14.sp,
        //             fontWeight: FontWeight.w400,
        //             color: const Color(0xff000000),
        //           ),
        //         ),
        //       )
        //     ],
        //   )
        // ]),
        );
  }
}
