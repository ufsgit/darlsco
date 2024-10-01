import 'package:darlsco/controller/tainning/training_controller_home.dart';

import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/model/training/add_trainee_model.dart';
import 'package:darlsco/model/training/location_list_model.dart';
import 'package:darlsco/model/training/specific_order_details_model.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:darlsco/view/widgets/common_back_button_phase2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';

import '../../controller/login/login_controller.dart';

class TraineeDetailsPage extends StatefulWidget {
  final SpecificOrderDetailsModel orderItem;
  final previousPageSetState;
  const TraineeDetailsPage({
    super.key,
    required this.orderItem,
    required this.previousPageSetState,
  });

  @override
  State<TraineeDetailsPage> createState() => _TraineeDetailsPageState();
}

class _TraineeDetailsPageState extends State<TraineeDetailsPage> {
  final trainingHomeController = Get.put(TrainingControllerHomee());
  TextEditingController locationcustomController = TextEditingController();
  final FocusNode customLocationFocusNode = FocusNode();

  List<LocationListModel?> selectedLocations = [];
  List<Prediction?> selectedLocationLatLong = [];
  bool isLoading = false;
  String formattedDate = '';

  @override
  void initState() {
    print('quantity in trainee  ${widget.orderItem.quantity}');
    super.initState();

    selectedLocations =
        List.generate(widget.orderItem.quantity, (index) => null);

    selectedLocationLatLong =
        List.generate(widget.orderItem.quantity, (index) => null);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  init() async {
    setState(() => isLoading = true);
    trainingController.updateControllers(widget.orderItem.quantity);
    await trainingController.getLocationsList();
    await trainingController.getIndividualTrainee();
    setState(
      () => isLoading = false,
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool validateFields() {
    bool isValid = true;

    for (int index = 0; index < widget.orderItem.quantity; index++) {
      if (trainingController.firstNameControllers[index].text.isEmpty ||
          trainingController.lastNameControllers[index].text.isEmpty ||
          trainingController.dobControllers[index].text.isEmpty ||
          trainingController.contactControllers[index].text.isEmpty ||
          trainingController.contactControllers[index].text.length < 10 ||
          !isValidEmail(trainingController.emailControllers[index].text) ||
          trainingController.emiratesidControllers[index].text.isEmpty ||
          trainingController.emiratesidControllers[index].text.length < 12 ||
          trainingController.employeeidControllers[index].text.isEmpty) {
        isValid = false;
        break;
      }
    }

    return isValid;
  }
bool calledoneTime=false;
  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
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
                          // height: 130.h,
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
                        richTextWidget(
                            text: 'Enter Trainee ', spanText: 'Details'),
                        SizedBox(
                          height: 12.h,
                        ),
                        GetBuilder<TrainingControllerHomee>(builder: (data) {
                          void requestCustomLocationFocus() {
                            FocusScope.of(context)
                                .requestFocus(customLocationFocusNode);
                          }

                          return isLoading
                              ? const Center(child:CircularProgressIndicator())
                              : ListView.separated(
                                  itemCount: widget.orderItem.quantity,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 12.h,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    if (data.getIndivivdualDetails.isNotEmpty) {
                                     
                                      data.firstNameControllers[index].text =
                                          data.getIndivivdualDetails[index]
                                              .customerName;
                                      data.emailControllers[index].text = data
                                          .getIndivivdualDetails[index].email;
                                      data.emiratesidControllers[index].text =
                                          data.getIndivivdualDetails[index]
                                              .emiratesId;
                                      data.contactControllers[index].text = data
                                          .getIndivivdualDetails[index].mobile;
                                    }

                                    return traineeDetailsWidget(
                                      index: index,
                                      imageListUrl:
                                          trainingHomeController.traineeImgUrl,
                                      isDropdownEnabled:
                                          widget.orderItem.statusId == 1
                                              ? false
                                              : true,
                                      enabled: widget.orderItem.statusId == 1
                                          ? false
                                          : true,
                                      traineecount: 'Trainee ${index + 1}',
                                      context: context,
                                      selectedLocation:
                                          selectedLocations[index],
                                      selectedLocationLatLong:
                                          selectedLocationLatLong[index],
                                      firstNameController: trainingController
                                          .firstNameControllers[index],
                                      lastNameController: trainingController
                                          .lastNameControllers[index],
                                      dobController: trainingController
                                          .dobControllers[index],
                                      emailController: trainingController
                                          .emailControllers[index],
                                      contactController: trainingController
                                          .contactControllers[index],
                                      emiratedIdController: trainingController
                                          .emiratesidControllers[index],
                                      employeeIdcontroller: trainingController
                                          .employeeidControllers[index],
                                      locList: trainingController.locList,
                                      customLocationController:
                                          trainingController
                                              .customLocationControllers[index],
                                      applicationIdController: trainingController
                                              .applicationNumberIdControllers[
                                          index],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedLocations[index] = value;
                                          // requestCustomLocationFocus();
                                        });
                                      },
                                      isTraineeView: false,
                                    );
                                  },
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
            ),
          ),
        ),
        bottomNavigationBar:calledoneTime?null:
            GetBuilder<TrainingControllerHomee>(builder: (trainee) {
          return elevatedButtonWidget(
            context: context,
            text: widget.orderItem.statusId == 1 ? 'Saved' : 'Save',
            backgroundColor: ColorResources.colorE5AA17,
            width: Get.width,
            txtColor: widget.orderItem.statusId == 1
                ? ColorResources.color8D8D8D
                : ColorResources.colorBlack,
            onPressed: widget.orderItem.statusId == 1
                ? null
                : () async {
                    List<String> errorMessages = [];

                    bool validateTraineeFields(int index) {
                      bool isValid = true;
                      var controllers = trainingController;

                      void addError(String message) {
                        errorMessages.add(message);
                        isValid = false;
                      }

                      if (controllers
                          .firstNameControllers[index].text.isEmpty) {
                        addError('Enter First Name for Trainee ${index + 1}');
                      }
                      if (controllers.lastNameControllers[index].text.isEmpty) {
                        addError('Enter Last Name for Trainee ${index + 1}');
                      }

                      // if (controllers
                      //     .applicationNumberIdControllers[index].text.isEmpty) {
                      //   addError(
                      //       'Enter Application No for Trainee ${index + 1}');
                      // }

                      // if (controllers
                      //     .employeeidControllers[index].text.isEmpty) {
                      //   addError('Enter Trainee ID for Trainee ${index + 1}');
                      // }

                      if (selectedLocations[index]?.locationId != -1 &&
                          selectedLocations[index] == null) {
                        addError('Select Location for Trainee ${index + 1}');
                      }

                      if (selectedLocations[index]?.locationId == -1 &&
                          controllers
                              .customLocationControllers[index].text.isEmpty) {
                        addError(
                            'Select Location Name for Trainee ${index + 1}');
                      }

                      if (controllers
                          .emiratesidControllers[index].text.isNotEmpty) {
                        if (controllers
                                .emiratesidControllers[index].text.length !=
                            18) {
                          addError(
                              'Enter Valid Emirates ID for Trainee ${index + 1}');
                        }
                      }

                      return isValid;
                    }

                    bool allValid = true;
                    for (int index = 0;
                        index < widget.orderItem.quantity;
                        index++) {
                      if (!validateTraineeFields(index)) {
                        allValid = false;
                      }
                    }

                    if (allValid) {
                      await trainingController.addTrainee(
                        AddTraineeModel(
                          orderDetailsId: widget.orderItem.orderDetailsId,
                          duration: widget.orderItem.duration,
                          orderMasterId: widget.orderItem.orderMasterId,
                          quantity: widget.orderItem.quantity,
                          traineeDetails:
                              List.generate(widget.orderItem.quantity, (index) {
                            if (trainingController
                                .dobControllers[index].text.isNotEmpty) {
                              String inputDate =
                                  trainingController.dobControllers[index].text;
                              DateTime parsedDate =
                                  DateFormat('dd/MM/yyyy').parse(inputDate);
                              formattedDate =
                                  DateFormat('yyyy-MM-dd').format(parsedDate);
                            }

                            print(
                              trainingController.locList.isNotEmpty
                                  ? selectedLocations[index] != null
                                      ? selectedLocations[index]!.locationId
                                      : 0
                                  : 0,
                            );

                            return TraineeDetails(
                              locationId: trainingController.locList.isNotEmpty
                                  ? selectedLocations[index] != null
                                      ? selectedLocations[index]!.locationId
                                      : 0
                                  : 0,
                              locationName: trainingController
                                      .locList.isNotEmpty
                                  ? selectedLocations[index] == null
                                      ? '0'
                                      : selectedLocations[index]!.locationId ==
                                              -1
                                          ? trainingController
                                              .customLocationControllers[index]
                                              .text
                                          : selectedLocations[index]!
                                              .locationName
                                  : trainingController.locController.text,
                              latitude: selectedLocations[index] == null
                                  ? ''
                                  : selectedLocations[index]?.latitude ?? '',
                              longitude: selectedLocations[index] == null
                                  ? ''
                                  : selectedLocations[index]?.longitude ?? '',
                              trainingCourseId:
                                  widget.orderItem.trainingCourseId,
                              trainingCourseName:
                                  widget.orderItem.trainingCourseName,
                              trainingCourseCategoryId:
                                  widget.orderItem.trainingCourseCategoryId,
                              categoryName: widget.orderItem.categoryName,
                              employeeFirstname: trainingController
                                  .firstNameControllers[index].text,
                              employeeLastname: trainingController
                                  .lastNameControllers[index].text,
                              employeeId: trainingController
                                  .employeeidControllers[index].text,
                              dateofBirth: formattedDate,
                              photoUrl: trainingController
                                          .traineeImgUrl[index].isNotEmpty &&
                                      trainingController.traineeImgUrl[index] !=
                                          'empty'
                                  ? trainingController.traineeImgUrl[index]
                                      .substring(1)
                                  : '',
                              emailId: trainingController
                                  .emailControllers[index].text,
                              countryCode: loginController.countryCode.value,
                              countryCodeName:
                                  homeController.currentCountryCode.value,
                              mobileNo: trainingController
                                  .contactControllers[index].text,
                              applicationNumber: trainingController
                                  .applicationNumberIdControllers[index].text,
                              emirateId: trainingController
                                  .emiratesidControllers[index].text,
                            );
                          }),
                        ),
                        context,
                      );
                      await trainingHomeController.getSpecificOrderDetails(
                          orderMasterId:
                              widget.orderItem.orderMasterId.toString());
                      widget.previousPageSetState(() {});
                      setState(() {
                        calledoneTime=true;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(errorMessages.first),
                      ));
                    }
                  },
          );
        }),
      ),
    );
  }
}
