import 'package:darlsco/controller/tainning/training_controller_home.dart';

import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:darlsco/view/widgets/common_back_button_phase2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../model/training/specific_order_details_model.dart';

class ViewAddTraineeDetailsPage extends StatefulWidget {
  final SpecificOrderDetailsModel orderItem;
  const ViewAddTraineeDetailsPage({super.key, required this.orderItem});

  @override
  State<ViewAddTraineeDetailsPage> createState() =>
      _ViewAddTraineeDetailsPageState();
}

class _ViewAddTraineeDetailsPageState extends State<ViewAddTraineeDetailsPage> {
  final TrainingControllerHomee trainingController =
      Get.put(TrainingControllerHomee());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    trainingController.  getAddedTraineeDetails(widget.orderItem.orderDetailsId.toString());
      
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formatDateString(String dateString) {
      final DateTime parsedDate = DateTime.parse(dateString);
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(parsedDate);
    }

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: commonBackgroundLinearColorCart(
              childWidget: Stack(
                children: [
                  SingleChildScrollView(
                              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
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
                        height: 32.h,
                      ),
                      cartDetailsWidget(
                        height: 130.h,
                        orderNumber: widget.orderItem.orderNo,
                        imageName: widget.orderItem.trainingCourseName,
                        categoryName: widget.orderItem.categoryName,
                        courseName: widget.orderItem.trainingCourseName,
                        amount: 'AED ${widget.orderItem.totalAmount}',
                        quantity: widget.orderItem.quantity.toString(),
                        fileName: widget.orderItem.fileName,
                        context: context,
                        isCartpage: false,
                        amtColor: ColorResources.colorE5AA17,
                        onTap: () {},
                        textColor: ColorResources.color294C73,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      richTextWidget(text: 'Trainee ', spanText: 'Details'),
                      SizedBox(
                        height: 24.h,
                      ),
                      GetBuilder<TrainingControllerHomee>(builder: (traineeData) {

                        print('trainee data  ${traineeData.viewAddTrainees}');
                        return traineeData.viewAddTrainees.isNotEmpty
                            ? ListView.separated(
                                itemCount:
                                    traineeData.viewAddTrainees.length,
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 12.h,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  String formattedDate = traineeData
                                      .viewAddTrainees[index].dateofBirth
                                      .toString();
                                       String newDate='';
                                      if (formattedDate.isNotEmpty) {
                                         DateTime parsedDate =
                                      DateTime.parse(formattedDate);
                                   newDate =
                                      DateFormat('dd/MM/yyyy').format(parsedDate);
                                        
                                      }
                                 
                                  return traineeDetailAddWidget(
                                      location: traineeData
                                          .viewAddTrainees[index].locationName,
                                      applicationId: traineeData
                                          .viewAddTrainees[index].applicationId,
                                      context: context,
                                      frstname: traineeData
                                          .viewAddTrainees[index].employeeFirstName,
                                      imgUrl: traineeData
                                          .viewAddTrainees[index].photo,
                                      lastName: traineeData
                                          .viewAddTrainees[index].employeeLastName,
                                      dob: newDate == 'null' ? '' : newDate,
                                      mobile:
                                          '${traineeData.viewAddTrainees[index].countryCodeName} ${traineeData.viewAddTrainees[index].mobileNo}',
                                      email: traineeData
                                          .viewAddTrainees[index].emailId,
                                      locationName: traineeData
                                          .viewAddTrainees[index].locationName,
                                      empId: traineeData
                                          .viewAddTrainees[index].employeeId,
                                      emiratedId: traineeData
                                          .viewAddTrainees[index].emirateId,
                                      traineecount: 'Trainee - ${index + 1}');
                                },
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: Get.height / 5,
                                  ),
                                  Center(
                                    child: Text(
                                      'Training details yet to update',
                                      style: GoogleFonts.dmSans(
                                        color: ColorResources.color294C73,
                                        fontSize: 14.sp.h,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                      }),
                      SizedBox(
                        height: 12.h,
                      ),
                    ],
                  ),
                  
                              ),
                            ),
                            commonBackButton(),
                ],
              )),
        ),

        //  GetBuilder(
        //   init: trainingHomeController,
        //   initState: (_) {
        //     trainingHomeController.getOrdersItems('1');
        //   },
        //   builder: (controller) {

        //   },
        // ),
      ),
    );
  }
}


// elevatedButtonWidget(
//                 context: context,
//                 text: widget.orderItem.statusId == 1 ? 'Saved' : 'Save',
//                 backgroundColor: ColorResources.colorE5AA17,
//                 width: Get.width,
//                 txtColor: widget.orderItem.statusId == 1
//                     ? ColorResources.color8D8D8D
//                     : ColorResources.colorBlack,
//                 onPressed: widget.orderItem.statusId == 1
//                     ? null
//                     : () async {
//                         List<String> errorMessages = [];

//                         // Function to validate fields for a specific trainee
//                         bool validateTraineeFields(int index) {
//                           bool isValid = true;

//                           if (trainingController
//                               .firstNameControllers[index].text.isEmpty) {
//                             errorMessages.add(
//                                 'Please enter first name for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (trainingController
//                               .lastNameControllers[index].text.isEmpty) {
//                             errorMessages.add(
//                                 'Please enter last name for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (trainingController
//                               .dobControllers[index].text.isEmpty) {
//                             errorMessages.add(
//                                 'Please enter date of birth for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (trainingController
//                                   .contactControllers[index].text.isEmpty ||
//                               trainingController
//                                       .contactControllers[index].text.length <
//                                   10) {
//                             errorMessages.add(
//                                 'Please enter a valid contact number for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (!isValidEmail(trainingController
//                               .emailControllers[index].text)) {
//                             errorMessages.add(
//                                 'Please enter a valid email for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (trainingController
//                                   .emiratesidControllers[index].text.isEmpty ||
//                               trainingController.emiratesidControllers[index]
//                                       .text.length <
//                                   12) {
//                             errorMessages.add(
//                                 'Please enter a valid Emirates ID for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (trainingController
//                               .employeeidControllers[index].text.isEmpty) {
//                             errorMessages.add(
//                                 'Please enter employee ID for trainee ${index + 1}');
//                             isValid = false;
//                           }

//                           return isValid;
//                         }

//                         // Check each trainee's fields
//                         bool allValid = true;
//                         for (int index = 0;
//                             index < widget.orderItem.quantity;
//                             index++) {
//                           if (!validateTraineeFields(index)) {
//                             allValid = false;
//                           }
//                         }

//                         if (allValid) {
//                           // Perform actions when all fields are valid
//                           await trainingController.addTrainee(
//                             Model(
//                               orderDetailsId: widget.orderItem.orderDetailsId,
//                               duration: widget.orderItem.duration,
//                               orderMasterId: widget.orderItem.orderMasterId,
//                               quantity: widget.orderItem.quantity,
//                               traineeDetails: List.generate(
//                                 widget.orderItem.quantity,
//                                 (index) => TraineeDetails(
//                                   locationId:
//                                       selectedLocations[index]!.locationId,
//                                   locationName:
//                                       selectedLocations[index]!.locationName,
//                                   trainingCourseId:
//                                       widget.orderItem.trainingCourseId,
//                                   trainingCourseName:
//                                       widget.orderItem.trainingCourseName,
//                                   trainingCourseCategoryId:
//                                       widget.orderItem.trainingCourseCategoryId,
//                                   categoryName: widget.orderItem.categoryName,
//                                   employeeFirstname: trainingController
//                                       .firstNameControllers[index].text,
//                                   employeeLastname: trainingController
//                                       .lastNameControllers[index].text,
//                                   employeeId: trainingController
//                                       .employeeidControllers[index].text,
//                                   dateofBirth: trainingController
//                                       .dobControllers[index].text,
//                                   emailId: trainingController
//                                       .emailControllers[index].text,
//                                   mobileNo: trainingController
//                                       .contactControllers[index].text,
//                                   emirateId: trainingController
//                                       .emiratesidControllers[index].text,
//                                 ),
//                               ),
//                             ),
//                             context,
//                           );

//                           await trainingHomeController.getOrdersItems();
//                           Get.back(); // Navigate back if needed
//                         } else {
//                           // Show snackbar for each validation error
//                           errorMessages.forEach((message) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(message),
//                               ),
//                             );
//                           });
//                         }
//                       },
//               );



// elevatedButtonWidget(
//                 context: context,
//                 text: widget.orderItem.statusId == 1 ? 'Saved' : 'Save',
//                 backgroundColor: ColorResources.colorE5AA17,
//                 width: Get.width,
//                 txtColor: widget.orderItem.statusId == 1
//                     ? ColorResources.color8D8D8D
//                     : ColorResources.colorBlack,
//                 onPressed: widget.orderItem.statusId == 1
//                     ? null
//                     : () async {
//                         List<String> errorMessages = [];

//                         // Function to validate fields for a specific trainee
//                         bool validateTraineeFields(int index) {
//                           bool isValid = true;

//                           if (trainingController
//                               .firstNameControllers[index].text.isEmpty) {
//                             errorMessages.add(
//                                 'Please enter first name for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (trainingController
//                               .lastNameControllers[index].text.isEmpty) {
//                             errorMessages.add(
//                                 'Please enter last name for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (trainingController
//                               .dobControllers[index].text.isEmpty) {
//                             errorMessages.add(
//                                 'Please enter date of birth for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (trainingController
//                                   .contactControllers[index].text.isEmpty ||
//                               trainingController
//                                       .contactControllers[index].text.length <
//                                   10) {
//                             errorMessages.add(
//                                 'Please enter a valid contact number for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (!isValidEmail(trainingController
//                               .emailControllers[index].text)) {
//                             errorMessages.add(
//                                 'Please enter a valid email for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (trainingController
//                                   .emiratesidControllers[index].text.isEmpty ||
//                               trainingController.emiratesidControllers[index]
//                                       .text.length <
//                                   12) {
//                             errorMessages.add(
//                                 'Please enter a valid Emirates ID for trainee ${index + 1}');
//                             isValid = false;
//                           }
//                           if (trainingController
//                               .employeeidControllers[index].text.isEmpty) {
//                             errorMessages.add(
//                                 'Please enter employee ID for trainee ${index + 1}');
//                             isValid = false;
//                           }

//                           return isValid;
//                         }

//                         // Check each trainee's fields
//                         bool allValid = true;
//                         for (int index = 0;
//                             index < widget.orderItem.quantity;
//                             index++) {
//                           if (!validateTraineeFields(index)) {
//                             allValid = false;
//                           }
//                         }

//                         if (allValid) {
//                           // Perform actions when all fields are valid
//                           await trainingController.addTrainee(
//                             AddTraineeModel(
//                               orderDetailsId: widget.orderItem.orderDetailsId,
//                               duration: widget.orderItem.duration,
//                               orderMasterId: widget.orderItem.orderMasterId,
//                               quantity: widget.orderItem.quantity,
//                               traineeDetails: List.generate(
//                                 widget.orderItem.quantity,
//                                 (index) => TraineeDetails(
//                                   locationId:
//                                       selectedLocations[index]!.locationId,
//                                   locationName:
//                                       selectedLocations[index]!.locationName,
//                                   trainingCourseId:
//                                       widget.orderItem.trainingCourseId,
//                                   trainingCourseName:
//                                       widget.orderItem.trainingCourseName,
//                                   trainingCourseCategoryId:
//                                       widget.orderItem.trainingCourseCategoryId,
//                                   categoryName: widget.orderItem.categoryName,
//                                   employeeFirstname: trainingController
//                                       .firstNameControllers[index].text,
//                                   employeeLastname: trainingController
//                                       .lastNameControllers[index].text,
//                                   employeeId: trainingController
//                                       .employeeidControllers[index].text,
//                                   dateofBirth: trainingController
//                                       .dobControllers[index].text,
//                                   emailId: trainingController
//                                       .emailControllers[index].text,
//                                   mobileNo: trainingController
//                                       .contactControllers[index].text,
//                                   emirateId: trainingController
//                                       .emiratesidControllers[index].text,
//                                 ),
//                               ),
//                             ),
//                             context,
//                           );

//                           await trainingHomeController.getOrdersItems();
//                           Get.back(); // Navigate back if needed
//                         } else {
//                           // Show snackbar for each validation error
//                           errorMessages.forEach((message) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(message),
//                               ),
//                             );
//                           });
//                         }
//                       },
//               );

