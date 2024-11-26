import 'dart:convert';
import 'dart:io';

import 'package:darlsco/controller/dashboard/dashboard_controller.dart';
import 'package:darlsco/controller/home/home_controller.dart';

import 'package:darlsco/http/http_request.dart';
import 'package:darlsco/http/http_urls.dart';
import 'package:darlsco/model/login/login_model.dart';
import 'package:darlsco/notification.dart';
import 'package:darlsco/view/login/otp_screen.dart';
import 'package:darlsco/view/training/widgets/bottom_navigation_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../model/login/login_otp_model.dart';
import '../../view/home/bottom_navigation_screen.dart';
import '../../view/training/profile_page.dart';
import '../../view/training/training_inspection_screen.dart';
import '../tainning/trainnig_controller.dart';

final LoginController loginController = Get.put(LoginController());

class LoginController extends GetxController {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController pinPutOtpController = TextEditingController();
  RxBool isLoading = false.obs;
  LoginOtpModel? userData;
  bool isFromSplashOrLogin = false;
  List<String> companyLocationList = [
    'Dubai',
    'Abu Dhabi',
    'Sharjah',
  ];
  List<String> companyEquipmentList = [
    '25 Equipments',
    '8 Equipments',
    '8 Equipments',
  ];
  LoginModel? loginData;

  RxString countryCode = ''.obs;

  // void agentLogin() async {
  //   await HttpRequest.httpGetRequest(
  //           endPoint: HttpUrls.agentLogin,
  //           bodyData: {"email": "9544694354", "password": 1})
  //       .then((value) => print(value.statusCode));
  // }

  getOtp({required String mobileNumber, required context}) async {
    //  await  getcountry();
    // Loader.showLoader();
    await HttpRequest.httpGetRequest(
            endPoint: HttpUrls.getOtp,
            bodyData: {"phone": mobileNumber, "Country_Code": loginController.countryCode.isEmpty ? homeController.currentCountryCode.value : loginController.countryCode.value})
        .then((value) {
      if (value.statusCode == 200) {
        // Loader.stopLoader();
        if (jsonDecode(value.toString())['Data'].isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mobile no not found, please contact Darlsco team.')));
        } else {
          final data = jsonDecode(value.toString());

          loginData = LoginModel.fromJson(data['Data'][0]);

          dashboardController.dashboardRole = loginData?.customerType;

          if (loginData != null) {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Otp: ${loginData!.customerOtp}')));
          }

          Get.to(() => const OtpScreen());
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Server Error')));
      }
    });
  }

  // void getStaffOtp({required String mobileNumber, required context}) async {
  //   // Loader.showLoader();
  //   await HttpRequest.httpGetRequest(endPoint: HttpUrls.getOtp, bodyData: {
  //     "phone": mobileNumber,
  //     "Country_Code": loginController.countryCode.isEmpty
  //         ? homeController.currentCountryCode.value
  //         : loginController.countryCode.value
  //   }).then((value) {
  //     if (value.statusCode == 200) {
  //       // Loader.stopLoader();
  //       if (jsonDecode(value.toString())['Data'].isEmpty) {
  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //             content:
  //                 Text('Mobile no not found, please contact Darlsco team.')));
  //       } else {
  //         final data = jsonDecode(value.toString());

  //         loginData = LoginModel.fromJson(data['Data'][0]);

  //         dashboardController.dashboardRole = loginData?.customerType;

  //         if (loginData != null) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Otp: ${loginData!.customerOtp}')));
  //         }

  //         Get.to(() => const StaffOtpScreen());
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(content: Text('Server Error')));
  //     }
  //   });
  // }

  void agentLogin({
    required String otp,
    required context,
    required String phNo,
  }) async {
    // Loader.showLoader();
    isFromSplashOrLogin = true;
    isLoading.value = true;
    homeController.isInspectionSection.value = false;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String firebaseToken = '';
    try {
      homeController.messagingToken = FirebaseMessaging.instance;
      firebaseToken = await homeController.messagingToken.getToken() ?? '';
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;

      if (kDebugMode) {
        print(e);
      }
    }

    // print('firbase login token $firebaseToken');
    print('kbhhubhu ${homeController.isFromPurchase.value}');
    await HttpRequest.httpGetRequest(endPoint: homeController.isFromPurchase.value ? HttpUrls.agentLoginTraining : HttpUrls.agentLogin, bodyData: {
      "phone": phNo,
      "otp": otp,
      "Device_Id": firebaseToken,
      "Country_Code": loginController.countryCode.isEmpty ? homeController.currentCountryCode.value : loginController.countryCode.value
    }).then((value) async {
      if (value.statusCode == 200) {
        // Loader.stopLoader();
        final data = jsonDecode(value.toString());

        if (data['0'][0]['Id'].toString() == '0') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect OTP entered!')));
          pinPutOtpController.clear();
        } else {
          userData = LoginOtpModel.fromJson(data['0'][0]);
          preferences.setString('token', '${data['token']}');
          //    preferences.setString('token', '${data['token']}');
          preferences.setString('darlsco_id', data['0'][0]['Id'].toString());
          preferences.setString('type', data['0'][0]['tp'].toString());
          preferences.setString('phone_no', data['0'][0]["Mobile"].toString());

          // preferences.setString('name_user_', data['0'][0]['Name'].toString());
          //   preferences.setString('token', '${data['token']}');
          preferences.setString('calibration_login', data['0'][0]['Calibration'].toString());
          preferences.setString('trainee_login', data['0'][0]['Training'].toString());
          preferences.setString('inspection_login', data['0'][0]['Inspection'].toString());
          // TODO:NEED TO STORE LOCALLY
          homeController.isInspection.value = data['0'][0]['Inspection'].toString();
          homeController.isTraineee.value = data['0'][0]['Training'].toString();
          homeController.isInspectionSection.value =
              data['0'][0]['Inspection'] == '1';
          homeController.isTrainingSectionnew.value =
              data['0'][0]['Training'] == '1';
          homeController.isCalibrationSection.value =
              data['0'][0]['Calibration'] == '1';
          print('dfnsdefwe ${homeController.isTrainingSectionnew.value}');

          //     if (isFromSplashOrLogin) {
          //         homeController.isInspectionSection.value =
          //     homeController.isInspectionEnabled;

          // homeController.isTrainingSectionnew.value =
          //     !homeController.isInspectionEnabled ||
          //         homeController.isTrainingEnabled &&
          //             homeController.isInspectionEnabled;

          // homeController.isCalibrationSection.value =
          //     !homeController.isInspectionEnabled &&
          //             !homeController.isTrainingEnabled ||
          //         homeController.isInspectionEnabled &&
          //             !homeController.isTrainingEnabled ||
          //         !homeController.isInspectionEnabled &&
          //             homeController.isTrainingEnabled ||
          //         homeController.isInspectionEnabled &&
          //             homeController.isTrainingEnabled &&
          //             homeController.isCalibrationEnabled;
          //       isFromSplashOrLogin = false;
          //     }

          // homeController.isTrainingSectionnew.value=
          // homeController.is
          homeController.isUsersignedIn();
          mobileNumberController.clear();
          pinPutOtpController.clear();
          dashboardController.dashboardRole = userData?.customerType;

          final InAppReview inAppReview = InAppReview.instance;

          if (await inAppReview.isAvailable()) {
            print('working');
            Future.delayed(const Duration(seconds: 30), () {
              inAppReview.requestReview();
            });
          }
          if (homeController.isuserLogin.value && homeController.isTraineeLogin.value && homeController.isTrainingSection.value && homeController.isCalibrationSection.value) {
            homeController.isTrainingSection.value = false;
            homeController.isCalibrationSection.value = false;
          }
          if (globalHomeController.tabIndex.value == 1) {
            globalHomeController.tabIndex.value = 0;
          }
          // if (!homeController.isuserLogin.value &&
          //     homeController.isTraineeLogin.value) {
          //   globalHomeController.tabIndex.value = 1;
          // }
          print('objedfsedfsct${globalHomeController.tabIndex.value}');
          switch (dashboardController.dashboardRole) {
            case 'user':
              Get.offAll(() => const TrainingInspectionScreen());

              break;
            case 'customer':
              homeController.customerLocations.clear();

              if (data['0'][0]['Name'] == null) {
                Get.to(() => ProfilePage(
                      isFromHomePage: homeController.isFromHome.value,
                      isFromPurchase: homeController.isFromPurchase.value,
                      isEdit: false,
                    ));
              } else {
                if (homeController.isFromPurchase.value == true) {
                  // preferences.setString(
                  //     'email_user_', data['0'][0]['Email'].toString());
                  // preferences.setString(
                  //     'Name_retake', data['0'][0]['Name'].toString());
                  // preferences.setString(
                  //     'Mobile_retake', data['0'][0]['Mobile'].toString());
                  await homeController.purchaseGateWay(
                      name: data['0'][0]['Name'].toString(),
                      phoneNumber: data['0'][0]["Mobile"].toString(),
                      email: data['0'][0]['Email'].toString(),
                      context,
                      tcontoller.totalPrice);
                } else {
                  Get.offAll(() => BottomNavigationWidget());
                }
              }

              //  Get.to(() =>  BottomNavigationWidget());

              break;
            default:
              Get.offAll(() => BottomNavigationWidget());
          }
        //  if(Platform.isAndroid){
           await FirebaseNotificationService.getNotificationPermission();
          await FirebaseNotificationService.subscribeToTopic(
              userType: dashboardController.dashboardRole.toString(),
              customerId: data['0'][0]['Id'].toString());
        //  }

          // Get.offAll(() => const BottomNavigationScreen());
        }

        // Get.to(() => const BottomNavigationScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Server Error')));
      }
    });
  }

  void adminLogin({required String otp, required context, required String phNo}) async {
    // Loader.showLoader();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String firebaseToken = '';

    final String customerName = preferences.getString('customerName') ?? "0";
    final String customerEmail = preferences.getString('email_user') ?? "0";
    final String customerMobile = preferences.getString('Mobile_user') ?? "0";

    try {
      homeController.messagingToken = FirebaseMessaging.instance;
      firebaseToken = await homeController.messagingToken.getToken() ?? '';
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    // print('firbase login token $firebaseToken');

    await HttpRequest.httpGetRequest(endPoint: HttpUrls.agentLogin, bodyData: {
      "phone": phNo,
      "otp": otp,
      "Device_Id": firebaseToken,
      "Country_Code": loginController.countryCode.isEmpty ? homeController.currentCountryCode.value : loginController.countryCode.value
    }).then((value) async {
      if (value.statusCode == 200) {
        // Loader.stopLoader();
        final data = jsonDecode(value.toString());

        if (data['0'][0]['Id'].toString() == '0') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect OTP entered!')));
          pinPutOtpController.clear();
        } else {
          userData = LoginOtpModel.fromJson(data['0'][0]);
          preferences.setString('token', '${data['token']}');
          //    preferences.setString('token', '${data['token']}');
          preferences.setString('darlsco_id', data['0'][0]['Id'].toString());

          preferences.setString('type', data['0'][0]['tp'].toString());
          //   preferences.setString('token', '${data['token']}');
          preferences.setString('trainee_login', data['0'][0]['Training'].toString());
          preferences.setString('phone_no', data['0'][0]["Mobile"].toString());
          preferences.setString('inspection_login', data['0'][0]['Inspection'].toString());
          homeController.isInspection.value = data['0'][0]['Inspection'].toString();
          homeController.isTraineee.value = data['0'][0]['Training'].toString();
          homeController.isUsersignedIn();
          mobileNumberController.clear();
          pinPutOtpController.clear();
          dashboardController.dashboardRole = userData?.customerType;

          // final InAppReview inAppReview = InAppReview.instance;

          // if (await inAppReview.isAvailable()) {
          //   print('working');
          //   Future.delayed(const Duration(seconds: 30), () {
          //     inAppReview.requestReview();
          //   });
          // }

          switch (dashboardController.dashboardRole) {
            case 'user':
              Get.to(() => const TrainingInspectionScreen());

              break;
            case 'customer':
              homeController.customerLocations.clear();

              if (data['0'][0]['Name'] == null) {
                Get.to(() => ProfilePage(
                      isFromHomePage: homeController.isFromHome.value,
                      isFromPurchase: homeController.isFromPurchase.value,
                      isEdit: false,
                    ));
              } else {
                if (homeController.isFromPurchase.value == true) {
                  await homeController.purchaseGateWay(name: customerName, phoneNumber: customerMobile, email: customerEmail, context, tcontoller.totalPrice);
                } else {
                  Get.offAll(() => BottomNavigationWidget());
                }
              }

              //  Get.to(() => const BottomNavigationWidget());

              break;
            default:
              Get.offAll(() => BottomNavigationWidget());
          }

          // Get.offAll(() => const BottomNavigationScreen());
        }

        // Get.to(() => const BottomNavigationScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Server Error')));
      }
    });
  }

  logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String cusId = sharedPreferences.getString('darlsco_id').toString();
// if(Platform.isAndroid){
  await FirebaseNotificationService.unsubscribeFromTopic(userType: dashboardController.dashboardRole.toString(), customerId: cusId);
// }
    await sharedPreferences.clear();
    // loginController.dispose();
    // tcontoller.refresh();
    // upcomingInspectionsController.refresh();
    // riskAssessmentController.dispose();
    if (homeController.tabIndex.value == 1 || homeController.tabIndex.value == 2) {
      homeController.tabIndex.value = 0;
    }
    homeController.isFromPurchase.value = false;
    globalHomeController.isTraineeLogin.value == false;
    globalHomeController.isuserLogin.value = false;
    globalHomeController.isUserLoggedIn = false;

    globalHomeController.isCalibrationSection.value = false;
    getcountry(context);
    homeController.isUsersignedIn();
  }
}
