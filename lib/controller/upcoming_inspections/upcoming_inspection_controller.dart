import 'dart:async';
import 'dart:convert';

import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/http/http_request.dart';
import 'package:darlsco/http/http_urls.dart';
import 'package:darlsco/model/used_equipment/used_documents_list.dart';
import 'package:darlsco/model/used_equipment/used_equipment_list.dart';
import 'package:darlsco/model/used_equipment/used_ppe_list.dart';
import 'package:darlsco/view/equipment_list/equipment_list_screen_mob.dart';
import 'package:darlsco/view/risk_assessment/risk_assessment_screen.dart';
import 'package:darlsco/view/risk_assessment/risk_assessment_stop_screen.dart';
import 'package:darlsco/view/training/training_equipment_screen.dart';
import 'package:darlsco/view/up_coming_inspectons/up_coming_inspections_screen.dart';
import 'package:darlsco/view/widgets/loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/home/customer_equipment_list.dart';
import '../../view/home/bottom_navigation_screen.dart';
import '../../view/training/task_page.dart';
import '../../view/training/training_screen.dart';
import '../tainning/trainnig_controller.dart';

final UpcomingInspectionsController upcomingInspectionsController =
    Get.put(UpcomingInspectionsController());

class UpcomingInspectionsController extends GetxController {
  List customerTaskModel = [];
  TextEditingController startDatePickController = TextEditingController();
  TextEditingController endDatePickController = TextEditingController();
  List totalEquipments = [];
  List upcomingInspectionListData = [];
  List upcomingInspectionListDataCalibration = [];
  List todayTaskListData = [];
  List todayTaskListDataCalibration = [];
  List tommorowTaskListData = [];
  List tommorowTaskListDataCalibration = [];
  List yesterdayTaskListData = [];
  List yesterdayTaskListDataCalibration = [];
  List selectDateTaskListData = [];
  List selectDateTaskListDataCalibration = [];
  List taskDetailsData = [].obs;
  List taskDetailsDataCalibration = [].obs;
  List taskEquipmentListData = [];
  List taskEquipmentListDataCalibration = [];
  List taskUserDetails = [];
  List taskUserDetailsCalibration = [];
  List usedTestEquipments = [];
  List usedTestEquipmentsCalibration = [];
  List usedTestPpes = [];
  List usedTestPpesCalibration = [];
  List usedTestDocuments = [];
  List usedTestDocumentsCalibration = [];
  bool isDateSubmitBtnClicked = false;
  List testEquipmentSearchResult = [];
  List testPpeSearchResult = [];
  List testDocumentSearchResult = [];
  List eqList = [];
  List equipmentStatusLIst = [];
  RxBool isEquipmentSelected = false.obs;
  RxBool isScreenLoading = false.obs;
  bool isOwner = false;
  List<Map<String, dynamic>> usedEquipmentData = [];
  List<Map<String, dynamic>> usedEquipmentDataCalibration = [];
  List<Map<String, dynamic>> usedTestppeData = [];
  List<Map<String, dynamic>> usedTestppeDataCalibration = [];
  List<Map<String, dynamic>> usedTestDocumentData = [];
  List<Map<String, dynamic>> usedTestDocumentDataCalibration = [];
  TextEditingController searchControllerTestEquipment = TextEditingController();
  TextEditingController searchControllerTestPpe = TextEditingController();
  TextEditingController searchControllerTestDocument = TextEditingController();
  RxBool isLoading = false.obs;
  taskInitFunction(BuildContext context) async {
   try {
      isLoading.value = true;
    await todayTaskController.fetchTaskCount();
    // await trainingController.getTodayTask();
    await trainingController.getUpComingTask();
    await trainingController.getTotalTraining();
    await upcomingInspectionsController.getTodayTaskDetails(true);
    await upcomingInspectionsController.getTommorrowTaskDetails(true);
    await upcomingInspectionsController.getYesterdayTaskDetails(true);
    if (homeController.isuserLogin.value == true ||
        homeController.isTraineeLogin.value == true) {
      Timer.periodic(const Duration(minutes: 1), (timer) {
        homeController.checkUserTypeChanged(
          context,
        );
      });
    }
    isLoading.value = false;
   } catch (e) {
     
   }
  }

  getCustomerTask({required isFromSplash}) async {
    // Loader.showLoader();
    upcomingInspectionListData.clear();
    upcomingInspectionListDataCalibration.clear();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int customerId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    await HttpRequest.httpGetRequest(
      bodyData: {
        "Customer_Id_": customerId,
      },
      endPoint: HttpUrls.getCustomerTask,
    ).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        // final result=value.data[0];

        // customerTaskModel=result.map((e)=>CustomerTaskModel.fromJson( e)).toList() ;
        // print('customer data $customerTaskModel');
        // Loader.stopLoader();

        upcomingInspectionListData = value.data[0];
        homeController.numberTextList[3] =
            '${upcomingInspectionListData.length}';
        homeController.update();
        if (isFromSplash == false) {
          Get.to(() => UpcomingInspectionsScreen());
        }
      } else {
        // ScaffoldMessenger.of(Get.context!)
        //     .showSnackBar(const SnackBar(content: Text('Server Error')));
      }
    });
    // ========================= Calibration API==========================
    await HttpRequest.httpGetRequest(
      bodyData: {
        "Customer_Id_": customerId,
      },
      endPoint: HttpUrls.getCustomerTaskCalibration,
    ).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        // final result=value.data[0];

        // customerTaskModel=result.map((e)=>CustomerTaskModel.fromJson( e)).toList() ;
        // print('customer data $customerTaskModel');
        // Loader.stopLoader();

        upcomingInspectionListDataCalibration = value.data[0];
        homeController.numberTextList[3] =
            '${upcomingInspectionListDataCalibration.length}';
        homeController.update();
        if (isFromSplash == false) {
          Get.to(() => UpcomingInspectionsScreen());
        }
      } else {
        // ScaffoldMessenger.of(Get.context!)
        //     .showSnackBar(const SnackBar(content: Text('Server Error')));
      }
    });
    print('1111111111111111111111111111111111111111111111 = 1');
    update();
  }

  getAllEquipments({required isFromSplash, required isNotHomeBlock}) async {
    // Loader.showLoader();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int customerId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');

    homeController.customerEquipmentData.clear();
    homeController.customerEquipmentDataCalibration.clear();

    await HttpRequest.httpGetRequest(
      bodyData: {
        "Customer_Id_": customerId,
      },
      endPoint: HttpUrls.getTotalEquipments,
    ).then((value) {
      if (value.statusCode == 200) {
        // Loader.stopLoader();
        print('sdfsvert ${value.data[0]}');

        if (value.data[0].isEmpty) {
          if (isFromSplash == false && isNotHomeBlock == false) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
                content: Text(
                    'No equipments are currently available. They will be added soon. For assistance, contact the Team!')));
          }

          if (isFromSplash == false) {
            Get.to(
              () => const EquipmentListScreenMob(),
            );
          }
        } else {
          for (var element in value.data[0]) {
            homeController.customerEquipmentData
                .add(CustomerEquipmentList.fromJson(element));
          }

          homeController.numberTextList[1] =
              '${homeController.customerEquipmentData.length}';
          homeController.update();
          if (homeController.equipmentCheckValue.isEmpty ||
              homeController.equipmentCheckValue.length !=
                  homeController.customerEquipmentData.length) {
            homeController.equipmentCheckValue = List.generate(
                homeController.customerEquipmentData.length, (index) => false);
          }

          if (isFromSplash == false) {
            Get.to(
              () => const EquipmentListScreenMob(),
            );
          }

          // Get.to(() => HomeEquipmentListScreen());
        }

        // final data=jsonDecode(value.data[0].toString());
// ist<CustomerEquipmentList> result= value.data[0].map((e)=>CustomerEquipmentList.fromJson(e)).toList()as  List<CustomerEquipmentList> ;
      }
    });
    //================= Calibration API ======================
    await HttpRequest.httpGetRequest(
      bodyData: {
        "Customer_Id_": customerId,
      },
      endPoint: HttpUrls.getTotalEquipmentsCalibration,
    ).then((value) {
      if (value.statusCode == 200) {
        // Loader.stopLoader();
        print('sdfsvert ${value.data[0]}');

        if (value.data[0].isEmpty) {
          if (isFromSplash == false && isNotHomeBlock == false) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
                content: Text(
                    'No equipments are currently available. They will be added soon. For assistance, contact the Team!')));
          }

          if (isFromSplash == false) {
            Get.to(
              () => const EquipmentListScreenMob(),
            );
          }
        } else {
          for (var element in value.data[0]) {
            homeController.customerEquipmentDataCalibration
                .add(CustomerEquipmentList.fromJson(element));
          }

          homeController.numberTextList[1] =
              '${homeController.customerEquipmentDataCalibration.length}';
          homeController.update();
          if (homeController.equipmentCheckValue.isEmpty ||
              homeController.equipmentCheckValue.length !=
                  homeController.customerEquipmentData.length) {
            homeController.equipmentCheckValue = List.generate(
                homeController.customerEquipmentData.length, (index) => false);
          }

          if (isFromSplash == false) {
            Get.to(
              () => const EquipmentListScreenMob(),
            );
          }

          // Get.to(() => HomeEquipmentListScreen());
        }

        // final data=jsonDecode(value.data[0].toString());
// ist<CustomerEquipmentList> result= value.data[0].map((e)=>CustomerEquipmentList.fromJson(e)).toList()as  List<CustomerEquipmentList> ;
      }
    });
    print('1111111111111111111111111111111111111111111111 =2');

    update();
  }

  getUserTask() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int userId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');

    await HttpRequest.httpGetRequest(
      bodyData: {
        "User_Details_Id_": userId,
      },
      endPoint: HttpUrls.getUserTask,
    ).then((value) {
      if (value.statusCode == 200) {
        // Get.to(()=>const UpcomingInspectionsScreen());
      } else {
        // ScaffoldMessenger.of(Get.context!)
        //     .showSnackBar(const SnackBar(content: Text('Server Error')));
      }
    });
    update();
  }

  getTodayTaskDetails(isInitState) async {
    if (homeController.isCalibrationSection.value) {
      todayTaskListDataCalibration = await getCalibrationTasks(
          isInitSate: isInitState,
          startDate: DateTime.now(),
          endDate: DateTime.now());
      print('sfgwerg');
    } else {
      print('sfgwerg123');
      todayTaskListData = await getuserTaskDateRange(
          isInitSate: isInitState,
          startDate: DateTime.now(),
          endDate: DateTime.now());
    }
    homeController.update();
    update();
  }

  getTommorrowTaskDetails(isInitState) async {
    if (homeController.isCalibrationSection.value) {
      tommorowTaskListDataCalibration = await getCalibrationTasks(
          isInitSate: isInitState,
          startDate: DateTime.now().add(const Duration(days: 1)),
          endDate: DateTime.now().add(const Duration(days: 1)));
          print('djjnwrjjio to $tommorowTaskListDataCalibration');
    } else {
      tommorowTaskListData = await getuserTaskDateRange(
          isInitSate: isInitState,
          startDate: DateTime.now().add(const Duration(days: 1)),
          endDate: DateTime.now().add(const Duration(days: 1)));
    }

    update();
  }

  getYesterdayTaskDetails(isInitState) async {
    if (homeController.isCalibrationSection.value) {
      yesterdayTaskListDataCalibration = await getCalibrationTasks(
          isInitSate: isInitState,
          startDate: DateTime.now().subtract(const Duration(days: 1)),
          endDate: DateTime.now().subtract(const Duration(days: 1)));
      print('XHECKINFGGG $yesterdayTaskListDataCalibration');
    } else {
      yesterdayTaskListData = await getuserTaskDateRange(
          isInitSate: isInitState,
          startDate: DateTime.now().subtract(const Duration(days: 1)),
          endDate: DateTime.now().subtract(const Duration(days: 1)));
    }

// yesterdayTaskListData    .reversed;''
    update();
  }

  Future<List> getuserTaskDateRange(
      {required DateTime startDate,
      required DateTime endDate,
      required bool isInitSate}) async {
    if (isDateSubmitBtnClicked == true) {
      // Loader.showLoader();
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int customerId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    Map<String, dynamic> apiData = {
      "User_Details_Id_": customerId,
      'From_Date_': startDate,
      'To_Date_': endDate,
    };
    List result = [];

    await HttpRequest.httpGetRequest(
      bodyData: apiData,
      endPoint: HttpUrls.getUserTaskDateRange,
    ).then((value) {
      if (value.statusCode == 200) {
        if (isDateSubmitBtnClicked == true) {
          // Loader.stopLoader();
        }
        if ((value.data[0] != null) && (!value.data[0].isEmpty)) {
          result = value.data[0].reversed.toList();
        }
        print('XHECKINFGGG 12$result');

        return result;
      } else {
        return result;
      }
    });
    update(['date_picker_in']);

    return result;
  }

  getCalibrationTasks(
      {required DateTime startDate,
      required DateTime endDate,
      required bool isInitSate}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int customerId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    Map<String, dynamic> apiData = {
      "User_Details_Id_": customerId,
      'From_Date_': startDate,
      'To_Date_': endDate,
    };
    List result = [];

    await HttpRequest.httpGetRequest(
      bodyData: apiData,
      endPoint: HttpUrls.getUserTaskDateRangeCalibration,
    ).then((value) {
      if (value.statusCode == 200) {
        if (isDateSubmitBtnClicked == true) {
          // Loader.stopLoader();
        }
        if ((value.data[0] != null) && (!value.data[0].isEmpty)) {
          result = value.data[0].reversed.toList();
        }
      print('AJHBDHFI 123 $value');
      print('AJHBDHFI 1234 $result');

        return result;
      } else {
        return result;
      }
    });
    update(['date_picker_ca']);

    return result;
  }

  getTestEquipment({
    required int taskId,
    required int taskUserDetailsId,
  }) async {
    usedEquipmentData.clear();
    usedEquipmentDataCalibration.clear();

    // Loader.showLoader();

    await HttpRequest.httpGetRequest(
      bodyData: {
        "Task_Id_": taskId,
        "Equiptment_Name_": '',
        "User_Details_Id": homeController.isCalibrationSection.value
            ? taskUserDetailsCalibration[0]['Role_Id'].toString() == '38'
                ? taskUserDetailsCalibration[0]['User_Details_Id']
                : 0
            : taskUserDetails[0]['Role_Id'].toString() == '38'
                ? taskUserDetails[0]['User_Details_Id']
                : 0
      },
      endPoint: homeController.isCalibrationSection.value
          ? HttpUrls.getTestEquipmentCalibration
          : HttpUrls.getTestEquipment,
    ).then((value) {
      if (value.statusCode == 200) {
        // Loader.stopLoader();

        final data = value.data[0];
        if (homeController.isCalibrationSection.value) {
          usedTestEquipmentsCalibration =
              data.map((e) => UsedEquipmentList.fromJson(e)).toList();

          for (int i = 0; i < usedTestEquipmentsCalibration.length; i++) {
            usedEquipmentDataCalibration.add({
              'Is_Checkbox': usedTestEquipmentsCalibration[i].isCheckBox,
              "Test_Equiptment_Id":
                  usedTestEquipmentsCalibration[i].equipmentId,
              "Test_Equiptment_Name":
                  usedTestEquipmentsCalibration[i].equipmentName
            });
          }
          testEquipmentSearchResult = usedEquipmentDataCalibration;
        } else {
          usedTestEquipments =
              data.map((e) => UsedEquipmentList.fromJson(e)).toList();

          for (int i = 0; i < usedTestEquipments.length; i++) {
            usedEquipmentData.add({
              'Is_Checkbox': usedTestEquipments[i].isCheckBox,
              "Test_Equiptment_Id": usedTestEquipments[i].equipmentId,
              "Test_Equiptment_Name": usedTestEquipments[i].equipmentName
            });
          }
          testEquipmentSearchResult = usedEquipmentData;
        }

        // tcontoller.equipmentList = usedTestEquipmentData
        //     .map((e) => e.equipmentName.toString())
        //     .toList();
        // Get.to(() => const TrainingEquipmentScreen());

        // Get.to(()=>const UpcomingInspectionsScreen());
      } else {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(const SnackBar(content: Text('Server Error')));
      }
    });

    update(['equipment_list']);
  }

  getTestppe({
    required int taskId,
    required int taskUserDetailsId,
  }) async {
    usedTestppeData.clear();
    usedTestppeDataCalibration.clear();
    // Loader.showLoader();

    await HttpRequest.httpGetRequest(
      bodyData: {
        "Task_Id_": taskId,
        "Equiptment_Name_": '',
        "User_Details_Id": homeController.isCalibrationSection.value
            ? taskUserDetailsCalibration[0]['Role_Id'].toString() == '38'
                ? taskUserDetailsCalibration[0]['User_Details_Id']
                : 0
            : taskUserDetails[0]['Role_Id'].toString() == '38'
                ? taskUserDetails[0]['User_Details_Id']
                : 0
      },
      endPoint: homeController.isCalibrationSection.value
          ? HttpUrls.getTestppeCalibration
          : HttpUrls.getTestppe,
    ).then((value) {
      if (value.statusCode == 200) {
        final data = value.data[0];
        if (homeController.isCalibrationSection.value) {
          usedTestPpesCalibration =
              data.map((e) => UsedPpeListModel.fromJson(e)).toList();

          for (int i = 0; i < usedTestPpesCalibration.length; i++) {
            usedTestppeDataCalibration.add({
              'Is_Checkbox': usedTestPpesCalibration[i].isCheckBox,
              "Test_PPE_Id": usedTestPpesCalibration[i].equipmentId,
              "Test_PPE_Name": usedTestPpesCalibration[i].equipmentName
            });
          }
          testPpeSearchResult = usedTestppeDataCalibration;
        } else {
          usedTestPpes = data.map((e) => UsedPpeListModel.fromJson(e)).toList();

          for (int i = 0; i < usedTestPpes.length; i++) {
            usedTestppeData.add({
              'Is_Checkbox': usedTestPpes[i].isCheckBox,
              "Test_PPE_Id": usedTestPpes[i].equipmentId,
              "Test_PPE_Name": usedTestPpes[i].equipmentName
            });
          }
          testPpeSearchResult = usedTestppeData;
        }
        // tcontoller.equipmentList = usedTestEquipmentData
        //     .map((e) => e.equipmentName.toString())
        //     .toList();
        // Get.to(() => const TrainingEquipmentScreen());

        // Get.to(()=>const UpcomingInspectionsScreen());
      } else {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(const SnackBar(content: Text('Server Error')));
      }
    });
    update(['equipment_list']);
  }

  getTestDocument({
    required int taskId,
    required int taskUserDetailsId,
  }) async {
    usedTestDocumentData.clear();
    usedTestDocumentDataCalibration.clear();
    // Loader.showLoader();

    await HttpRequest.httpGetRequest(
      bodyData: {
        "Task_Id_": taskId,
        "Equiptment_Name_": '',
        "User_Details_Id": homeController.isCalibrationSection.value
            ? taskUserDetailsCalibration[0]['Role_Id'].toString() == '38'
                ? taskUserDetailsCalibration[0]['User_Details_Id']
                : 0
            : taskUserDetails[0]['Role_Id'].toString() == '38'
                ? taskUserDetails[0]['User_Details_Id']
                : 0
      },
      endPoint: homeController.isCalibrationSection.value
          ? HttpUrls.getTestDocumentCalibration
          : HttpUrls.getTestDocument,
    ).then((value) {
      if (value.statusCode == 200) {
        // Loader.stopLoader();
        // if (tcontoller.isTaskStarted.value == true) {
        // Loader.stopLoader();
        //   Get.to(() => const TrainingEquipmentScreen());
        // }

        final data = value.data[0];
        if (homeController.isCalibrationSection.value) {
          usedTestDocumentDataCalibration =
              data.map((e) => UsedDocumentListModel.fromJson(e)).toList();

          for (int i = 0; i < usedTestDocumentsCalibration.length; i++) {
            usedTestDocumentDataCalibration.add({
              'Is_Checkbox': usedTestDocumentsCalibration[i].isCheckBox,
              "Test_Document_Id": usedTestDocumentsCalibration[i].equipmentId,
              "Test_Document_Name":
                  usedTestDocumentsCalibration[i].equipmentName
            });
          }

          testDocumentSearchResult = usedTestDocumentDataCalibration;
        } else {
          usedTestDocuments =
              data.map((e) => UsedDocumentListModel.fromJson(e)).toList();

          for (int i = 0; i < usedTestDocuments.length; i++) {
            usedTestDocumentData.add({
              'Is_Checkbox': usedTestDocuments[i].isCheckBox,
              "Test_Document_Id": usedTestDocuments[i].equipmentId,
              "Test_Document_Name": usedTestDocuments[i].equipmentName
            });
          }

          testDocumentSearchResult = usedTestDocumentData;
        }
        // tcontoller.equipmentList = usedTestEquipmentData
        //     .map((e) => e.equipmentName.toString())
        //     .toList();

        // Get.to(()=>const UpcomingInspectionsScreen());
      } else {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(const SnackBar(content: Text('Server Error')));
      }
    });
    update(['equipment_list']);
  }

  // getTestppe({
  //   required int taskId,
  //   required int taskUserDetailsId,
  // }) async {
  //   // Loader.showLoader();

  //   print('send task id getTestEquipment $taskId');

  //   await HttpRequest.httpGetRequest(
  //     bodyData: {
  //       "Task_Id_": taskId,
  //       "Equiptment_Name_": '',
  //       "Task_user_details_id": taskUserDetailsId,
  //       "User_Details_Id": taskUserDetails[0]['Role_Id'].toString() == '38'
  //           ? taskUserDetails[0]['User_Details_Id']
  //           : ''
  //     },
  //     endPoint: HttpUrls.getTestppe,
  //   ).then((value) {
  //     print('customer test ppe $value');

  //     if (value.statusCode == 200) {
  //       // Loader.stopLoader();
  //       print(value.data[0]);
  //       final data = value.data[0];
  //       // usedTestEquipmentData =
  //       //     data.map((e) => UsedEquipmentList.fromJson(e)).toList();
  //       // print('used equipment $usedTestEquipmentData');
  //       // tcontoller.equipmentList = usedTestEquipmentData
  //       //     .map((e) => e.equipmentName.toString())
  //       //     .toList();
  //       // Get.to(() => TrainingEquipmentScreen());

  //       // Get.to(()=>const UpcomingInspectionsScreen());
  //     } else {
  //       ScaffoldMessenger.of(Get.context!)
  //           .showSnackBar(const SnackBar(content: Text('Server Error')));
  //     }
  //   });
  //   update();
  // }

  getUserTaskDetails(
      {required int taskId,
      bool isNotPageNavigation = false,
      String? status = 'Not Started'}) async {
    print('hiiihudeif 123');
    status ??= homeController.isCalibrationSection.value
        ? 'Not Attended'
        : 'Not Started';
    // tcontoller.periodicCheck.value = false;
    // tcontoller.visualCheck.value = false;
    // tcontoller.thoroughCheck.value = false;
    // tcontoller.majorCheck.value = false;
    taskDetailsData.clear();
    taskEquipmentListData.clear();
    taskUserDetails.clear();
    tcontoller.otherEqupmentNotecntrlr.clear();

    // Loader.showLoader();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int userId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    print('adeeb ${homeController.isCalibrationSection.value}');
    if (!homeController.isCalibrationSection.value) {
      print('hiiihudeif 1234 ${homeController.isCalibrationSection.value}');
      await HttpRequest.httpGetRequest(
        bodyData: {
          "Task_Id_": taskId,
          'User_Id_': userId,
        },
        endPoint: HttpUrls.getTaskDetails,
      ).then((value) {
        if (value.statusCode == 200) {
          // Loader.stopLoader();
          taskDetailsData = value.data[0];
          taskEquipmentListData = value.data[1];

          taskUserDetails = value.data[2];
          taskEquipmentListData.add({
            "Task_Equipment_Id": 0,
            "Equipment_Id": 0,
            "Equipment_Name": "Other",
            "Checked": taskUserDetails[0]['Others_Checked']
          });
          print('dfgerogthi i amhere $taskEquipmentListData');

          tcontoller.periodicCheck.value =
              bool.parse(taskUserDetails[0]['Periodic'] ?? 'false');
          tcontoller.independentCheck.value =
              bool.parse(taskUserDetails[0]['Independent'] ?? 'false');
          tcontoller.visualCheck.value =
              bool.parse(taskUserDetails[0]['Visual'] ?? 'false');
          tcontoller.thoroughCheck.value =
              bool.parse(taskUserDetails[0]['Thorough'] ?? 'false');
          tcontoller.majorCheck.value =
              bool.parse(taskUserDetails[0]['Major'] ?? 'false');
          tcontoller.examinationCheck.value =
              bool.parse(taskUserDetails[0]['Initial_Examination'] ?? 'false');
          tcontoller.inServiceCheck.value =
              bool.parse(taskUserDetails[0]['In_Service'] ?? 'false');

          if (taskEquipmentListData.last['Checked'].toString() == '1') {
            tcontoller.othersChecked.value = true;

            tcontoller.otherEqupmentNotecntrlr.text =
                taskUserDetails[0]['Notes'];
            tcontoller.update();
          } else {
            tcontoller.othersChecked.value = false;
          }

          tcontoller.commonGridTexts = [
            {
              "title": 'Task Date & Time',
              'sub_title': taskDetailsData[0]['Proposed_Date_Time1'] == null
                  ? ''
                  : taskDetailsData[0]['Proposed_Date_Time1'] ?? '',
              "icon": Icons.calendar_month,
            },
            {
              "title": 'Started Date & Time',
              'sub_title': taskUserDetails.isEmpty
                  ? ''
                  : taskUserDetails[0]['Actual_Start_Date_Time1'] == null
                      ? ''
                      : taskUserDetails[0]['Actual_Start_Date_Time1']
                          .toString()
                          .toLowerCase(),
              "icon": Icons.calendar_month,
            },
            {
              "title": 'Ended Date & Time',
              'sub_title': taskUserDetails[0]['Stop_Time1'] == null
                  ? ''
                  : taskUserDetails[0]['Stop_Time1'].toString().toLowerCase(),
              "icon": Icons.calendar_month,
            },

            {
              "title": 'Task Owner',
              'sub_title': taskUserDetails.isEmpty
                  ? ''
                  : taskUserDetails[0]['Lead_Name'] ?? '',
              "icon": Icons.person_4_outlined,
            },

            {
              "title": 'Contact Person',
              'sub_title': taskDetailsData[0]['Contact_person'] ?? '',
              "icon": Icons.person_2_outlined,
            },
            {
              "title": 'Contact No',
              'sub_title': taskDetailsData[0]['contact_number'] ?? '',
              "icon": Icons.phone,
            },
            {
              "title": 'Location',
              'sub_title': taskDetailsData[0]['Location_Name'] ?? '',
              "icon": Icons.location_on,
            },

            {
              "title": 'Equipment List',
              'sub_title': jsonEncode(taskEquipmentListData
                  .map((e) => e['Equipment_Name'].toString())
                  .toList()),
              "icon": Icons.settings_applications_outlined,
            },
            // {
            //   "title": 'Checker phone number ',
            //   'sub_title': taskUserDetails.isEmpty
            //       ? ''
            //       : taskUserDetails[0]['Mobile'] ?? '',
            //   "icon": Icons.phone_enabled_outlined,
            // },
            // {
            //   "title": 'Notes',
            //   'sub_title': taskUserDetails[0]['End_Notes'] ?? '',
            //   "icon": Icons.message,
            // },
          ];

          if (tcontoller.commonGridTexts.isNotEmpty) {
            tcontoller.isTaskStarted.value =
                taskUserDetails[0]['Task_Status_Id'].toString() == '4'
                    ? true
                    : false;

            if (!isNotPageNavigation) {
              Get.to(() => TrainningScreen());
            }
          }

          // Get.to(()=>const UpcomingInspectionsScreen());
        } else {
          ScaffoldMessenger.of(Get.context!)
              .showSnackBar(const SnackBar(content: Text('Server Error')));
        }
      });
    } else {
      print('hiiihudeif dfwriopf');
      await HttpRequest.httpGetRequest(
        bodyData: {
          "Task_Id_": taskId,
          'User_Id_': userId,
        },
        endPoint: HttpUrls.getTaskDetailsCalibration,
      ).then((value) {
        if (value.statusCode == 200) {
          // Loader.stopLoader();
          taskDetailsDataCalibration = value.data[0];
          taskEquipmentListDataCalibration = value.data[1];
          try {
            isOwner = value.data[2][0]['Is_Check_Owner'].toString() == "1";
          } catch (e) {}
          taskUserDetailsCalibration = value.data[2];
          taskEquipmentListDataCalibration.add({
            "Task_Equipment_Id": 0,
            "Equipment_Id": 0,
            "Equipment_Name": "Other",
            "Checked": taskUserDetailsCalibration[0]['Others_Checked']
          });
          print('dfgerogthi i amhere $taskEquipmentListDataCalibration');

          tcontoller.periodicCheck.value =
              bool.parse(taskUserDetailsCalibration[0]['Periodic'] ?? 'false');
          tcontoller.independentCheck.value = bool.parse(
              taskUserDetailsCalibration[0]['Independent'] ?? 'false');
          tcontoller.visualCheck.value =
              bool.parse(taskUserDetailsCalibration[0]['Visual'] ?? 'false');
          tcontoller.thoroughCheck.value =
              bool.parse(taskUserDetailsCalibration[0]['Thorough'] ?? 'false');
          tcontoller.majorCheck.value =
              bool.parse(taskUserDetailsCalibration[0]['Major'] ?? 'false');
          tcontoller.examinationCheck.value = bool.parse(
              taskUserDetailsCalibration[0]['Initial_Examination'] ?? 'false');
          tcontoller.inServiceCheck.value = bool.parse(
              taskUserDetailsCalibration[0]['In_Service'] ?? 'false');

          if (taskEquipmentListDataCalibration.last['Checked'].toString() ==
              '1') {
            tcontoller.othersChecked.value = true;

            tcontoller.otherEqupmentNotecntrlr.text =
                taskUserDetailsCalibration[0]['Notes'];
            tcontoller.update();
          } else {
            tcontoller.othersChecked.value = false;
          }

          tcontoller.commonGridTexts = [
            {
              "title": 'Task Date & Time',
              'sub_title': taskDetailsDataCalibration[0]
                          ['Proposed_Date_Time1'] ==
                      null
                  ? ''
                  : taskDetailsDataCalibration[0]['Proposed_Date_Time1'] ?? '',
              "icon": Icons.calendar_month,
            },
            {
              "title": 'Started Date & Time',
              'sub_title': taskUserDetailsCalibration.isEmpty
                  ? ''
                  : taskUserDetailsCalibration[0]['Actual_Start_Date_Time1'] ==
                          null
                      ? ''
                      : taskUserDetailsCalibration[0]
                              ['Actual_Start_Date_Time1']
                          .toString()
                          .toLowerCase(),
              "icon": Icons.calendar_month,
            },
            {
              "title": 'Ended Date & Time',
              'sub_title': taskUserDetailsCalibration[0]['Stop_Time1'] == null
                  ? ''
                  : taskUserDetailsCalibration[0]['Stop_Time1']
                      .toString()
                      .toLowerCase(),
              "icon": Icons.calendar_month,
            },

            {
              "title": 'Task Owner',
              'sub_title': taskUserDetailsCalibration.isEmpty
                  ? ''
                  : taskUserDetailsCalibration[0]['Lead_Name'] ?? '',
              "icon": Icons.person_4_outlined,
            },

            {
              "title": 'Contact Person',
              'sub_title':
                  taskDetailsDataCalibration[0]['Contact_person'] ?? '',
              "icon": Icons.person_2_outlined,
            },
            {
              "title": 'Contact No',
              'sub_title':
                  taskDetailsDataCalibration[0]['contact_number'] ?? '',
              "icon": Icons.phone,
            },
            {
              "title": 'Location',
              'sub_title':
                  taskDetailsDataCalibration[0]['Location_Name'] ?? '',
              "icon": Icons.location_on,
            },

            {
              "title": 'Equipment List',
              'sub_title': jsonEncode(taskEquipmentListData
                  .map((e) => e['Equipment_Name'].toString())
                  .toList()),
              "icon": Icons.settings_applications_outlined,
            },
            // {
            //   "title": 'Checker phone number ',
            //   'sub_title': taskUserDetails.isEmpty
            //       ? ''
            //       : taskUserDetails[0]['Mobile'] ?? '',
            //   "icon": Icons.phone_enabled_outlined,
            // },
            // {
            //   "title": 'Notes',
            //   'sub_title': taskUserDetails[0]['End_Notes'] ?? '',
            //   "icon": Icons.message,
            // },
          ];

          if (tcontoller.commonGridTexts.isNotEmpty) {
            tcontoller.isTaskStarted.value =
                taskUserDetailsCalibration[0]['Task_Status_Id'].toString() ==
                        '14'
                    ? true
                    : false;

            if (!isNotPageNavigation) {
              print('rferetrver $status');

              if (status == 'In Progress') {
                Get.to(() => RiskAssesmentStopScreen(
                    taskId: taskId, taskStatusName: status ?? ''));
              } else {
                Get.to(() => TrainningScreen());
              }
            }
          }

          // Get.to(()=>const UpcomingInspectionsScreen());
        } else {
          ScaffoldMessenger.of(Get.context!)
              .showSnackBar(const SnackBar(content: Text('Server Error')));
        }
      });
    }
    tcontoller.update();
    isScreenLoading.value=false;
    update();
  }

  saveTaskUserStart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int userId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    final sendEqpListData = homeController.isCalibrationSection.value
        ? upcomingInspectionsController.taskEquipmentListDataCalibration
        : upcomingInspectionsController.taskEquipmentListData;

    Loader.showLoader();
    String dateTimeString = '';
    final dio = Dio();
    try {
      final response = await dio.get('http://worldtimeapi.org/api/ip');
      if (response.statusCode == 200) {
        Loader.stopLoader();
        final data = response.data as Map<String, dynamic>;
        dateTimeString = data['datetime'];

        final time = data['datetime'].toString().split('T')[1].split('.')[0];
        print('Current time: $time');
      } else {
        Loader.stopLoader();
        print('Failed to fetch time');
      }
    } catch (e) {
      print('Error: $e');
    }
    print('before   $sendEqpListData');
    sendEqpListData.removeWhere(
        (element) => element['Task_Equipment_Id'].toString() == '0');

    print('sdfwekjhfiluwek ${dateTimeString.isEmpty}');
    //  await sendEqpListData.removeLast();
    if (homeController.isCalibrationSection.value) {
      await HttpRequest.httpPostBodyRequest(
        bodyData: {
          "Task_User_Details_Id_": int.parse(
              homeController.isCalibrationSection.value
                  ? taskUserDetailsCalibration[0]['Task_User_Details_Id']
                      .toString()
                  : taskUserDetails[0]['Task_User_Details_Id'].toString()),

          "Task_Id_": int.parse(homeController.isCalibrationSection.value
              ? taskDetailsDataCalibration[0]['Task_Id'].toString()
              : taskDetailsData[0]['Task_Id'].toString()),
          'Start_Notes_': tcontoller.addNoteController.text,
          'Periodic': tcontoller.periodicCheck.value.toString(),
          'Visual': tcontoller.visualCheck.value.toString(),
          'Thorough': tcontoller.thoroughCheck.value.toString(),
          'Major': tcontoller.majorCheck.value.toString(),
          'Initial_Examination': tcontoller.examinationCheck.value.toString(),
          "In_Service": tcontoller.inServiceCheck.value.toString(),
          "Independent": tcontoller.independentCheck.value.toString(),
          // "Start_Date_Time": dateTimeString.isEmpty
          //     ? DateTime.now()
          //     : DateTime.parse(dateTimeString.split('.')[0].toString()),
          "Notes": tcontoller.otherEqupmentNotecntrlr.text,
          "Others_Checked":
              tcontoller.otherEqupmentNotecntrlr.text.isEmpty ? 0 : 1,
          "Equipments": sendEqpListData,
          "User_Id": userId,
        },
        endPoint: homeController.isCalibrationSection.value
            ? HttpUrls.saveTaskDetailsCalibration
            : HttpUrls.saveTaskDetails,
      ).then((value) async {
        print('adeeb 12334 $value');
        if (value != null) {
          if (value.statusCode == 200) {
            // tcontoller.addNoteController.clear();
            // tcontoller.otherEqupmentNotecntrlr.clear();

            tcontoller.isTaskStarted.value =
                value.data[0][0]['Task_Status_Id_'].toString() == '4'
                    ? true
                    : false;
            // riskAssessmentController.startedDateTime=value.data[0][0]['Actual_Start_Date_Time_'];
            // await getTestEquipment(
            //   taskUserDetailsId: upcomingInspectionsController.taskUserDetails[0]
            //       ['Task_User_Details_Id'],
            //   taskId: upcomingInspectionsController.taskDetailsData[0]['Task_Id'],
            // );
            // await upcomingInspectionsController.getTestppe(
            //   taskUserDetailsId: upcomingInspectionsController.taskUserDetails[0]
            //       ['Task_User_Details_Id'],
            //   taskId: upcomingInspectionsController.taskDetailsData[0]['Task_Id'],
            // );
            // await upcomingInspectionsController.getTestDocument(
            //   taskUserDetailsId: upcomingInspectionsController.taskUserDetails[0]
            //       ['Task_User_Details_Id'],
            //   taskId: upcomingInspectionsController.taskDetailsData[0]['Task_Id'],
            // );

            tcontoller.loadTaskStatus();

            if (!homeController.isCalibrationSection.value &&
                upcomingInspectionsController.taskUserDetails[0]['Role_Id']
                        .toString() ==
                    '38') {
              // await Loader.stopLoader();

              await upcomingInspectionsController.getTestEquipment(
                taskUserDetailsId: upcomingInspectionsController
                    .taskUserDetails[0]['Task_User_Details_Id'],
                taskId: upcomingInspectionsController.taskDetailsData[0]
                    ['Task_Id'],
              );
              await upcomingInspectionsController.getTestppe(
                taskUserDetailsId: upcomingInspectionsController
                    .taskUserDetails[0]['Task_User_Details_Id'],
                taskId: upcomingInspectionsController.taskDetailsData[0]
                    ['Task_Id'],
              );
              await upcomingInspectionsController.getTestDocument(
                taskUserDetailsId: upcomingInspectionsController
                    .taskUserDetails[0]['Task_User_Details_Id'],
                taskId: upcomingInspectionsController.taskDetailsData[0]
                    ['Task_Id'],
              );
              Loader.stopLoader();

              Get.to(() => TrainingEquipmentScreen(
                    taskId: int.parse(taskDetailsData[0]['Task_Id'].toString()),
                  ));
            } else {
              Loader.stopLoader();

              // await Loader.stopLoader();
              Get.to(() => const RiskAssesmentStopScreen());
            }
            // if (!homeController.isCalibrationSection.value &&
            //     upcomingInspectionsController.taskUserDetails[0]
            //                 ['Role_Id']
            //             .toString() ==
            //         '38') {
            //   // await Loader.stopLoader();

            //   await upcomingInspectionsController.getTestEquipment(
            //     taskUserDetailsId: upcomingInspectionsController
            //         .taskUserDetailsCalibration[0]['Task_User_Details_Id'],
            //     taskId: upcomingInspectionsController
            //         .taskDetailsDataCalibration[0]['Task_Id'],
            //   );
            //   await upcomingInspectionsController.getTestppe(
            //     taskUserDetailsId: upcomingInspectionsController
            //         .taskDetailsDataCalibration[0]['Task_User_Details_Id'],
            //     taskId: upcomingInspectionsController
            //         .taskDetailsDataCalibration[0]['Task_Id'],
            //   );
            //   await upcomingInspectionsController.getTestDocument(
            //     taskUserDetailsId: upcomingInspectionsController
            //         .taskUserDetailsCalibration[0]['Task_User_Details_Id'],
            //     taskId: upcomingInspectionsController
            //         .taskDetailsDataCalibration[0]['Task_Id'],
            //   );

            //   Get.to(() => TrainingEquipmentScreen(
            //         taskId: int.parse(
            //             taskDetailsDataCalibration[0]['Task_Id'].toString()),
            //       ));
            // } else {
            //   // await Loader.stopLoader();
            //   Get.to(() => const RiskAssesmentStopScreen());
            // }

            // Get.to(()=>TrainningScreen());
            // Get.to(() => RiskAssessmentScreen());
          } else {
            Loader.stopLoader();

            // ScaffoldMessenger.of(Get.context!)
            //     .showSnackBar(const SnackBar(content: Text('Server Error')));
          }
        } else {
          Loader.stopLoader();

          ScaffoldMessenger.of(Get.context!)
              .showSnackBar(const SnackBar(content: Text('Server Error')));
        }
      });
    } else {
      await HttpRequest.httpPostRequest(
        bodyData: {
          "Task_User_Details_Id_": int.parse(
              homeController.isCalibrationSection.value
                  ? taskUserDetailsCalibration[0]['Task_User_Details_Id']
                      .toString()
                  : taskUserDetails[0]['Task_User_Details_Id'].toString()),
          "Task_Id_": int.parse(homeController.isCalibrationSection.value
              ? taskDetailsDataCalibration[0]['Task_Id'].toString()
              : taskDetailsData[0]['Task_Id'].toString()),
          'Start_Notes_': tcontoller.addNoteController.text,
          'Periodic': tcontoller.periodicCheck.value.toString(),
          'Visual': tcontoller.visualCheck.value.toString(),
          'Thorough': tcontoller.thoroughCheck.value.toString(),
          'Major': tcontoller.majorCheck.value.toString(),
          'Initial_Examination': tcontoller.examinationCheck.value.toString(),
          "In_Service": tcontoller.inServiceCheck.value.toString(),
          "Independent": tcontoller.independentCheck.value.toString(),
          // "Start_Date_Time": dateTimeString.isEmpty
          //     ? DateTime.now()
          //     : DateTime.parse(dateTimeString.split('.')[0].toString()),
          "Notes": tcontoller.otherEqupmentNotecntrlr.text,
          "Others_Checked":
              tcontoller.otherEqupmentNotecntrlr.text.isEmpty ? 0 : 1,
          "Equipments": sendEqpListData,
          "User_Id": userId,
        },
        endPoint: homeController.isCalibrationSection.value
            ? HttpUrls.saveTaskDetailsCalibration
            : HttpUrls.saveTaskDetails,
      ).then((value) async {
        print('adeeb 12334 $value');
        if (value != null) {
          if (value.statusCode == 200) {
            // tcontoller.addNoteController.clear();
            // tcontoller.otherEqupmentNotecntrlr.clear();

            print(
                'equipment list ${upcomingInspectionsController.taskEquipmentListData}');

            tcontoller.isTaskStarted.value =
                value.data[0][0]['Task_Status_Id_'].toString() == '4'
                    ? true
                    : false;
            // await getTestEquipment(
            //   taskUserDetailsId: upcomingInspectionsController.taskUserDetails[0]
            //       ['Task_User_Details_Id'],
            //   taskId: upcomingInspectionsController.taskDetailsData[0]['Task_Id'],
            // );
            // await upcomingInspectionsController.getTestppe(
            //   taskUserDetailsId: upcomingInspectionsController.taskUserDetails[0]
            //       ['Task_User_Details_Id'],
            //   taskId: upcomingInspectionsController.taskDetailsData[0]['Task_Id'],
            // );
            // await upcomingInspectionsController.getTestDocument(
            //   taskUserDetailsId: upcomingInspectionsController.taskUserDetails[0]
            //       ['Task_User_Details_Id'],
            //   taskId: upcomingInspectionsController.taskDetailsData[0]['Task_Id'],
            // );

            tcontoller.loadTaskStatus();

            if (!homeController.isCalibrationSection.value &&
                upcomingInspectionsController.taskUserDetails[0]['Role_Id']
                        .toString() ==
                    '38') {
              // await Loader.stopLoader();

              await upcomingInspectionsController.getTestEquipment(
                taskUserDetailsId: upcomingInspectionsController
                    .taskUserDetails[0]['Task_User_Details_Id'],
                taskId: upcomingInspectionsController.taskDetailsData[0]
                    ['Task_Id'],
              );
              await upcomingInspectionsController.getTestppe(
                taskUserDetailsId: upcomingInspectionsController
                    .taskUserDetails[0]['Task_User_Details_Id'],
                taskId: upcomingInspectionsController.taskDetailsData[0]
                    ['Task_Id'],
              );
              await upcomingInspectionsController.getTestDocument(
                taskUserDetailsId: upcomingInspectionsController
                    .taskUserDetails[0]['Task_User_Details_Id'],
                taskId: upcomingInspectionsController.taskDetailsData[0]
                    ['Task_Id'],
              );
              Loader.stopLoader();

              Get.to(() => TrainingEquipmentScreen(
                    taskId: int.parse(taskDetailsData[0]['Task_Id'].toString()),
                  ));
            } else {
              Loader.stopLoader();

              // await Loader.stopLoader();
              Get.to(() => const RiskAssesmentStopScreen());
            }
            // if (!homeController.isCalibrationSection.value &&
            //     upcomingInspectionsController.taskUserDetails[0]
            //                 ['Role_Id']
            //             .toString() ==
            //         '38') {
            //   // await Loader.stopLoader();

            //   await upcomingInspectionsController.getTestEquipment(
            //     taskUserDetailsId: upcomingInspectionsController
            //         .taskUserDetailsCalibration[0]['Task_User_Details_Id'],
            //     taskId: upcomingInspectionsController
            //         .taskDetailsDataCalibration[0]['Task_Id'],
            //   );
            //   await upcomingInspectionsController.getTestppe(
            //     taskUserDetailsId: upcomingInspectionsController
            //         .taskDetailsDataCalibration[0]['Task_User_Details_Id'],
            //     taskId: upcomingInspectionsController
            //         .taskDetailsDataCalibration[0]['Task_Id'],
            //   );
            //   await upcomingInspectionsController.getTestDocument(
            //     taskUserDetailsId: upcomingInspectionsController
            //         .taskUserDetailsCalibration[0]['Task_User_Details_Id'],
            //     taskId: upcomingInspectionsController
            //         .taskDetailsDataCalibration[0]['Task_Id'],
            //   );

            //   Get.to(() => TrainingEquipmentScreen(
            //         taskId: int.parse(
            //             taskDetailsDataCalibration[0]['Task_Id'].toString()),
            //       ));
            // } else {
            //   // await Loader.stopLoader();
            //   Get.to(() => const RiskAssesmentStopScreen());
            // }

            // Get.to(()=>TrainningScreen());
            // Get.to(() => RiskAssessmentScreen());
          } else {
            Loader.stopLoader();

            // ScaffoldMessenger.of(Get.context!)
            //     .showSnackBar(const SnackBar(content: Text('Server Error')));
          }
        } else {
          Loader.stopLoader();

          ScaffoldMessenger.of(Get.context!)
              .showSnackBar(const SnackBar(content: Text('Server Error')));
        }
      });
    }

    // update();
  }

  equipmentSearch(
      {required String value,
      required List mainList,
      required String nameKey,
      required searchResultList}) {
    searchResultList = mainList
        .where((element) => element[nameKey]
            .toString()
            .toLowerCase()
            .removeAllWhitespace
            .startsWith(value.toLowerCase().removeAllWhitespace))
        .toList();
    update();
    return searchResultList;
  }

  saveTaskTest({required context}) async {
    final Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // int userId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    Map<String, dynamic> sendSaveTaskTestData = {
      "Task_Id_": int.parse(taskDetailsData[0]['Task_Id'].toString()),
      "User_Details_Id_":
          int.parse(taskUserDetails[0]['User_Details_Id'].toString()),
      "Test_Equipment_":
          usedEquipmentData.where((e) => e['Is_Checkbox'] == true).toList(),
      "Test_PPE_":
          usedTestppeData.where((e) => e['Is_Checkbox'] == true).toList(),
      "Test_Document_":
          usedTestDocumentData.where((e) => e['Is_Checkbox'] == true).toList(),
    };

    await dio
        .post(
      '${HttpUrls.baseUrl}${HttpUrls.saveTaskTest}',
      options: Options(headers: {
        'ngrok-skip-browser-warning': 'true',
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      }),
      data: sendSaveTaskTestData,
    )
        .then((value) {
      if (value.statusCode == 200) {
        if (value.data['0'][0].isNotEmpty) {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.to(() => const RiskAssessmentScreen());
          // });
        }
      }
    });
  }
}
