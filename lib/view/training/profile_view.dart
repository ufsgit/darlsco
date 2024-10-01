import 'dart:core';
import 'dart:io';

import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/http/aws_upload.dart';
import 'package:darlsco/model/home/profile_model.dart';
import 'package:darlsco/view/training/certificate_page.dart';
import 'package:darlsco/view/training/widgets/show_dialog_widget.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/common_back_button_phase2.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({super.key});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  DateTime? selectedDateExpire;
  DateTime? selectedDateTradingLicenceExpire;
  final trainingController = Get.put(TrainingControllerHomee());

  File? image;
  final _picker = ImagePicker();

  String _selectedProfileType = 'Corporate';
  bool isEditMode = false;
  final profileEditController = Get.put(TrainingControllerHomee());
  //from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        Get.back();
      });
    }
  }

  //from camera
  Future<void> pickImageFromCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        Get.back();
      });
    }
  }

  final TextEditingController numberController = TextEditingController();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController contactPersonController = TextEditingController();
  // final TextEditingController tradeLicenceController = TextEditingController();
  // final TextEditingController emiratesIdController = TextEditingController();
 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _initializePhoneNumber();
      },
    );
  }

  Future<void> _initializePhoneNumber() async {
    await trainingController.getProfile();
    if (trainingController.profileDetails.isNotEmpty) {
      profileEditController.customerNameController.text =
          trainingController.profileDetails[0].customerName;
      numberController.text = trainingController.profileDetails[0].mobile;
      profileEditController.emailIDController.text =
          trainingController.profileDetails[0].email;
      profileEditController.contactPersonController.text =
          trainingController.profileDetails[0].contactName;
      profileEditController.tradeLicenceNoController.text =
          trainingController.profileDetails[0].tradeLicenceNo;
      profileEditController.emiratesIDController.text =
          trainingController.profileDetails[0].emiratesId;
      profileEditController.emiratesIdExpiryDateController.text =
          trainingController.profileDetails[0].emiratesDate.isEmpty
              ? ''
              : DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd')
                  .parse((trainingController.profileDetails[0].emiratesDate)));

      profileEditController
          .tradeLicenceExpiryDateController.text = trainingController
              .profileDetails[0].tradeLicenceExpiryDate.isEmpty
          ? ''
          : DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd').parse(
              (trainingController.profileDetails[0].tradeLicenceExpiryDate)));

      _selectedProfileType =
          trainingController.profileDetails[0].individual == 1
              ? 'Individual'
              : 'Corporate';
    }
  }

  String removeTime(String dateTimeString) {
    String datePart = dateTimeString.split(' ')[0];
    return datePart;
  }

  final screenWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: Get.width,
              child:
                  GetBuilder<TrainingControllerHomee>(builder: (profileData) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Container(),
                  itemCount: profileData.profileDetails.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // String formatDate(String dateTimeString) {
                    //   try {
                    //     DateTime dateTime = DateTime.parse(dateTimeString);
                    //     return DateFormat('yyyy-MM-dd').format(dateTime);
                    //   } catch (e) {
                    //     print('Error parsing date: $e');
                    //     return 'Invalid date';
                    //   }
                    // }

                    return Container(
                      // height: Get.height,
                      // width: Get.width,
                      color: ColorResources.whiteColor,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              fit: StackFit.loose,
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 180.h,
                                  width: Get.width,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 130.h,
                                        width: Get.width,
                                        color: const Color(0xFF0950A0)
                                            .withOpacity(0.49),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 24.h, horizontal: 16.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Profile',
                                                style: GoogleFonts.dmSans(
                                                  color: ColorResources
                                                      .color294C73,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                // Positioned(
                                //   left: 10,
                                //   top: 10,
                                //   child: InkWell(
                                //                           onTap: () {
                                //                             Get.back();
                                //                           },
                                //                           child: CircleAvatar(
                                //                             radius: 18.h,
                                //                             backgroundColor: ColorResources.colorDBE8FC,
                                //                             child: Padding(
                                //   padding: const EdgeInsets.only(left: 8),
                                //   child: Icon(
                                //     Icons.arrow_back_ios,
                                //     size: 30.h,
                                //     color: ColorResources.color294C73,
                                //   ),
                                //                             ),
                                //                           ),
                                //                         ),
                                // ),

                                _selectedProfileType != '' &&
                                        _selectedProfileType == 'Individual'
                                    ? Positioned(
                                        top: 60,
                                        left: screenWidth > 600
                                            ? Get.width / 2.25
                                            : Get.width / 2.60,
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                  height: 100.r,
                                                  width: 100.r,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.grey),
                                                  child: image != null
                                                      ? Image.file(image!,
                                                          fit: BoxFit.cover)
                                                      : 'https://darlsco-files.s3.ap-south-1.amazonaws.com${profileData.profileDetails[0].filePath}' !=
                                                              ''
                                                          ? Image.network(
                                                              'https://darlsco-files.s3.ap-south-1.amazonaws.com${profileData.profileDetails[0].filePath}',
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Container(),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              bottom: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return ShowDialogWidget(
                                                        fromCamera: () {
                                                          pickImageFromCamera();
                                                        },
                                                        fromGallery: () {
                                                          pickImageFromGallery();
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const CircleAvatar(
                                                  backgroundColor:
                                                      ColorResources
                                                          .color294C73,
                                                  child: Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: ColorResources
                                                        .whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Profile Type',
                                        style: GoogleFonts.dmSans(
                                          color: ColorResources.color294C73,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isEditMode = !isEditMode;
                                            });
                                          },
                                          child: Text(
                                            isEditMode ? 'Cancel' : 'Edit',
                                            style: GoogleFonts.dmSans(
                                              color: Colors.blue,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: RadioListTile<String>(
                                        title: const Text('Corporate'),
                                        value: 'Corporate',
                                        activeColor: ColorResources.color294C73,
                                        groupValue: _selectedProfileType,
                                        onChanged: isEditMode
                                            ? (value) {
                                                setState(() {
                                                  _selectedProfileType = value!;
                                                });
                                              }
                                            : null,
                                      ),
                                    ),
                                    Flexible(
                                      child: RadioListTile<String>(
                                        title: const Text('Individual'),
                                        value: 'Individual',
                                        activeColor: ColorResources.color294C73,
                                        groupValue: _selectedProfileType,
                                        onChanged: isEditMode
                                            ? (value) {
                                                setState(() {
                                                  _selectedProfileType = value!;
                                                });
                                              }
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.h),
                                  child: profileTextFieldWidget(
                                    enabled: isEditMode,
                                    hintText: 'Enter Customer name',
                                    title: 'Customer name',
                                    controller: profileEditController
                                        .customerNameController,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.h),
                                  child: rowTextfieldWidget(
                                      mobileController: numberController,
                                      enabled: isEditMode,
                                      initialSelection: profileData
                                          .profileDetails[index]
                                          .countryCodeName),
                                ),
                                SizedBox(height: 8.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.h),
                                  child: profileTextFieldWidget(
                                    enabled: isEditMode,
                                    hintText: 'Enter Email ID',
                                    title: 'Email ID',
                                    controller:
                                        profileEditController.emailIDController,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                _selectedProfileType == 'Corporate'
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.h),
                                            child: profileTextFieldWidget(
                                              enabled: isEditMode,
                                              hintText: 'Enter Contact Person',
                                              title: 'Contact Person',
                                              controller: profileEditController
                                                  .contactPersonController,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.h),
                                            child: profileTextFieldWidget(
                                              enabled: isEditMode,
                                              hintText:
                                                  'Enter Trade Licence No',
                                              title: 'Trade Licence No',
                                              controller: profileEditController
                                                  .tradeLicenceNoController,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.h),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Trade License Expiry Date',
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources
                                                        .color294C73,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16.w),
                                            width: Get.width,
                                            child: TextField(
                                              style: TextStyle(fontSize: 14.sp),
                                              controller: trainingHomeController
                                                  .tradeLicenceExpiryDateController,
                                              enabled: isEditMode,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: ColorResources
                                                          .colorBlack,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFCECECE),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 8.h,
                                                          horizontal: 8.w),
                                                  suffixIcon: Icon(
                                                    Icons.calendar_today,
                                                    size: 18.sp,
                                                    color: isEditMode
                                                        ? ColorResources
                                                            .color294C73
                                                        : const Color(
                                                            0xFFCECECE),
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  hintText:
                                                      'Trade Licence Expiry Date'),
                                              readOnly: true,
                                              onTap: isEditMode == false
                                                  ? null
                                                  : () async {
                                                      DateTime? pickedDate =
                                                          await showDatePicker(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate:
                                                                  DateTime
                                                                      .now(),
                                                              lastDate:
                                                                  DateTime(
                                                                      2101));

                                                      if (pickedDate != null) {
                                                        String formattedDate =
                                                            DateFormat(
                                                                    'dd-MM-yyyy')
                                                                .format(
                                                                    pickedDate);
                                                        trainingHomeController
                                                            .tradeLicenceExpiryDateController
                                                            .text = DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .parse(
                                                                    (formattedDate)));
                                                        setState(() {
                                                          trainingHomeController
                                                              .tradeLicenceExpiryDateController
                                                              .text = formattedDate;
                                                        });
                                                      } else {}
                                                    },
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.h),
                                            child: profileTextFieldWidget(
                                              enabled: isEditMode,
                                              hintText: 'Enter Emirates ID',
                                              title: 'Emirates ID',
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: profileEditController
                                                  .emiratesIDController,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.h),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Emirates ID Expiry Date',
                                                  style: GoogleFonts.dmSans(
                                                    color: ColorResources
                                                        .color294C73,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 16.h),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16.w),
                                            width: Get.width,
                                            child: TextField(
                                              style: TextStyle(fontSize: 14.sp),
                                              enabled: isEditMode,
                                              controller: trainingHomeController
                                                  .emiratesIdExpiryDateController,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: ColorResources
                                                          .colorBlack,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFCECECE),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 8.h,
                                                          horizontal: 8.w),
                                                  suffixIcon: Icon(
                                                    Icons.calendar_today,
                                                    size: 18.sp,
                                                    color: ColorResources
                                                        .color294C73,
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  hintText:
                                                      'Emirates ID Expiry Date'),
                                              readOnly: true,
                                              onTap: isEditMode == false
                                                  ? null
                                                  : () async {
                                                      DateTime? pickedDate =
                                                          await showDatePicker(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate:
                                                                  DateTime
                                                                      .now(),
                                                              lastDate:
                                                                  DateTime(
                                                                      2101));

                                                      if (pickedDate != null) {
                                                        String formattedDate =
                                                            DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    pickedDate);
                                                        trainingHomeController
                                                            .emiratesIdExpiryDateController
                                                            .text = DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .parse(
                                                                    (formattedDate)));
                                                        setState(() {
                                                          trainingHomeController
                                                              .tradeLicenceExpiryDateController
                                                              .text = formattedDate;
                                                        });
                                                      } else {}
                                                    },
                                            ),
                                          ),
                                          SizedBox(height: 16.h),
                                        ],
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            commonBackButton()
          ],
        ),
        bottomNavigationBar: elevatedButtonWidget(
          context: context,
          text: 'Save',
          width: Get.width,
          backgroundColor: ColorResources.colorE5AA17,
          txtColor: ColorResources.colorBlack,
          onPressed: () async {
            print(
                'expiry date ${trainingController.tradeLicenceExpiryDateController.text}');
            print(isEditMode);
            if (!isEditMode) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Click the Edit button to enable editing')));
              return;
            }
            // Check if any field is missing
            if (profileEditController.customerNameController.text.isEmpty ||
                profileEditController.emailIDController.text.isEmpty ||
                (_selectedProfileType == 'Individual' &&
                    (profileEditController
                        .emiratesIDController.text.isEmpty)) ||
                (_selectedProfileType == 'Corporate' &&
                    (profileEditController
                            .contactPersonController.text.isEmpty ||
                        profileEditController
                            .tradeLicenceNoController.text.isEmpty))) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All fields are required!')));
            } else {
              dynamic filePath;

              if (image != null) {
                filePath = await AwsUpload.uploadToAws(image!);
              }

              // print(Uri.parse(filePath!).path);

              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              int userId =
                  int.parse(sharedPreferences.getString('darlsco_id') ?? '0');

              ProfileEditModel profileEdit = ProfileEditModel(
                filePath: image != null
                    ? Uri.parse(filePath!).path
                    : 'https://darlsco-files.s3.ap-south-1.amazonaws.com${trainingController.profileDetails[0].filePath}',
                tradeLicenceNo: _selectedProfileType == 'Corporate'
                    ? profileEditController.tradeLicenceNoController.text
                    : '',
                tradeLicenceExpiryDate: _selectedProfileType == 'Corporate'
                    ? DateTime.parse(DateFormat('yyyy-MM-dd').format(
                        DateFormat('dd-MM-yyyy').parse((trainingController
                            .tradeLicenceExpiryDateController.text))))
                    : null,
                corporate: _selectedProfileType == 'Corporate' ? '1' : '0',
                individual: _selectedProfileType == 'Individual' ? '1' : '0',
                customerId: userId,
                customerName: profileEditController.customerNameController.text,
                mobile: numberController.text,
                email: profileEditController.emailIDController.text,
                contactName: _selectedProfileType == 'Corporate'
                    ? profileEditController.contactPersonController.text
                    : '',
                emiratesId: _selectedProfileType == 'Individual'
                    ? profileEditController.emiratesIDController.text
                    : '',
                emiratesDate: _selectedProfileType == 'Individual'
                    ? DateTime.parse(DateFormat('yyyy-MM-dd').format(
                        DateFormat('dd-MM-yyyy').parse((trainingController
                            .emiratesIdExpiryDateController.text))))
                    : null,
                countryCodeName: loginController.countryCode.value,
                countryCodeId: 'IN',
              );

              await trainingController.addProfileEdit(profileEdit, false, false,
                  isEdit: true);
            }
          },
        ),
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  final bool enabled;
  final String initialText;
  final void Function(DateTime pickedDate)
      onDateSelected; // Callback to parent widget

  const DatePicker(
      {super.key,
      this.enabled = true,
      this.initialText = '',
      required this.onDateSelected});

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime _selectedDate = DateTime.now();
  String _displayText = '';

  @override
  void initState() {
    super.initState();
    _displayText = widget.initialText;

    try {
      _selectedDate = DateFormat('yyyy-MM-dd').parse(widget.initialText);
      int year = _selectedDate.year;
      print('Year: $year');
    } catch (e) {
      print('Error parsing date: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    if (!widget.enabled) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _displayText = DateFormat('yyyy-MM-dd').format(_selectedDate);
        widget.onDateSelected(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _displayText.isEmpty ? 'No date chosen' : _displayText,
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
