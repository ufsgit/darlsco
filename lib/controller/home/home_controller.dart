import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:darlsco/controller/contact_us_controller/contact_us_controller.dart';

import 'package:darlsco/controller/upcoming_inspections/upcoming_inspection_controller.dart';
import 'package:darlsco/main.dart';
import 'package:darlsco/model/home/customer_equipment_list.dart';
import 'package:darlsco/model/used_equipment/equipment_detail_model.dart';
import 'package:darlsco/view/equipment_list/equipment_list_screen_mob.dart';

import 'package:darlsco/view/login/company_location_screen.dart';
import 'package:darlsco/view/telr/telr_dummy_page.dart';
import 'package:darlsco/view/training/training_inspection_screen.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

import '../../http/http_request.dart';
import '../../http/http_urls.dart';
import '../../model/home/location_model.dart';

import '../../view/dashboard/expiring_equipment.dart';
import '../../view/home/bottom_navigation_screen.dart';
import '../../view/home/home_equipment_list_screen.dart';
import '../../view/training/billing_page.dart';
import '../../view/training/user_list_screen.dart';
import '../tainning/training_controller_home.dart';
import '../tainning/trainnig_controller.dart';

final HomeController globalHomeController = Get.put(HomeController());

class HomeController extends GetxController {
  String testKey = '0'; // 1 for  test and 0 for live
  RxBool isHomeLoading = false.obs;
  late TabController tabController;
  CarouselSliderController homeTab1CarouselController =
      CarouselSliderController();
  TabController? bottomController;
  late FirebaseMessaging messagingToken;
  RxInt pageIndex = 0.obs;
  RxString currentCountryCode = ''.obs;

  RxBool isAppBlocked = false.obs; //for blocking version
  RxBool isChooseEquipment = false.obs; //equipment choosed or not
  RxBool isStartBtnClicked = false.obs; //for changing start to view details
  RxInt tabIndex = 0.obs;
  RxString isTraineee = ''.obs;
  RxString isInspection = ''.obs;
  RxBool isTraineeUserLogin = false.obs; //training logined or not
  RxBool isTrainingSection = false.obs;
  RxBool isFromHome = false
      .obs; //for login condition if the user is navigate from home to login screen
  RxBool isFromPurchase = false.obs; //for

  Set equipmentListCustomer = {};
  List<bool> equipmentCheckValue = [];
  RxBool isuserLogin = false.obs;
  RxBool isTraineeLogin = false.obs;
  List<CustomerLocations> customerLocations = [];
  RxBool isLoadingEquipmentDetailsscreen = false.obs;
  EquipmentDetailModel equipmentDetailModel = EquipmentDetailModel();
  List<Map<String, dynamic>> googleReview = [
    {
      "name": 'Ivy Dalde',
      "imgUrl": 'assets/images/unnamed.png',
      "message":
          "Thanks for the good opportunity... I've learn  alot About the health and safety procedures and also for the first aide training that are very useful in our work...I'm very happy for this good experience..",
    },
    {
      "name": 'Titus Thuo',
      "imgUrl": 'assets/images/unnamed_1.png',
      "message":
          'I had an experience to work with one of the leading company in adventure outdoors and indoors whereby have gain skills and knowledge in different fields at work.',
    },
    {
      "name": 'Geetika Monga',
      "imgUrl": 'assets/images/unnamed_2.png',
      "message":
          'The most reliable company that I have come across. The whole team is so professional and really really take care of their clients',
    },
    {
      "name": 'Ruchita patel',
      "imgUrl": 'assets/images/ruchita_patel.png',
      "message": 'One of the best inspections company in UAE.',
    },
    {
      "name": 'Jean-Baptiste De Winter',
      "imgUrl": 'assets/images/jean_baptiste de winter.png',
      "message":
          'Highly recommended. Darlsco is not only proceeding to your site or installation inspection. They are also assisting you with the whole process. They are extremely professional and helpful.',
    },
    {
      "name": 'AL Daraawi',
      "imgUrl": 'assets/images/al_araawi.png',
      "message":
          'Distinctive service organized by doctors, customer service staff and translators',
    },
    {
      "name": 'Regine Napoles',
      "imgUrl": 'assets/images/regine_napoles.png',
      "message":
          'The team is awesome! From the trainer to examiner, they provide us the knowledge that we need and help us get through everything very smoothly. I would never forget this. Keep up the good work guys! 👏',
    },
    {
      "name": 'Laith Aljariri',
      "imgUrl": 'assets/images/laith_aljariri.png',
      "message":
          'They have a perfect service with great training team. Krunal and Divya were amazing in everything thanks alot and we will work together again',
    },
    {
      "name": 'Grace Achieng',
      "imgUrl": 'assets/images/grace_achieng.png',
      "message":
          'So professional regarding inspection... best training company they deliver the best team.Thank you DARLSCO',
    },
    {
      "name": 'Mohath Soodeen',
      "imgUrl": 'assets/images/mohathsoodeen.png',
      "message":
          'I had a very good experience with you,and i wish u the best😊',
    },
  ];

  List<String> ourClientsImgList = [
    'assets/clients/client1.png',
    'assets/clients/client2.png',
    'assets/clients/client3.png',
    'assets/clients/client4.png',
    'assets/clients/client5.png',
    'assets/clients/client6.png',
    'assets/clients/client7.png',
    'assets/clients/client8.png',
    'assets/clients/client9.png',
    'assets/clients/client10.png',
    'assets/clients/client11.png',
    'assets/clients/client12.png',
    'assets/clients/client13.png',
    'assets/clients/client14.png',
    'assets/clients/client15.png',
    'assets/clients/client16.png',
    'assets/clients/client17.png',
    'assets/clients/client18.png',
    'assets/clients/client19.png',
    'assets/clients/client20.png',
    'assets/clients/client21.png',
    'assets/clients/client22.png',
    'assets/clients/client23.png',
    'assets/clients/client24.png',
    'assets/clients/client25.png',
    'assets/clients/client26.png',
    'assets/clients/client27.png',
    'assets/clients/client28.png',
    'assets/clients/client29.png',
    'assets/clients/client30.png',
    'assets/clients/client31.png',
    'assets/clients/client32.png',
    'assets/clients/client33.png',
    'assets/clients/client34.png',
    'assets/clients/client35.png',
    'assets/clients/client36.png',
    'assets/clients/client37.png',
    'assets/clients/client38.png',
    'assets/clients/client39.png',
    'assets/clients/client40.png',
    'assets/clients/client41.png',
    'assets/clients/client42.png',
    'assets/clients/client43.png',
    'assets/clients/client44.png',
    'assets/clients/client45.png',
    'assets/clients/client46.png',
    'assets/clients/client47.png',
    'assets/clients/client48.png',
    'assets/clients/client49.png',
    'assets/clients/client50.png',
    'assets/clients/client51.png',
    'assets/clients/client52.png',
    'assets/clients/client53.png',
    'assets/clients/client54.png',
    'assets/clients/client55.png',
    'assets/clients/client56.png',
    'assets/clients/client57.png',
    'assets/clients/client58.png',
    'assets/clients/client59.png',
    'assets/clients/client60.png',
    'assets/clients/client61.png',
    'assets/clients/client62.png',
    'assets/clients/client63.png',
    'assets/clients/client64.png',
    'assets/clients/client65.png',
    'assets/clients/client66.png',
    'assets/clients/client67.png',
    'assets/clients/client68.png',
  ];
  List<String> accreditationImgList = [
    // 'assets/accreditation/Logo.jpg',
    'assets/accreditation/accreditation_img.jpg',
    'assets/accreditation/accreditation_img1.jpg',
    'assets/accreditation/accreditation_img2.jpg',
    'assets/accreditation/accreditation_img3.jpg',
    'assets/accreditation/accreditation_img4.jpg',
    'assets/accreditation/accreditation_img5.jpg',
    'assets/accreditation/accreditation_img6.jpg',
    'assets/accreditation/accreditation_img7.jpg',
    'assets/accreditation/accreditation_img8.jpg',
    'assets/accreditation/accreditation_img9.jpg',
    'assets/accreditation/accreditation_img11.jpg',
    'assets/accreditation/accreditation_img12.jpg',
    'assets/accreditation/accreditation_img13.jpg',
  ];

  List<Color> cBgColorTrainingTab1 = [
    const Color(0xffC9CBFF),
    const Color(0xffFEC4FF),
  ];
  List<Color> numBgColorTrainingTab1 = [
    const Color(0xffB7B6FF),
    const Color(0xffFEB4F7),
  ];
  List<Color> cBgColorTrainingTab3 = [
    const Color(0xffF7FFEB),
    const Color(0xffFFEDD1),
    const Color(0xffE0FFE6),
  ];
  List<Color> numBgColorTrainingTab3 = [
    const Color(0xffFFFCB6),
    const Color(0xffFEE0B4),
    const Color(0xffB6FFCA),
  ];
  List<Color> cBgColorTrainingTab2 = [
    const Color(0xffF3FFE3),
    const Color(0xffFFCFCF),
    const Color(0xffEBCAFF),
    const Color(0xffC3FFEA),
  ];

  List<Color> numBgColorTrainingTab2 = [
    const Color(0xffFEFFB6),
    const Color(0xffFEB4B4),
    const Color(0xffE6BDFF),
    const Color(0xffBDFFE7),
  ];

  List<String> contentTextTrainingTab1 = [
    'Total Training Taken',
    'Upcoming Trainings',
  ];

  List<String> contentTextTrainingTab3 = <String>[
    'Total Equipments',
    'Upcoming Calibration',
    'Total Locations'
  ];

  List<String> contentTextTrainingTab2 = [
    'Total Locations',
    'Total Equipments',
    'Expiring Equipments',
    'Upcoming Inspections',
  ];
  List<String> numberTextList = ['0', '0', '0', '0'];
  List<void Function()> functionsTrainingTab2 = [
    () async {
      await homeController.getCustomerPlace();

      Get.to(() => CompanyLocationScreen());
    },
    () {
      upcomingInspectionsController.getAllEquipments(
          isFromSplash: false, isNotHomeBlock: true);

      // Get.to(
      //   () => const ExpiringEquipmentScreen(),
      // );
    },
    () {
      homeController.searchExpiringInspections(
          context: Get.context, isfromSplashScreen: false);
    },
    () {
      upcomingInspectionsController.getCustomerTask(isFromSplash: false);
    },
  ];

  RxString inspectionDropdownValue = ''.obs;
  RxString allUserDropDownValue = ''.obs;
  RxString currentUserDropDownValue = ''.obs;
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  TextEditingController inspectionFullNameController = TextEditingController();
  TextEditingController inspectionLocationController = TextEditingController();
  TextEditingController inspectionDateController = TextEditingController();

  TextEditingController inspectionCategoryController = TextEditingController();

  TextEditingController inspectionMessageController = TextEditingController();
  List<CustomerEquipmentList> customerEquipmentData = [];
  List<CustomerEquipmentList> customerEquipmentExpiringData = [];
  List getAllUsersList = [];
  List getCurrentUsersList = [];
  //methhod for getting device id

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return null;
  }

// @override
//   void onReady() {
//     //

//     initfunction();

//      print('init function');
//     super.onReady();
//   }
//   @override
//   void onInit() {
//     // print('init function');

//     super.onInit();
//   }

  initfunction() async {
    print('efertgetr');
    isHomeLoading.value=true;
    await isUsersignedIn();
    //  await InAppUpdateInfo.checkForUpdate();
    //  if(InAppUpdateInfo.updateInfo?.immediateUpdateAllowed ==true){
    //   InAppUpdate.performImmediateUpdate();
    //  }

    if (isuserLogin.value == true) {
      await getCustomerPlace();

      await upcomingInspectionsController.getCustomerTask(isFromSplash: true);
      // for (var i = 0; i < 1; i++) {
      //   print('ferfget')
      await upcomingInspectionsController.getAllEquipments(
          isFromSplash: true, isNotHomeBlock: false);
      //     break;
      // }

      await homeController.searchExpiringInspections(
          context: Get.context, isfromSplashScreen: true);
      upcomingInspectionsController.update();
    }
    await trainingController.fetchTrainingHomeData();
    await trainingController.getItemCart();
    print('getItemCart8');
    isHomeLoading.value=false;

    update();
  }

  postPurchaseOrder() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? deviceId = await _getId();
    print("sahgkjhsa///////Device ID $deviceId");
    int customerId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    String servicePercentage =
        sharedPreferences.getString('transaction_fee') ?? '';
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    Map<String, dynamic> jsonData = {
      "Customer_Id_": customerId,
      "Order_Date_": formattedDate,
      "Total_Amount_": tcontoller.subTotal,
      "Vat_Amount_": tcontoller.totalVat,
      "Vat_pers_": 0.00,
      "Service_Charge_": tcontoller.serviceCharge,
      "Service_pers_": servicePercentage,
      "Grand_Total_": tcontoller.totalPrice,
      "Payment_Status_": tcontoller.isPaymentSuccessful.value == true ? 2 : 3,
      "Payment_Status_Name_":
          tcontoller.isPaymentSuccessful.value == true ? 'Completed' : 'Cancel',
      "Reference_Id_": tcontoller.orderNo,

      "Start_Date": formattedDate,
      "End_Date": formattedDate,
      "User_Id": customerId,
      "Payment_Mode_Id_": 1,
      "Payment_Mode_Name_": 'Online',
      "Transaction_Id_": tcontoller.orderNo,
      "Transaction_Date_And_Time_": now,
      "Device_Id_": deviceId,
      // "Current_Status_Id": 1,
      // "Current_Status_Name": tcontoller.isPaymentSuccessful.value == true
      //     ? 'completed'
      //     : 'not completed',

      // "Active_Status_Id": 1,
      // "Active_Status_Name":
      //     tcontoller.isPaymentSuccessful.value == true ? 'Active' : 'Inactive',

      "Order_Details": trainingController.cartPriceList
          .map((e) => {
                "Training_Course_Id": e.trainingCourseId,
                "Training_Course_Name": e.trainingCourseName,
                "Training_Course_Category_Id": e.trainingCourseCategoryId,
                "Category_Name": e.categoryName,
                "Description": 'sss',
                "Application_Fees": e.applicationFee,
                "Examination_Fees": e.examinationFee,
                "Certificate_Fees": e.certificateFee,
                "TrainingwithExam_Fees": e.amount,
                "Quantity": e.quantity,
                "Tax": e.tax,
                "Examination_Tax": e.examinationTax,
                "Application_Tax": e.applicationTax,
                "Certificate_Tax": e.certificateTax,
                "Retake_Only_Practical_Tax": e.retakeOnlyPracticalTax,
                "Retake_Only_Written_Tax": e.retakeOnlyWrittenTax,
                "Training_Type_Id": 1,
                "Training_Type_Name": 'Examination with Training',
                "RetakeOnly_Practical_Fees": e.retakepracticalFee,
                "RetakeOnly_Writen_Fess": e.retakeWrittenFee,

                // "Status_Id": 0,
                // "Status_Name": tcontoller.isPaymentSuccessful.value == true
                //     ? 'Success'
                //     : 'failed',

//                 "Course_Quantity_Amount": double.parse(e.amount)*e.quantity,
//                 'Course_Vat_Amount': ((double.parse(e.amount)*e.quantity)*      double.parse(e.tax)/100),

//                 "Course_Total":(double.parse(e.amount)*e.quantity)+((double.parse(e.amount)*e.quantity)*      double.parse(e.tax)/100),
//                 'Certificate_Quantity_Amount':double.parse(e.certificateFee)*e.quantity,
//                 'Certificate_Vat_Amount':((double.parse(e.certificateFee)*e.quantity)*      double.parse(e.certificateTax)/100),

//                 'Certificate_Total':(double.parse(e.certificateFee)*e.quantity)+((double.parse(e.certificateFee)*e.quantity)*      double.parse(e.certificateTax)/100),
//                 'Application_Quantity_Amount': double.parse(e.applicationFee)*e.quantity,
//                 'Application_Vat_Amount':((double.parse(e.applicationFee)*e.quantity)*      double.parse(e.applicationTax)/100),
// 'Application_Total':(double.parse(e.applicationFee)*e.quantity)+((double.parse(e.applicationFee)*e.quantity)*      double.parse(e.applicationTax)/100),
                "Duration": e.duration,
                "Is_Training_with_examination": 0,
                "Is_Retake_Only": 0,
                "Is_Written": 0,
                "Is_Practical": 0,
                "StartTime": "",
                "End_Time": "",
                "Notes": "",
              })
          .toList()
    };

    print('retake test ${trainingController.cartPriceList}');

    await HttpRequest.httpPostDataRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.saveOrderApp,
    ).then((response) {
      print('ggggg$response');

      if (response != null && response.statusCode == 200) {
        print(response);
        // trainingController.cartPriceList.clear();
        print("Successfull");

        print('asdf${response.statusCode}');
      } else {
        print(response);
        print("Not Successfull");
      }
    });
  }

  void getAllusers() async {
    currentUserDropDownValue.value = '';
    allUserDropDownValue.value = '';
    await HttpRequest.httpGetRequest(
      bodyData: {
        'Task_Id_': upcomingInspectionsController.taskDetailsData[0]['Task_Id']
      },
      endPoint: HttpUrls.getFullUsers,
    ).then((value) {
      if (value.data != null) {
        getAllUsersList = value.data[0];
        getCurrentUsersList = value.data[1];
        Get.to(() => const UserListScreen());
      }
      update();
    });
  }

  checkCountryCode(BuildContext context) async {
    print(homeController.currentCountryCode.value);
    if (homeController.currentCountryCode.value == '') {
      PermissionStatus locationStatus = await Permission.location.status;

      if (!locationStatus.isDenied) {
        homeController.currentCountryCode.value =
            await getCountryName(context) ?? '';
      }
    }
  }

  void changeTaskUser(BuildContext context) async {
    try {
      Map<String, dynamic> changtaskBodyData = {
        'Task_Id_': upcomingInspectionsController.taskDetailsData[0]['Task_Id'],
        'From_User_': getCurrentUsersList
            .where((element) =>
                element['User_Details_Name'].toString().toLowerCase() ==
                currentUserDropDownValue.value.toLowerCase())
            .toList()[0]['User_Details_Id'],
        'To_User_': getAllUsersList
            .where((element) =>
                element['User_Details_Name'].toString().toLowerCase() ==
                allUserDropDownValue.value.toLowerCase())
            .toList()[0]['User_Details_Id'],

        // upcomingInspectionsController.taskDetailsData[0]['Task_Id']
      };

      await HttpRequest.httpGetRequest(
        bodyData: changtaskBodyData,
        endPoint: HttpUrls.changeTaskUser,
      ).then((value) async {
        if (value.data[0].isNotEmpty) {
          homeController.allUserDropDownValue.value = '';
          homeController.currentUserDropDownValue.value = '';

          ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
              content: Text('Team member successfully updated!')));
          await upcomingInspectionsController.taskInitFunction(context);
          Get.offAll(() => const TrainingInspectionScreen());
        }
        update();
      });
    } catch (e) {
      // errorLoggingSnackbaR(context, functionName: 'changeTaskUser', error: e.toString());
    }
  }

  purchaseGateWay(context, totalPrice,
      {bool isRetake = false,
      String orderMasterId = '0',
      required String phoneNumber,
      required String email,
      required String name}) async {
    print(authKey);
    print(
        'inside purchase xml function ${trainingController.retakePurchaseBillDataList}');
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('mobile', nest: () {
      builder.element('store', nest: () {
        builder.text(StoreId);
      });
      builder.element('key', nest: () {
        builder.text(authKey);
      });

      builder.element('device', nest: () {
        builder.element('type', nest: () {
          builder.text('iOS');
        });
        builder.element('id', nest: () {
          builder.text('1');
        });
      });

      // app
      builder.element('app', nest: () {
        builder.element('name', nest: () {
          builder.text('Darlsco');
        });
        builder.element('version', nest: () {
          builder.text('1.1.6');
        });
        builder.element('user', nest: () {
          builder.text('2');
        });
        builder.element('id', nest: () {
          builder.text('1');
        });
      });

      //tran
      builder.element('tran', nest: () {
        builder.element('test', nest: () {
          builder.text(testKey);
        });
        builder.element('type', nest: () {
          builder.text('sale');
        });
        builder.element('class', nest: () {
          builder.text('paypage');
        });
        builder.element('cartid', nest: () {
          builder.text(100000000 + Random().nextInt(999999999));
        });
        builder.element('description', nest: () {
          builder.text('Online Payment');
        });
        builder.element('currency', nest: () {
          builder.text('AED');
        });
        builder.element('amount', nest: () {
          builder.text('$totalPrice');
        });
        builder.element('language', nest: () {
          builder.text('en');
        });
        builder.element('firstref', nest: () {
          builder.text('first');
        });
        builder.element('ref', nest: () {
          builder.text('null');
        });
      });

      //billing
      builder.element('billing', nest: () {
        // name
        builder.element('name', nest: () {
          builder.element('title', nest: () {
            builder.text(name);
          });
          builder.element('first', nest: () {
            builder.text('');
          });
          builder.element('last', nest: () {
            builder.text('');
          });
        });
        // address
        builder.element('address', nest: () {
          builder.element('line1', nest: () {
            builder.text('Dubai');
          });
          builder.element('city', nest: () {
            builder.text('Dubai');
          });
          builder.element('region', nest: () {
            builder.text('');
          });
          builder.element('country', nest: () {
            builder.text('AE');
          });
        });

        builder.element('phone', nest: () {
          builder.text(phoneNumber);
        });
        builder.element('email', nest: () {
          builder.text(email);
        });
      });
    });

    final bookshelfXml = builder.buildDocument();

    pay(bookshelfXml, context, isRetake, orderMasterId);
  }

  void getCustomerEquipments(context, locationId,
      {isFromLocationScreen = false}) async {
    update();

    // Loader.showLoader();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int customerId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');

    customerEquipmentData.clear();
    await HttpRequest.httpGetRequest(
      bodyData: {
        "Customer_Id_": customerId,
        "Location_Id_": locationId,
      },
      endPoint: HttpUrls.getCustomerEquipments,
    ).then((value) {
      if (value.statusCode == 200) {
        if (isFromLocationScreen) {
          Get.to(
            () => const EquipmentListScreenMob(),
          );
        } else {
          if (value.data[0].isEmpty && isFromLocationScreen == false) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('No equipment found this location')));
          } else {
            Get.to(() => HomeEquipmentListScreen());
          }
        }

        for (var element in value.data[0]) {
          customerEquipmentData.add(CustomerEquipmentList.fromJson(element));
        }

        // final data=jsonDecode(value.data[0].toString());
// ist<CustomerEquipmentList> result= value.data[0].map((e)=>CustomerEquipmentList.fromJson(e)).toList()as  List<CustomerEquipmentList> ;

        if (equipmentCheckValue.isEmpty ||
            equipmentCheckValue.length != customerEquipmentData.length) {
          equipmentCheckValue = List.generate(
              homeController.customerEquipmentData.length, (index) => false);
        }
        // print(customerEquipmentData[0].equipmentName);
      }
    });

    update();
  }

  getCustomerPlace() async {
    // Loader.showLoader();
    customerLocations.clear();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int customerId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');

    await HttpRequest.httpGetRequest(
      bodyData: {
        "Customer_Id_": customerId,
      },
      endPoint: HttpUrls.getCustomerPlace,
    ).then((value) {
      if (value.statusCode == 200) {
        // Loader.stopLoader();

        for (var element in value.data[0]) {
          customerLocations.add(CustomerLocations.fromJson(element));
        }

        homeController.numberTextList[0] = '${customerLocations.length}';
      }
    });

    update();
  }

  versionCheck(versionNumber, BuildContext context) async {
    try {
      Map<String, dynamic> postData = {"Version_Number": versionNumber};
      print('dfswgr Version Checkinggg..');
      await HttpRequest.httpGetRequest(
              endPoint: HttpUrls.checkVersion, bodyData: postData)
          .then((value) {
        print('dfswgr $value');
        isAppBlocked.value =
            value.data['Status'].toString() == '0' ? true : false;
      });
    } catch (e) {
      // errorLoggingSnackbaR(context, functionName: 'versionCheck', error: e.toString());
    }
  }

  searchExpiringInspections({context, isfromSplashScreen = false}) async {
    customerEquipmentExpiringData.clear();
    equipmentCheckValue.clear();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int customerId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    Map<String, dynamic> postData = {"Customer_Id_": customerId};

    await HttpRequest.httpGetRequest(
            endPoint: HttpUrls.searchExpiringInspections, bodyData: postData)
        .then((value) {
      if (value.data['returnvalue']['Leads'].isEmpty &&
          isfromSplashScreen == false) {
        if (isfromSplashScreen == false) {
          Get.to(() => const ExpiringEquipmentScreen());
        }
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('No equipment found this location')));
      } else {
        if (isfromSplashScreen == false) {
          Get.to(() => const ExpiringEquipmentScreen());
        }
      }

      for (var element in value.data['returnvalue']['Leads']) {
        customerEquipmentExpiringData
            .add(CustomerEquipmentList.fromJson(element));
      }

      if (equipmentCheckValue.isEmpty ||
          equipmentCheckValue.length != customerEquipmentExpiringData.length) {
        equipmentCheckValue = List.generate(
            homeController.customerEquipmentExpiringData.length,
            (index) => false);
      }
      // print(customerEquipmentData[0].equipmentName);

      homeController.numberTextList[2] =
          '${customerEquipmentExpiringData.length}';

      // print('expiring value ${customerEquipmentExpiringData[0].equipmentId}');
    });
    update();
  }

  void saveCustomerRequest(
      {required context, ispostdataExpiring = false}) async {
    // Loader.showLoader();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int customerId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    Map<String, dynamic> postDataExpiring = {};
    Map<String, dynamic> postData = {};
    if (ispostdataExpiring == false) {
      postData = {
        // "Customer_Request_Id":0,
        "Customer_Id": customerId,
        "Entry_Date": DateTime.now(),
        "Inspection_Date": DateFormat('yyyy-MM-dd').format(
            DateFormat('dd-MM-yyyy')
                .parse(homeController.inspectionDateController.text)),
        "Description": inspectionMessageController.text,

        "Location_Id": customerLocations
            .where((element) {
              return element.locationName == inspectionDropdownValue.value;
            })
            .toList()[0]
            .locationId,
        "Equipments": equipmentListCustomer.map((e) => e).toList(),
      };
    } else {
      postDataExpiring = {
        // "Customer_Request_Id":0,
        "Customer_Id": customerId,
        "Entry_Date": DateTime.now(),
        // "Inspection_Date": DateFormat('yyyy-MM-dd').format(
        //     DateFormat('dd-MM-yyyy')
        //         .parse(homeController.inspectionDateController.text)),
        // "Description": inspectionMessageController.text,

        // "Location_Id": customerLocations
        //     .where((element) {

        //       return element.locationName == inspectionDropdownValue.value;
        //     })
        //     .toList()[0]
        //     .locationId,
        "Equipments": equipmentListCustomer.map((e) => e).toList(),
      };
    }

    await HttpRequest.httpPostRequest(
            endPoint: ispostdataExpiring
                ? HttpUrls.saveCustomerRequestExpiringEquipment
                : HttpUrls.saveCustomerRequest,
            bodyData: ispostdataExpiring ? postDataExpiring : postData)
        .then((value) async {
      if (value != null) {
        if (value.statusCode == 200) {
          // Loader.stopLoader();
          inspectionDropdownValue.value = '';
          inspectionMessageController.clear();
          equipmentListCustomer.clear();
          equipmentCheckValue.clear();
          inspectionDateController.clear();
          if (value.data[0].isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(ispostdataExpiring
                    ? "Expirying Equipment Inspection Request submitted successfully"
                    : 'Inspection Request submitted sucessfully')));

            if (ispostdataExpiring) {
              print(customerEquipmentExpiringData);

              Get.back();
            }

            await HttpRequest.httpPostRequest(
                endPoint: HttpUrls.notificationUrl,
                bodyData: {
                  'Notification_Id_': value.data[0]['Notification_Id_'],
                  'Customer_Request_Id_': value.data[0]['Customer_Request_Id_'],
                  'Customer_Name_': value.data[0]['Customer_Name_'],
                  'Notification_Type_Name_': value.data[0]
                      ['Notification_Type_Name_'],
                });
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Server Error')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Server Error')));
      }
    });

    update();
  }

  selectingEquipment(value, bool check) {
    if (check) {
      equipmentListCustomer.add(value);
    } else {
      equipmentListCustomer.removeWhere(
          (element) => element['Equipment_Id'] == value['Equipment_Id']);
    }

    update();
  }

  isUsersignedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString('token') ?? '';
    String? userId = preferences.getString('darlsco_id');
    String isTraineeCustomer = preferences.getString('trainee_login') ?? '';
    String isInspectionCustomer =
        preferences.getString('inspection_login') ?? '';

    if (token == '' || token == 'null') {
      isuserLogin.value = false;
      isTraineeLogin.value = false;
    } else if (isTraineeCustomer == '1' && isInspectionCustomer == '0') {
      isTraineeLogin.value = true;
      isuserLogin.value = false;
    } else if (isTraineeCustomer == '1' && isInspectionCustomer == '1') {
      isuserLogin.value = true;
      isTraineeLogin.value = true;
    } else if (isTraineeCustomer == '0' && isInspectionCustomer == '1') {
      isuserLogin.value = true;
      isTraineeLogin.value = false;
    } else {
      isuserLogin.value = false;
      isTraineeLogin.value = false;
    }
  }

  publicTextboxValidation() {
    if (inspectionLocationController.text.isEmpty ||
        inspectionCategoryController.text.isEmpty ||
        homeController.inspectionMessageController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('all fields are required')));
    } else {
      contactUsController.savePublicInspection();
    }
  }

  Future<bool> verifyCustomerProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int customerId =
        int.parse(sharedPreferences.getString('darlsco_id') ?? '0');
    Map<String, dynamic> postData = {"Customer_Id_": customerId};
    bool verifyProfileValue = false;

    try {
      await HttpRequest.httpGetRequest(
              endPoint: HttpUrls.verifyCustomerProfile, bodyData: postData)
          .then((value) async {
        print("is profile updated  ${value.data[0][0]['Profile_Status']}");

        SharedPreferences preferences = await SharedPreferences.getInstance();
        String customerType = preferences.getString('type') ?? '';
        print('customer type $customerType');
        if (customerType == 'customer') {
          if (value.data[0][0]['Profile_Status'].toString() == '1') {
            verifyProfileValue = true;
          } else {
            verifyProfileValue = false;
          }
        } else {
          verifyProfileValue = false;
        }
      });
    } catch (e) {
      print(e);
    }

    return verifyProfileValue;
  }

  Future<void> checkUserTypeChanged(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String customerId = prefs.getString('darlsco_id') ?? "";
      final String customerType = prefs.getString('type') ?? "";

      final String token = prefs.getString('token') ?? "";
      if (customerType.isNotEmpty && customerId.isNotEmpty) {
        await Dio().get('${HttpUrls.baseUrl}${HttpUrls.getUserChangeStatus}',
            options: Options(headers: {
              'ngrok-skip-browser-warning': 'true',
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            }),
            queryParameters: {
              'User_Id_': int.parse(customerId),
              'Type_': customerType == 'customer' ? 1 : 2,
            }).then((response) {
          if (response.statusCode == 200) {
            final data = response.data;

            prefs.setString(
                'trainee_login', (data[0][0]['Training_'] ?? '0').toString());
            prefs.setString('inspection_login',
                (data[0][0]['Inspection_'] ?? '0').toString());
            homeController.isInspection.value =
                (data[0][0]['Inspection_'] ?? '0').toString();
            homeController.isTraineee.value =
                (data[0][0]['Training_'] ?? '0').toString();

            homeController.isUsersignedIn();
            if (homeController.isuserLogin.value == true) {
              //  {
              homeController.initfunction();
            }
// }else{

//    upcomingInspectionsController.taskInitFunction();

// }

            print('customer change status $response');
          }
        });
      }

      update();
    } catch (e) {
      //  errorLoggingSnackbaR(context, functionName: 'checkUserTypeChanged', error: e.toString());
    }
  }

  Future<void> getSingleEquipMentData(String equipmentId) async {
    // try {
    isLoadingEquipmentDetailsscreen.value = true;
    var res = await HttpRequest.httpGetRequest(
        endPoint:
            '/Customer/Search_Equipment_Certificate/?Equipment_Id_=$equipmentId');
    equipmentDetailModel = EquipmentDetailModel.fromJson(res.data);
    isLoadingEquipmentDetailsscreen.value = false;

    print('Equip $equipmentDetailModel');
    // } catch (e) {
    //   print(e.toString());
    //          isLoadingEquipmentDetailsscreen.value=false;

    // }
  }
}
