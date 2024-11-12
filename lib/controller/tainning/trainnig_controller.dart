import 'dart:math';

import 'package:darlsco/controller/upcoming_inspections/upcoming_inspection_controller.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/widgets/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../http/http_request.dart';
import '../../http/http_urls.dart';

final TrainingController tcontoller = Get.put(TrainingController());

class SnackbarGlobal {
  static GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void show(String message) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class TrainingController extends GetxController {
  // @override
  // void onReady() {
  //   // TODO: implement onReady
  //   tcontoller.addNoteController.clear();
  //   super.onReady();
  // }

  // final activityStreamController = StreamController<Activity>();
  // final geofenceStreamController = StreamController<Geofence>();

  final TextEditingController addNoteController = TextEditingController();
  TextEditingController stopScreenTextController = TextEditingController();
  final TextEditingController stopScreenFinishTextController =
      TextEditingController();
  final TextEditingController otherEqupmentNotecntrlr = TextEditingController();

  List selectedEquipmentList = [];
  RxDouble grandTotal = 0.00.obs;
  RxString totalvat = ''.obs;
  RxString cardNumber = ''.obs;
  RxString orderNo = ''.obs;
  RxBool isPaymentSuccessful = false.obs;
  RxBool isTraineeAdded = false.obs;
  RxBool isRescheduled = false.obs;

  double totalPrice = 00008.00;
  double coursePrice = 0.00;
  double subTotal = 0.00;

  double totalVat = 0.00;
  double serviceCharge = 0.00;
  double servicePercentage = 0.00;

  RxInt quantity = 1.obs;
  RxInt homeQuatity = 1.obs;

  RxDouble applicationFeesDouble = 0.00.obs;

  RxBool equipmentValidationStop = false.obs;
  RxBool finishNoteValidationStop = false.obs;

  RxBool isRetake = false.obs;
  RxBool isPurchase = false.obs;

  RxBool visualCheck = false.obs;
  RxBool periodicCheck = false.obs;
  RxBool thoroughCheck = false.obs;
  RxBool examinationCheck = false.obs;

  RxBool inServiceCheck = false.obs;
  RxBool independentCheck = false.obs;

  RxBool majorCheck = false.obs;
  RxBool othersChecked = false.obs;

  RxString selectedStatusValue = ''.obs;
  List taskStatusList = [].obs;

  List<Map<String, dynamic>> commonGridTexts = [];
  RxBool isTaskStarted = false.obs;
  RxInt cartQuantity = 0.obs;
  RxList cartQuantityList = [].obs;

  List<String> equipmentList = [
    'Psychrometer',
    'Vernier Caliper',
    'Measuring Tape',
    'Laser Distance Meter',
    'Spirit Level Indicator',
    'Protractor',
    'Welding Gauge',
    'Digital Multimeter',
    'Digital Clamp Meter',
    'Multifunction Tester',
    'Load Cell',
    'Force Gauge',
    'Anemo Meter',
    'Tacho Meter',
    'Flash Light',
    'Hardness Tester',
    'Ultrasonic Thickness gauge',
    'NonContact Voltage Tester',
    'Digital Battery Tester',
    'Hand Pump',
    'Test Weight',
    'NDT',
    'PT',
    'MT',
    'UT-UFD',
    'PMI',
    'ET',
    'IRT',
    'others',
  ];
  List<String> listPPE = [
    'Coverall',
    'Safety Goggles',
    'Safety Harness',
    'Visibility Vest',
    'Helmet',
    'Safety Shoes',
    'Gloves',
    'others',
  ];
  List<String> listDocument = [
    'Manufacturer\'s manual / Operations manual for the respective equipment',
    'Maintenance records ',
    'Previous inspection records',
    'Load Chart ',
    'Operator\'s training records ',
    'Foundation and support certificate & Pre-erection certificate',
    'NDT records if any',
    'Acknowledgement in site visit time sheet & test report (submit a copy of both to the customer)',
    'Other'
  ];

  List getAllStaffStatus = [];
  RxInt initialIndex = 0.obs;

  searchEquipment() {
    final data = equipmentList
        .where((element) => element.toString().toLowerCase().startsWith('p'))
        .toList();
    equipmentList.insertAll(0, data);
    print(equipmentList);
    update();
  }

  loadTaskStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int userId = int.parse(sharedPreferences.getString('darlsco_id') ?? '0');

    // Loader.showLoader();
    await HttpRequest.httpGetRequest(
      bodyData: {
        "Role_Id": homeController.isCalibrationSection.value
            ? int.parse(upcomingInspectionsController
                .taskUserDetailsCalibration[0]['Role_Id']
                .toString())
            : int.parse(upcomingInspectionsController.taskUserDetails[0]
                    ['Role_Id']
                .toString()),
        "Task_Id": homeController.isCalibrationSection.value
            ? int.parse(upcomingInspectionsController
                .taskDetailsDataCalibration[0]['Task_Id']
                .toString())
            : int.parse(upcomingInspectionsController.taskDetailsData[0]
                    ['Task_Id']
                .toString()),
        "User_Id": userId,
      },
      endPoint: HttpUrls.loadTaskStatusApp,
    ).then((value) {
      if (value.data != null) {
        print(value);

        taskStatusList = !homeController.isCalibrationSection.value
            ? value.data[0]
            : value.data[3];
        upcomingInspectionsController.equipmentStatusLIst = value.data[1];

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

    upcomingInspectionsController.update();

    update();
  }

  var dateAndTime = [];

  getAllUserTaskStatus() async {
    if (homeController.isCalibrationSection.value) {
      dateAndTime = [
        {
          "title": 'Task Date & Time',
          'sub_title': upcomingInspectionsController
                      .taskDetailsDataCalibration[0]['Proposed_Date_Time1'] ==
                  null
              ? ''
              : upcomingInspectionsController.taskDetailsDataCalibration[0]
                      ['Proposed_Date_Time1'] ??
                  '',
          "icon": Icons.calendar_month,
        },
        {
          "title": 'Started Date & Time',
          'sub_title': upcomingInspectionsController
                  .taskUserDetailsCalibration.isEmpty
              ? ''
              : upcomingInspectionsController.taskUserDetailsCalibration[0]
                          ['Actual_Start_Date_Time1'] ==
                      null
                  ? ''
                  : upcomingInspectionsController
                      .taskUserDetailsCalibration[0]
                          ['Actual_Start_Date_Time1']
                      .toString()
                      .toLowerCase(),
          "icon": Icons.calendar_month,
        },
      ];
    }
    await HttpRequest.httpGetRequest(
      endPoint:
          '${homeController.isCalibrationSection.value ? HttpUrls.getAllUserTaskStatusCalibration : HttpUrls.getAllUserTaskStatus}${homeController.isCalibrationSection.value ? int.parse(upcomingInspectionsController.taskDetailsDataCalibration[0]['Task_Id'].toString()) : int.parse(upcomingInspectionsController.taskDetailsData[0]['Task_Id'].toString())}',
    ).then((value) {
      print('all status $value');
      if (value.data != null) {
        getAllStaffStatus = value.data[0];
        print(getAllStaffStatus);
      }
    });
    upcomingInspectionsController.update();
    update();
  }

  // List<Geofence> geofenceList = <Geofence>[
  //   Geofence(
  //     id: 'place_1',
  //     latitude:
  //      upcomingInspectionsController.taskDetailsData.isEmpty?
  //     10.005548201562277:
  //     double.parse(upcomingInspectionsController.taskDetailsData[0]
  //             ['Latitude']
  //         .toString()),
  //     longitude: upcomingInspectionsController.taskDetailsData.isEmpty?
  //     76.37540812327876:
  //      double.parse(upcomingInspectionsController.taskDetailsData[0]
  //             ['Longitude']
  //         .toString()),
  //         //10.005548201562277, 76.37540812327876
  //     radius: [
  //       GeofenceRadius(id: 'radius_100m', length: 100),
  //       GeofenceRadius(id: 'radius_25m', length: 25),
  //       GeofenceRadius(id: 'radius_250m', length: 250),
  //       GeofenceRadius(id: 'radius_200m', length: 200),
  //     ],
  //   )
  // ];

  checkIsTaskStarted() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    tcontoller.isTaskStarted.value =
        sharedPreferences.getBool('is_task_started') ?? false;
  }

  geofenceLocation(
      {required double fenceLatitude, required double fenceLongitude}) async {
    if (!kIsWeb) {
      await Loader.showLoader();
      PermissionStatus locationStatus = await Permission.location.status;

      print(locationStatus.isPermanentlyDenied);
      if (locationStatus.isDenied) {
        locationStatus = await Permission.location.request();

        print(locationStatus);
      }

      if (locationStatus.isPermanentlyDenied) {
        await openAppSettings();
      }

      if (!locationStatus.isDenied) {
        try {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);

          double distance = Geolocator.distanceBetween(position.latitude,
              position.longitude, fenceLatitude, fenceLongitude);
          var d = acos(sin(position.latitude) * sin(fenceLatitude) +
                  cos(position.latitude) *
                      cos(fenceLatitude) *
                      cos(fenceLongitude - position.longitude)) *
              6371;

          print('DISTANCE $d');
          if (d != 500) {
            await Loader.stopLoader();
            return 'inside';
          } else {
            await Loader.stopLoader();
            return 'outside';
          }
        } catch (e) {
          await Loader.stopLoader();
          print('Error: $e');
        }
      }
    }
  }

  // final geofenceService = GeofenceService.instance.setup(
  //     interval: 5000,
  //     accuracy: 100,
  //     loiteringDelayMs: 6000,
  //     statusChangeDelayMs: 100,
  //     useActivityRecognition: true,
  //     allowMockLocations: true,
  //     printDevLog: true,
  //     geofenceRadiusSortType: GeofenceRadiusSortType.DESC);

  // Future<void> onGeofenceStatusChanged(
  //     Geofence geofence,
  //     GeofenceRadius geofenceRadius,
  //     GeofenceStatus geofenceStatus,
  //     Location location) async {
  //   print('geofence: ${geofence.toJson()}');
  //   print('geofenceRadius: ${geofenceRadius.toJson()}');
  //   print('geofenceRadius: ${location.toJson()}');

  //   print('geofenceStatus: ${geofenceStatus.toString()}');
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   // int userId = int.parse(sharedPreferences.getString('id') ?? '');

  //   if (geofenceStatus == GeofenceStatus.ENTER) {
  //     geofenceService.stop();
  //     if (upcomingInspectionsController.taskUserDetails[0]['Role_Id']
  //             .toString() ==
  //         '38') {
  //       geofenceService.stop();

  //       await upcomingInspectionsController.saveTaskUserStart();

  //       print('admin');
  //       // Get.to(() => const TrainingEquipmentScreen());
  //     } else {
  //       geofenceService.stop();
  //       await upcomingInspectionsController.saveTaskUserStart();
  //     }

  // upcomingInspectionsController.saveTaskUserStart();

  // SnackBar snackBar=const SnackBar(content: Text('user entered'),duration:Duration(seconds: 2) ,);
// Get.to(()=>const  TrainingEquipmentScreen());
  // await showDialog(
  //     barrierDismissible: true,
  //     context: Get.context!,
  //     builder: (ctx) => Center(
  //             child: Container(
  //           width: 250.w,
  //           height: 250.h,
  //           color: Colors.white,
  //           child: Center(
  //             child: Text(
  //               'User Entered',
  //               style:
  //                   TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //         )));

//     }
  //   } else {
  //     geofenceService.stop();

  //     ScaffoldMessenger.of(Get.context!)
  //         .showSnackBar(SnackBar(content: Text('Not Entered ')));
  //   }
  //   // update();

  //   // _geofenceStreamController.sink.add(geofence);
  // }

  // void onLocationChanged(Location location) {
  //   print('location: ${location.toJson()}');
  // }

  // void onActivityChanged(Activity prevActivity, Activity currActivity) {
  //   print('prevActivity: ${prevActivity.toJson()}');
  //   print('currActivity: ${currActivity.toJson()}');

  //   activityStreamController.sink.add(currActivity);
  // }

  // void onLocationServicesStatusChanged(bool status) {
  //   print('isLocationServicesEnabled: $status');
  // }

  // void onError(error) {
  //   final errorCode = getErrorCodesFromError(error);
  //   if (errorCode == null) {
  //     print('Undefined error: $error');
  //     return;
  //   }

  //   print('ErrorCode: $errorCode');
  // }
}
