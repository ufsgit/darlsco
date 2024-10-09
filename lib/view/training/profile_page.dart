import 'dart:core';
import 'dart:io';

import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/http/aws_upload.dart';
import 'package:darlsco/model/home/profile_model.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/training/widgets/bottom_navigation_widget.dart';
import 'package:darlsco/view/training/widgets/show_dialog_widget.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(
      {super.key,
      required this.isFromHomePage,
      required this.isFromPurchase,
      required this.isEdit});
  final bool isFromHomePage;
  final bool isFromPurchase;
  final bool isEdit;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime? selectedDateExpire;
  DateTime? selectedDateTradingLicenceExpire;
  // final TrainingControllerHomee profileEditController =
  //     Get.put(TrainingControllerHomee());
  // final TextEditingController customerNameController = TextEditingController();
  // final TextEditingController emailIDController = TextEditingController();
  // final TextEditingController phoneNumberController = TextEditingController();
  // final TextEditingController contactPersonController = TextEditingController();
  // final TextEditingController companyNameController = TextEditingController();
  // final TextEditingController emiratesIDController = TextEditingController();
  File? image;
  final _picker = ImagePicker();

  String _selectedProfileType = 'Corporate';
  // AwsUpload awsUpload=AwsUpload();

  //for form validation
  final formKey = GlobalKey<FormState>();
  // AwsUpload awsUpload=AwsUpload();

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
  @override
  void initState() {
    super.initState();
    print('getItemCart5');
    trainingController.clearProfile();
    trainingController.getItemCart();

    _initializePhoneNumber();

    selectedDateExpire = DateTime.now();
  }

  Future<void> _initializePhoneNumber() async {
    String phoneNo = await getPhoneNo();

    numberController.text = phoneNo;
  }

  Future<String> getPhoneNo() async {
    final prefs = await SharedPreferences.getInstance();
    final String phoneNo = prefs.getString('phone_no') ?? "9090909090";
    print("number//////////////////////$phoneNo");
    print(
        'cart in profile page<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>${trainingController.cartPriceList.length}');
    return phoneNo;
  }

  String? errorTextCustomer;
  String? errorTextEmail;
  String? errorTextContactP;
  String? errorTextLicense;
  String? errorTextEmirates;

  @override
  Widget build(BuildContext context) {
    print('bulding<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>');
    final screenWidth = Get.width;
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
            body: Container(
              height: Get.height,
              width: Get.width,
              color: ColorResources.whiteColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: _selectedProfileType != '' &&
                                  _selectedProfileType == 'Individual'
                              ? 180.h
                              : 135.h,
                          width: Get.width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                height: _selectedProfileType != '' &&
                                        _selectedProfileType == 'Individual'
                                    ? 130
                                    : 100,
                                width: Get.width,
                                color:
                                    const Color(0xFF0950A0).withOpacity(0.49),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 24.h.w, horizontal: 17.h.w),
                                  child: Row(
                                    crossAxisAlignment: _selectedProfileType !=
                                                '' &&
                                            _selectedProfileType == 'Individual'
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Profile',
                                        style: GoogleFonts.dmSans(
                                          color: ColorResources.color294C73,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w800,
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
                                          decoration: const BoxDecoration(
                                              color: Colors.grey),
                                          child: image != null
                                              ? Image.file(image!,
                                                  fit: BoxFit.cover)
                                              : const Icon(
                                                  Icons.person_2,
                                                  size: 80,
                                                  color: Colors.white,
                                                ),
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
                                              ColorResources.color294C73,
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: ColorResources.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            child: Row(
                              children: [
                                Text(
                                  'Profile Type',
                                  style: GoogleFonts.dmSans(
                                    color: ColorResources.color294C73,
                                    fontSize: 14.sp.h,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
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
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedProfileType = value!;
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: RadioListTile<String>(
                                  title: const Text('Individual'),
                                  value: 'Individual',
                                  activeColor: ColorResources.color294C73,
                                  groupValue: _selectedProfileType,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedProfileType = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 16.h),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [

                          //     ],
                          //   ),
                          // ),

                          SizedBox(
                            height: 8.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            child: profileTextFieldWidget(
                              maxLength: 50,
                              hintText: 'Enter Customer Name',
                              title: 'Customer Name',
                              // validator: (name) {
                              //   if (name!.isNotEmpty) {
                              //     return null;
                              //   } else {
                              //     errorTextCustomer =
                              //         'Customer name is required!';
                              //     return errorTextCustomer;
                              //   }
                              // },
                              // onChanged: (value) {
                              //   if (value.isEmpty) {
                              //     errorTextCustomer =
                              //         'Customer name is required!';
                              //   } else {
                              //     errorTextCustomer = null;
                              //   }
                              //   setState(() {
                              //     print('object');
                              //   });
                              // },
                              // errorText: errorTextCustomer,
                              controller:
                                  trainingController.customerNameController,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            child: rowTextfieldWidget(
                                mobileController: numberController,
                                enabled: false,
                                initialSelection: globalHomeController
                                    .currentCountryCode.value),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 16.h),
                          //   child: profileTextFieldWidget(
                          //     hintText: 'Enter Customer name',
                          //     title: 'Customer name',
                          //     controller:
                          //         trainingController.customerNameController,
                          //   ),
                          // ),

                          // SizedBox(
                          //   height: 8.h,
                          // ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            child: profileTextFieldWidget(
                              maxLength: 50,
                              hintText: 'Enter Email ID',
                              title: 'Email ID',
                              controller: trainingController.emailIDController,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          _selectedProfileType == 'Corporate'
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.h),
                                      child: profileTextFieldWidget(
                                        maxLength: 50,
                                        hintText: 'Enter Contact Person',
                                        title: 'Contact Person',
                                        controller: trainingController
                                            .contactPersonController,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.h),
                                      child: profileTextFieldWidget(
                                        maxLength: 12,
                                        hintText: 'Enter Trade Licence No',
                                        title: 'Trade Licence No',
                                        controller: trainingController
                                            .tradeLicenceNoController,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.h),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Trade License Expiry Date',
                                            style: GoogleFonts.dmSans(
                                              color: ColorResources.color294C73,
                                              fontSize: 14.sp.h,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      width: Get.width,
                                      child: TextField(
                                        style: TextStyle(fontSize: 14.sp),
                                        controller: trainingController
                                            .tradeLicenceExpiryDateController,
                                        decoration: InputDecoration(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    ColorResources.colorBlack,
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
                                              color: ColorResources.color294C73,
                                            ),
                                            border: const OutlineInputBorder(),
                                            hintText:
                                                'Trade Licence Expiry Date'),
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2101));

                                          String formattedDate =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(pickedDate!);
                                          trainingController
                                              .tradeLicenceExpiryDateController
                                              .text = DateFormat(
                                                  'dd-MM-yyyy')
                                              .format(DateFormat('yyyy-MM-dd')
                                                  .parse((formattedDate)));
                                          print(pickedDate);

                                          trainingController
                                              .tradeLicenceExpiryDateController
                                              .text = formattedDate;
                                                                                },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.h),
                                      child: profileTextFieldWidget(
                                        hintText: 'Enter Emirates ID',
                                        title: 'Emirates ID',
                                        maxLength: 18,
                                        keyboardType: TextInputType.number,
                                        controller: trainingController
                                            .emiratesIDController,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.h),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Emirates ID Expiry Date',
                                            style: GoogleFonts.dmSans(
                                              color: ColorResources.color294C73,
                                              fontSize: 14.sp.h,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      width: Get.width,
                                      child: TextField(
                                        style: TextStyle(fontSize: 14.sp),
                                        controller: trainingController
                                            .emiratesIdExpiryDateController,
                                        decoration: InputDecoration(
                                          hintText: 'Emirates ID Expiry Date',
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorResources.colorBlack,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFCECECE),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8.h, horizontal: 8.w),
                                          suffixIcon: Icon(
                                            Icons.calendar_today,
                                            size: 18.sp,
                                            color: ColorResources.color294C73,
                                          ),
                                          border: const OutlineInputBorder(),
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2101));

                                          String formattedDate =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(pickedDate!);
                                          trainingController
                                              .emiratesIdExpiryDateController
                                              .text = DateFormat(
                                                  'dd-MM-yyyy')
                                              .format(DateFormat('yyyy-MM-dd')
                                                  .parse((formattedDate)));

                                          trainingController
                                              .emiratesIdExpiryDateController
                                              .text = formattedDate;
                                                                                },
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: elevatedButtonWidget(
              context: context,
              text: 'Save',
              width: Get.width,
              backgroundColor: ColorResources.colorE5AA17,
              txtColor: ColorResources.colorBlack,
              onPressed:trainingController.editProfileLoading.value?(){}: () async {
               trainingController.editProfileLoading.value=true;
                print(
                    '/////////////////cartDATA in save>>>>>>>>>>>>>>${trainingController.cartPriceList.length}');
                var img = '';
                // Check if any field is missing
                //final isValid = formKey.currentState!.validate();
                if (image != null) {
                  print('image aws${await AwsUpload.uploadToAws(image!)}');
                  var img = await AwsUpload.uploadToAws(image!);

                  print(Uri.parse(img!).path);
                }

                print(
                    'empty check ${trainingController.tradeLicenceExpiryDateController.text}');

                if (trainingController.customerNameController.text.isEmpty ||
                    trainingController.emailIDController.text.isEmpty ||
                    !EmailValidator.validate(
                        trainingController.emailIDController.text) ||
                    image == null && _selectedProfileType == 'Individual' ||
                    trainingController
                            .emiratesIdExpiryDateController.text.isEmpty &&
                        _selectedProfileType == 'Individual' ||
                    trainingController.tradeLicenceNoController.text.length <
                            6 &&
                        _selectedProfileType == 'Corporate' ||
                    trainingController
                            .tradeLicenceExpiryDateController.text.isEmpty &&
                        _selectedProfileType == 'Corporate' ||
                    (_selectedProfileType == 'Individual' &&
                        (trainingController.emiratesIDController.text.isEmpty ||
                            trainingController
                                    .emiratesIDController.text.length !=
                                18)) ||
                    (_selectedProfileType == 'Corporate' &&
                        (trainingController
                                .contactPersonController.text.isEmpty ||
                            trainingController
                                .tradeLicenceNoController.text.isEmpty))) {
                  if (image == null && _selectedProfileType == 'Individual') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Profile Image is Required!')));
                  } else if (trainingController
                      .customerNameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Customer Name is Required!')));
                  } else if (trainingController
                      .emailIDController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email ID is Required!')));
                  } else if (!EmailValidator.validate(
                      trainingController.emailIDController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Valid Email ID is Required!')));
                  } else if (trainingController
                          .emiratesIDController.text.isEmpty &&
                      _selectedProfileType == 'Individual') {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Emirates ID required!')));
                  } else if (trainingController
                              .emiratesIDController.text.length <
                          15 &&
                      _selectedProfileType == 'Individual') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Valid Emirates ID is Required!')));
                  } else if (trainingController
                          .contactPersonController.text.isEmpty &&
                      _selectedProfileType == 'Corporate') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Contact Person is Required!')));
                  } else if (trainingController
                          .tradeLicenceNoController.text.isEmpty &&
                      _selectedProfileType == 'Corporate') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Trade Licence No is Required!')));
                  } else if (trainingController
                              .tradeLicenceNoController.text.length <
                          6 &&
                      _selectedProfileType == 'Corporate') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Valid Trade Licence No is Required!')));
                  } else if (trainingController
                          .tradeLicenceExpiryDateController.text.isEmpty &&
                      _selectedProfileType == 'Corporate') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Trade Licence Expiry Date is Required!')));
                  } else if (trainingController
                          .emiratesIdExpiryDateController.text.isEmpty &&
                      _selectedProfileType == 'Individual') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Emirates ID Expiry Date is Required!')));
                  } else {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();

                    int userId = int.parse(
                        sharedPreferences.getString('darlsco_id') ?? '0');
                    print('customer id $userId   sssss ${widget.isEdit}');
                    String phoneNumber =
                        sharedPreferences.getString('phone_no') ?? '';
                    String email =
                        sharedPreferences.getString('email_user_') ?? '';
                    String name =
                        sharedPreferences.getString('name_user_') ?? '';
                    ProfileEditModel profileEdit = ProfileEditModel(
                      tradeLicenceNo: _selectedProfileType == 'Corporate'
                          ? trainingController.tradeLicenceNoController.text
                          : '',
                      tradeLicenceExpiryDate:
                          _selectedProfileType == 'Corporate'
                              ? selectedDateTradingLicenceExpire
                              : null,
                      corporate:
                          _selectedProfileType == 'Corporate' ? '1' : '0',
                      individual:
                          _selectedProfileType == 'Individual' ? '1' : '0',
                      customerId:
                          userId, // You need to provide the customer ID if available
                      customerName:
                          trainingController.customerNameController.text,
                      mobile: numberController.text,
                      email: trainingController.emailIDController.text,
                      contactName: _selectedProfileType == 'Corporate'
                          ? trainingController.contactPersonController.text
                          : '',
                      emiratesId: _selectedProfileType == 'Individual'
                          ? trainingController.emiratesIDController.text
                          : '',
                      emiratesDate: _selectedProfileType == 'Individual'
                          ? selectedDateExpire
                          : null,

                      countryCodeName: loginController.countryCode.value,
                      countryCodeId: homeController.currentCountryCode.value,

                      filePath: image == null ? '' : img,
                    );

                    // Call the addProfileEdit method and pass the ProfileEditModel object
                    // await trainingController.addProfileEdit(profileEdit,
                    //     widget.isFromPurchase, widget.isFromHomePage);

                    // Show a snackbar indicating success
                    // await Get.snackbar(
                    //   'Success',
                    //   'Profile Added Successfully',
                    //   backgroundColor: ColorResources.color294C73,
                    //   colorText: ColorResources.whiteColor,
                    //   snackPosition: SnackPosition.BOTTOM,
                    // );
                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //     content: Text('Profile Successfully Added')));

                    if (widget.isFromPurchase == false &&
                        widget.isFromHomePage == true) {
                      Get.to(() => BottomNavigationWidget());
                    } else if (widget.isFromPurchase == true) {
                      await homeController.purchaseGateWay(
                          phoneNumber: phoneNumber,
                          email: email,
                          name: name,
                          Get.context,
                          tcontoller.totalPrice.toStringAsFixed(2));
                      // navigate to telr page continue payment
                    } else {
                      Get.to(() => BottomNavigationWidget());
                    }
                  }
                }
                //  else if (_selectedProfileType == 'Corporate') {
                //   if (trainingController.customerNameController.text.isEmpty) {
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //         content: Text('Customer name is required!')));
                //   } else if (trainingController
                //       .emailIDController.text.isEmpty) {
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //         content: Text('Please enter a valid Email!')));
                //   } else if (trainingController
                //       .contactPersonController.text.isEmpty) {
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //         content: Text('Contact Person required !')));
                //   } else if (trainingController
                //       .tradeLicenceNoController.text.isEmpty) {
                //     errorTextLicense = 'Trade Licence No is required!';
                //   }

                //   setState(() {});
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text('All fields are required!')));
                // }
                // if (isValid == false) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text('All fields are required!')));
                // }
                else {
                  //dialog box begin
                  showDialog(
                    context: Get.context!,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          'Are you sure you want to save the details?',
                          style: GoogleFonts.dmSans(
                            fontSize: 16.sp.h,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        actions: [
                          textButtonWidget(
                            text: 'No',
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          textButtonWidget(
                            text: 'Yes',
                            onPressed: () async {
                              print(
                                  'Cartdata//////// ${trainingController.cartPriceList.length}');
                              print(
                                  'hai ${trainingController.tradeLicenceExpiryDateController.text}');
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();

                              int userId = int.parse(
                                  sharedPreferences.getString('darlsco_id') ??
                                      '0');

                              ProfileEditModel profileEdit = ProfileEditModel(
                                tradeLicenceNo:
                                    _selectedProfileType == 'Corporate'
                                        ? trainingController
                                            .tradeLicenceNoController.text
                                        : '',
                                tradeLicenceExpiryDate: _selectedProfileType ==
                                        'Corporate'
                                    ? DateTime.parse(DateFormat('yyyy-MM-dd')
                                        .format(DateFormat('dd-MM-yyyy').parse(
                                            (trainingController
                                                .tradeLicenceExpiryDateController
                                                .text))))
                                    : null,

                                corporate: _selectedProfileType == 'Corporate'
                                    ? '1'
                                    : '0',
                                individual: _selectedProfileType == 'Individual'
                                    ? '1'
                                    : '0',
                                customerId:
                                    userId, // You need to provide the customer ID if available
                                customerName: trainingController
                                    .customerNameController.text,
                                mobile: numberController.text,
                                email:
                                    trainingController.emailIDController.text,
                                contactName: _selectedProfileType == 'Corporate'
                                    ? trainingController
                                        .contactPersonController.text
                                    : '',
                                emiratesId: _selectedProfileType == 'Individual'
                                    ? trainingController
                                        .emiratesIDController.text
                                    : '',
                                emiratesDate: _selectedProfileType ==
                                        'Individual'
                                    ? DateTime.parse(DateFormat('yyyy-MM-dd')
                                        .format(DateFormat('dd-MM-yyyy').parse(
                                            (trainingController
                                                .emiratesIdExpiryDateController
                                                .text))))
                                    : null,
                                countryCodeName:
                                    loginController.countryCode.value,
                                countryCodeId: 'IN',
                                filePath: Uri.parse(img).path,
                              );

                              Get.back();
                              print(
                                  'Cartdata in profile before//////// ${trainingController.cartPriceList.length}');
                              // Call the addProfileEdit method and pass the ProfileEditModel object
                              await trainingController.addProfileEdit(
                                  profileEdit,
                                  widget.isFromPurchase,
                                  widget.isFromHomePage);
                              print(
                                  'Cartdata in profile//////// ${trainingController.cartPriceList.length}');
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                trainingController.editProfileLoading.value=false;
              },
            )),
      ),
    );
  }
}
