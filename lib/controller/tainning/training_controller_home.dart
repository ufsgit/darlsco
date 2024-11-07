import 'dart:developer';
import 'dart:io';

import 'package:darlsco/controller/home/dummy.dart';
import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/controller/tainning/training_home_controller.dart';
import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/controller/tody_task_controller.dart';
import 'package:darlsco/http/http_request.dart';
import 'package:darlsco/http/http_urls.dart';
import 'package:darlsco/model/home/price_details_model.dart';
import 'package:darlsco/model/home/profile_model.dart';
import 'package:darlsco/model/home/profile_view_model.dart';
import 'package:darlsco/model/home/reschedule_model.dart';
import 'package:darlsco/model/training/add_to_cart_model.dart';
import 'package:darlsco/model/training/add_trainee_model.dart';
import 'package:darlsco/model/training/cart_price_model.dart';
import 'package:darlsco/model/training/category_eligible_model.dart';
import 'package:darlsco/model/training/certificate_model.dart';
import 'package:darlsco/model/training/count_model.dart';
import 'package:darlsco/model/training/eligible_exam_model.dart';
import 'package:darlsco/model/training/eligible_model.dart';
import 'package:darlsco/model/training/exam_attendance_model.dart';
import 'package:darlsco/model/training/exam_fail_details_model.dart';
import 'package:darlsco/model/training/exam_fail_trainee_details_model.dart';
import 'package:darlsco/model/training/get_cart_item_model.dart';
import 'package:darlsco/model/training/get_exam_details_now_model.dart';
import 'package:darlsco/model/training/get_location_count_model.dart';
import 'package:darlsco/model/training/get_order_item_model.dart';
import 'package:darlsco/model/training/get_order_model.dart';
import 'package:darlsco/model/training/get_today_task_model.dart';
import 'package:darlsco/model/training/get_trainee_details_model.dart';
import 'package:darlsco/model/training/get_trainer_model.dart';
import 'package:darlsco/model/training/get_training_model.dart';
import 'package:darlsco/model/training/location_list_model.dart';
import 'package:darlsco/model/training/save_attendance_model.dart';
import 'package:darlsco/model/training/specific_order_details_model.dart';
import 'package:darlsco/model/training/stop_exam_model.dart';
import 'package:darlsco/model/training/stop_training_course_model.dart';
import 'package:darlsco/model/training/trainee_reassign_model.dart';
import 'package:darlsco/model/training/training_item_details_model.dart';
import 'package:darlsco/model/training/upcoming_task_model.dart';
import 'package:darlsco/model/training/view_add_trainee_details_model.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/training/eligible_exam_page.dart';
import 'package:darlsco/view/training/training_home_screen.dart';
import 'package:darlsco/view/training/training_inspection_screen.dart';
import 'package:darlsco/view/training/widgets/bottom_navigation_widget.dart';
import 'package:darlsco/view/widgets/loader.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:darlsco/model/training/training_home_model.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

final TrainingControllerHomee trainingController =
    Get.put(TrainingControllerHomee());

class TrainingControllerHomee extends GetxController {
  TodayTaskController todayTaskController = Get.put(TodayTaskController());
  // @override
  // void onInit() {
  //   initState();

  //   super.onInit();
  // }
  RxList dropdownValues = [].obs;
  RxBool isCartscreenLoading = false.obs;
  RxBool isOrderscreenLoading = false.obs;
  RxBool isDocumentationscreenLoading = false.obs;
  RxBool editProfileLoading = false.obs;

  List<CategorySelectModelElement> priceDetailsList = [];

  List<SpecificOrderDetailsModel> specificOrderDetailList = [];

  String transactionFee = '0.00';

  var trainingData = <TrainingHomeModel>[].obs;
  var cartData = <GetCartItemModel>[].obs;
  var orderData = <GetOrderItemModelElement>[].obs;
  var countData = <CountModel>[].obs;
  var catdisplay = [].obs;
  // var trainingDetailsCourse = <TrainingCourseDetailsModel>[].obs;
  var todayTasksLst = <GetTodayTaskModel>[].obs;
  var todayExam = <GetExamDetailsNowModel>[].obs;
  var upComingTasks = <UpComingTaskModel>[].obs;
  var totalTrainingData = <GetTotalTrainingModel>[].obs;
  var getItemDetailsData = <ItemModelElement>[].obs;
  List getTriningDetailList = [];
  var selectType = ''.obs;
  var priceData = <GetCartItemModel>[].obs;
  var locList = <LocationListModel>[].obs;
  var trainerList = <Lead>[].obs;
  var priceDetailsData = <PriceDetailsModelElement>[].obs;
  var examFailDetails = <ExamFailDetailsModel>[].obs;
  var examFailedTraineeDetails = <ExamFailTraineeDetailsModel>[].obs;
  var traineeDetails = <GetTraineeDetailModel>[].obs;
  var categoryEligibilityDetails = <CategoryEligibleModelElement>[].obs;
  var locationCountDetails = <GetLocationCountModel>[].obs;
  var eligibilityDetails = <EligibleModel>[].obs;
  var profileDetails = <ProfileViewModel>[].obs;
  var certificateDetails = <CertificateModelElement>[].obs;
  var getIndivivdualDetails = <ProfileViewModel>[].obs;
  var isLoading = true.obs;
  var viewAddTrainees = <ViewAddTraineeDetailsModelElement>[].obs;

  List<String> traineeImgUrl = [];
  // var traineeDetailsStart = <TraineeDetailsStart>[].obs;

  var selectedCategory = Rx<CategorySelectModelElement?>(null);
  var selectedCategoryAfterNavigation = Rx<CategorySelectModelElement?>(null);

  var selectCategory = ''.obs;
  RxDouble priceList = 0.0.obs;
  var cartPriceList = <CartPriceModel>[].obs;

  String? receivedOtp; //variable that storing otp we get from get otp method

//login controllers
  TextEditingController numberHomeController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController trainingRescheduleController = TextEditingController();

//add trainee details controllers
  var firstNameControllers = [];
  var lastNameControllers = [];
  var dobControllers = [];
  var contactControllers = [];
  var emailControllers = [];
  var employeeidControllers = [];
  var emiratesidControllers = [];
  var applicationNumberIdControllers = [TextEditingController()];
  var customLocationControllers = [];
  var failedTraineesData = [];

  List retakePurchaseBillDataList = [];

//profilepage controllers
  TextEditingController emailIDController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  TextEditingController emiratesIDController = TextEditingController();
  TextEditingController tradeLicenceNoController = TextEditingController();

//other controllers
  TextEditingController notesController = TextEditingController();
  TextEditingController dateControler = TextEditingController();
  TextEditingController locController = TextEditingController();
  TextEditingController tradeLicenceExpiryDateController =
      TextEditingController();
  TextEditingController emiratesIdExpiryDateController =
      TextEditingController();

  Dio dio = Dio();

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

  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOnsiVXNlcl9EZXRhaWxzX0lkIjoxNTEsIlVzZXJfRGV0YWlsc19OYW1lIjoiQWRtaW4iLCJVc2VyX1R5cGUiOjEsIlJvbGVfSWQiOjMwLCJCcmFuY2hfSWQiOjQxLCJEZXBhcnRtZW50X0lkIjozNzAsIk5vdGlmaWNhdGlvbl9Db3VudCI6MCwiRXh0ZW5zaW9uIjoiMSIsIkRlcGFydG1lbnRfTmFtZSI6IkFETUlOIiwiVXBkYXRlZF9TZXJpYWxfSWQiOjc3fSwiaWF0IjoxNzEwODI0ODM2fQ.lupsZPLvOUe7EhV2qvZa7qt3ps-nnXrZqiAcwM_9dQo';

//method for updating controllers according to quantity
  void updateControllers(int quantity) {
    traineeImgUrl = List.generate(quantity, (index) => 'empty');
    firstNameControllers =
        List.generate(quantity, (index) => TextEditingController());
    lastNameControllers =
        List.generate(quantity, (index) => TextEditingController());
    dobControllers =
        List.generate(quantity, (index) => TextEditingController());
    contactControllers =
        List.generate(quantity, (index) => TextEditingController());
    emailControllers =
        List.generate(quantity, (index) => TextEditingController());
    employeeidControllers =
        List.generate(quantity, (index) => TextEditingController());
    emiratesidControllers =
        List.generate(quantity, (index) => TextEditingController());
    applicationNumberIdControllers =
        List.generate(quantity, (index) => TextEditingController());

    customLocationControllers =
        List.generate(quantity, (index) => TextEditingController());

    update();
  }

//method for fetching homepage data
  Future<void> fetchTrainingHomeData() async {
    await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.getTrainingCourse,
    ).then((response) async {
      if (response.statusCode == 200) {
        print('homedata//////');
        final responseData = response.data as List<dynamic>;
        final trainingDataList = responseData[0] as List<dynamic>;
        trainingData.value = trainingDataList
            .map((result) => TrainingHomeModel.fromJson(result))
            .toList();
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });
    update();
  }

//method for fetching course details
  Future<void> fetchDataCourse() async {
    await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.getItemDetails,
    ).then((response) async {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        final courseDataList = responseData[0] as List<dynamic>;
        getItemDetailsData.value = courseDataList
            .map((result) => ItemModelElement.fromJson(result))
            .toList();
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });

    update();
  }

//function for adding items to the cart
  addTocart(AddCart item) async {
    String? deviceId = await _getId();
    final prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('darlsco_id') ?? "0";

    print(deviceId);
    Map<String, dynamic> jsonData = {
      "Device_Id_": deviceId,
      "User_Id_": userId,
      "Training_Course_": item.trainingCourse
          .map(
            (e) => {
              "Description": e.description,
              "Training_Course_Id": e.trainingCourseId,
              "Training_Course_Name": e.trainingCourseName,
              "Training_Course_Category_Id": e.trainingCourseCategoryId,
              "Category_Name": e.categoryName,
              "Quantity": e.quantity,
              "Price": e.price,
              "Amount": e.amount,
              "File_Name": e.fileName,
              "Image_Name": e.imageName,
            },
          )
          .toList()
    };
    await HttpRequest.httpPostBodyRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.saveToCart,
    ).then((response) {
      if (response != null && response.statusCode == 200) {
        print(response);
        getItemCart();
        print('getItemCart7');
        print("Successfull");
      } else {
        print(response);
        print("Not Successfull");
      }
    });

    update();
  }

//function for getting items from cart
  getItemCart() async {
    // trainingController.cartPriceList.clear();
    isCartscreenLoading.value = true;
    String? deviceId = await _getId();
    print("///////////////Device ID $deviceId");
    final prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('darlsco_id') ?? '0';

    await HttpRequest.httpGetRequest(
      endPoint: '${'${HttpUrls.getCartItem}$userId'}/$deviceId',
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        print(responseData);
        if (responseData.isNotEmpty) {
          // cartData.clear();
          final cartDataList = responseData[0] as List<dynamic>;

          cartData.value = cartDataList
              .map((result) => GetCartItemModel.fromJson(result))
              .toList();

          tcontoller.homeQuatity.value = cartData.length;

          print(tcontoller.homeQuatity.value);

          double subtotal = 0;
          // trainingController.cartPriceList.clear();
          trainingController.cartPriceList.value = List.generate(
            cartData.length,
            (index) {
              double price = double.parse(cartData[index].amount);
              int quantity = cartData[index].quantity;
              double quantPrice = price * quantity;

              // double examinationFee =
              //     double.parse(cartData[index].examinationFee);
              // double certificateFee =
              //     double.parse(cartData[index].certificateFee);

              // double itemSubtotal =
              //     applicationFee + examinationFee + certificateFee + quantPrice;

              // subtotal += itemSubtotal;

              double applicationFee =
                  double.parse(cartData[index].applicationFee) * quantity;
              double examinationFee =
                  double.parse(cartData[index].examinationFee) * quantity;
              double certificateFee =
                  double.parse(cartData[index].certificateFee) * quantity;

              // double applicationVat = applicationFee * 2 / 100;
              // double examinationVat = examinationFee * 2 / 100;
              // double certificateVat = certificateFee * 2 / 100;

              double itemSubtotal =
                  applicationFee + examinationFee + certificateFee + quantPrice;

              subtotal += itemSubtotal;
              isCartscreenLoading.value = false;

              return CartPriceModel(
                  trainingCourseName: cartData[index].trainingCourseName,
                  trainingCourseCategoryId:
                      cartData[index].trainingCourseCategoryId,
                  trainingCourseId: cartData[index].trainingCourseId.toString(),
                  categoryName: cartData[index].categoryName,
                  quantity: cartData[index].quantity,
                  amount: cartData[index].amount,
                  price: cartData[index].price,
                  applicationFee: cartData[index].applicationFee,
                  examinationFee: cartData[index].examinationFee,
                  certificateFee: cartData[index].certificateFee,
                  duration: cartData[index].duration,
                  vat: cartData[index].vat,
                  subTotal: itemSubtotal.toString(),
                  grandTotal: itemSubtotal.toString(),
                  deleteStatus: cartData[index].deleteStatus,
                  applicationTax: cartData[index].applicationTax,
                  certificateTax: cartData[index].certificateTax,
                  examinationTax: cartData[index].examinationTax,
                  serviceCharge: cartData[index].serviceCharge,
                  tax: cartData[index].tax,
                  retakeOnlyPracticalTax:
                      cartData[index].retakeOnlyPracticalTax,
                  retakeWrittenFee: cartData[index].retakeOnlyWrittenFee,
                  retakepracticalFee: cartData[index].retakeOnlyPracticalFee,
                  retakeOnlyWrittenTax: cartData[index].retakeOnlyWrittenTax,
                  trainingWithExamFee: cartData[index].trainingWithExamFee);
            },
          );
          print('fsgrswgert ${trainingController.cartPriceList}');
          print(cartData);
          print(cartPriceList);

          // billpaymentDetailsList=List.generate(cartData.length, (index) => {

          //   "productName":cartData[index].trainingCourseName,
          //   "category":cartData[index].categoryName,
          //   "quatity":cartData[index].quantity,
          //   "application_fees":cartData[index].

          // })
        } else {
          isCartscreenLoading.value = false;

          throw Exception('Empty response data');
        }
      } else {
        isCartscreenLoading.value = false;

        throw Exception('Failed to load items in cart: ${response.statusCode}');
      }
      isCartscreenLoading.value = false;
    });

    update();
  }

//function for getting cart price
  Future<void> getItemCartforPrice() async {
    String? deviceId = await _getId();
    print("cart///////Device ID $deviceId");
    final prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('darlsco_id') ?? '0';
    await HttpRequest.httpGetRequest(
      endPoint: '${'${HttpUrls.getCartItem}$userId'}/$deviceId',
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        print("gdf $responseData");
        if (responseData.isNotEmpty) {
          priceData.clear();
          final cartDataList = responseData[0] as List<dynamic>;
          final results = cartDataList
              .map((result) => GetCartItemModel.fromJson(result))
              .toList();
          priceData.addAll(results);
          print(results);
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });
    update();
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartData) {
      double itemPrice = double.tryParse(item.amount) ?? 0.0;
      int itemQuantity = item.quantity;
      totalPrice += itemPrice * itemQuantity;
    }
    return totalPrice;
  }

//function for display order's items in order page
  Future<void> getOrdersItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "6";
    isOrderscreenLoading.value = true;
    await HttpRequest.httpGetRequest(
            endPoint: HttpUrls.getOrderItems + customerId)
        .then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        print(responseData);
        if (responseData.isNotEmpty) {
          orderData.clear();
          final orderDataList = responseData[0] as List<dynamic>;
          orderData.value = orderDataList
              .map((result) => GetOrderItemModelElement.fromJson(result))
              .toList();
          isOrderscreenLoading.value = false;
        } else {
          isOrderscreenLoading.value = false;

          throw Exception('Empty response data');
        }
      } else {
        isOrderscreenLoading.value = false;

        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    });
    update();
  }

  getSpecificOrderDetails({required String orderMasterId}) async {
    await HttpRequest.httpGetRequest(
            endPoint: HttpUrls.getSpecificOrderDetails + orderMasterId)
        .then((response) {
      if (response.statusCode == 200) {
        // print("get specific order details  ${ response.data[0][2].toString()  }");

        List data = response.data[0];

        specificOrderDetailList =
            data.map((e) => SpecificOrderDetailsModel.fromJson(e)).toList();
      } else {
        throw Exception('Empty response data');
      }
    });
    update();
  }

  void getOrdersItemsR(
      {required BuildContext context,
      required String orderId,
      required DateTime selectedDate,
      required String notes}) async {
    // String formattedDate = selectedDate.toIso8601String();

    // Example JSON data
    Map<String, dynamic> jsonData = {
      "Reschedule_Course_Id": orderId,
      "Order_Details_Sub_Id": 456,
      "Training_Course_Id": 789,
      "Training_Course_Category_Id": 123,
      "Training_Course_Name": "Example Course",
      "Category_Name": "Example Category",
      "Reschedule_Date": selectedDate,
      "Reschedule_Time": "10:00 AM",
      "Trainer_Id": 123,
      "Trainer_Name": "Example Trainer",
      "Notes": notes,
      "Current_Status_Id": 1,
      "Current_Status_Name": "Example Status",
      "User_Id": 123,
      "Remarks": "Example Remarks",
      "Quantity": 1
    };

    await HttpRequest.httpPostBodyRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.rescheduleCourse,
    ).then((response) {
      if (response != null && response.statusCode == 200) {
        print(response);
        print("Successfull");
      } else {
        print(response);
        print("Not Successfull");
      }
    });

    update();
  }

//method for reassign the trainee
  traineeReassign(ReassignModel item, BuildContext context) async {
    // String dateTimeString = '';
    // final dio = Dio();
    // try {
    //   final response = await dio.get('http://worldtimeapi.org/api/ip');
    //   if (response.statusCode == 200) {
    //     Loader.stopLoader();
    //     final data = response.data as Map<String, dynamic>;
    //     dateTimeString = data['datetime'];

    //     final time = data['datetime'].toString().split('T')[1].split('.')[0];
    //     print('Current time: $time');
    //   } else {
    //     Loader.stopLoader();
    //     print('Failed to fetch time');
    //   }
    // } catch (e) {
    //   print('Error: $e');
    // }
    final prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('darlsco_id') ?? "0";
    Map<String, dynamic> jsonData = {
      "Order_Details_Sub_Id": item.orderDetailsSubId,
      "Trainer_Id": item.trainerId,
      "Trainer_Name": item.trainerName,
      "User_Id": userId,
      "Expected_Date": item.expectedDate,
      "Notes_Sub": item.notes,
    };
    await HttpRequest.httpPostBodyRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.saveTraineeRassign,
    ).then((response) async {
      if (response != null && response.statusCode == 200) {
        print(response);
        print("Successfull");
        trainingController.notesController.clear();
        await trainingController.getUpComingTask();

        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
            content: Text('Reassign Request sent successfully')));
        // Get.offAll(() => const TrainingInspectionScreen());
      } else {
        print(response);
        print("Not Successfull");
      }
    });

    update();
  }

//function for adding trainees details
  addTrainee(AddTraineeModel item, context) async {
    Map<String, dynamic> jsonData = {
      // "Order_Details_Sub_Id_": item.orderDetailsSubId,
      "Order_Details_Id_": item.orderDetailsId,
      // "OrderLocation_Id_": item.orderLocationId,
      "Duration_": item.duration,
      "Order_Master_Id_": item.orderMasterId,
      "Quantity_": item.quantity,
      "Trainee_Details_": item.traineeDetails
          .map(
            (e) => {
              "Training_Course_Id": e.trainingCourseId,
              "Training_Course_Name": e.trainingCourseName,
              "Training_Course_Category_Id": e.trainingCourseCategoryId,
              "Category_Name": e.categoryName,
              "Employee_Firstname": e.employeeFirstname,
              "Employee_Lastname": e.employeeLastname,
              "Employee_Id": e.employeeId,
              "DateofBirth": e.dateofBirth,
              "Email_Id": e.emailId,
              "MobileNo": e.mobileNo,
              "Country_Code_Id": e.countryCodeName,
              "Country_Code_Name": e.countryCode,
              "Emirate_Id": e.emirateId,
              "Location_Id": e.locationId,
              "Location_Name": e.locationName,
              "Latitude": e.latitude,
              "Longitude": e.longitude,
              "Photo": e.photoUrl,
            },
          )
          .toList()
    };

    await HttpRequest.httpPostBodyRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.saveTrainee,
    ).then((response) async {
      print(response);
      if (response?.statusCode == 200) {
        await getOrdersItems();
        // await getSpecificOrderDetails(
        //     orderMasterId: item.orderMasterId.toString());
        tcontoller.isTraineeAdded.value = true;
        print(tcontoller.isTraineeAdded.value);
        print(response?.data);
        // await trainingController.getSpecificOrderDetails(orderMasterId: item.orderMasterId.toString());

        await trainingController.getOrdersItems();

        Get.back();
        trainingController.update();

        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Trainee Added Successfully')));

        print("Successfull");
      } else {
        print(response);
        print("Not Successfull");
      }
    });

    update();
  }

//function for getting otp
  Future<void> getOtp(String phoneNumber, String countryCode) async {
    String? deviceId = await _getId();
    print("cart///////Device ID $deviceId");
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    Loader.showLoader();
    await HttpRequest.httpGetRequest(
            endPoint:
                '${HttpUrls.getOtpUrl}$phoneNumber/$countryCode/$deviceId')
        .then((response) {
      if (response.statusCode == 200) {
        Loader.stopLoader();
        var responseData = response.data;

        trainingController.otpController.clear();
        if (responseData.containsKey('Data') &&
            responseData['Data'] is List &&
            responseData['Data'].isNotEmpty) {
          var data = responseData['Data'][0];
          if (data.containsKey('OTP')) {
            var otp = data['OTP'];
            // preferences.setString(
            //     'country_code_id', data['0'][0]["country_code_Id"].toString());
            receivedOtp = otp.toString();
            // ScaffoldMessenger.of(Get.context!)
            //     .showSnackBar(SnackBar(content: Text('otp:$otp')));
            log('OTP received: $otp');
            print(
                'data cart in api call//////// ${trainingController.cartPriceList.length}');
          } else {
            throw Exception('OTP not found in response data');
          }
        } else {
          throw Exception('Invalid or empty "Data" array in response');
        }
      } else {
        throw Exception('Failed to load otp: ${response.statusCode}');
      }
    });
    update();
  }

  //function for deleting items from the cart
  Future<void> deleteCartItem(int itemCartId) async {
    await HttpRequest.httpGetRequest(
            endPoint: '${HttpUrls.deleteCartItem}$itemCartId')
        .then((response) async {
      if (response.statusCode == 200) {
        log('Item deleted successfully');
        print('getItemCart6');
        await getItemCart();
      } else {
        throw Exception('Failed to delete item: ${response.statusCode}');
      }
    });
    update();
  }

  Future<void> deleteItemCart() async {
    String? deviceId = await _getId();
    print("cart///////Device ID $deviceId");
    final prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('darlsco_id') ?? '0';
    await HttpRequest.httpGetRequest(
            endPoint: '${HttpUrls.deleteItemCart}$deviceId')
        .then((response) async {
      if (response.statusCode == 200) {
        log('Item deleted successfully');
        print('getItemCart6');
        await getItemCart();
      } else {
        throw Exception('Failed to delete item: ${response.statusCode}');
      }
    });
    update();
  }

  //function for display count of tasks
  Future<void> fetchTaskCount() async {
    countData.clear();
    print('calling...........................');
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "";
    await HttpRequest.httpGetRequest(endPoint: HttpUrls.getCount + customerId)
        .then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          final countDataList = responseData[0] as List<dynamic>;
          print(countDataList);
          final count = CountModel.fromJson(countDataList[0]);
          print(count);
          countData.add(count);
          print(countData);
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load tasks count: ${response.statusCode}');
      }
    });

    update();
  }

  //function for display today tasks
  getTodayTask() async {
    trainingController.todayTasksLst.clear();
    final prefs = await SharedPreferences.getInstance();
    final String staffId = prefs.getString('darlsco_id') ?? "";
    await HttpRequest.httpGetRequest(endPoint: HttpUrls.getTodayTask + staffId)
        .then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        print(responseData);
        if (responseData.isNotEmpty) {
          final todayTaskList = responseData[0] as List<dynamic>;
          trainingController.todayTasksLst.value = todayTaskList
              .map((result) => GetTodayTaskModel.fromJson(result))
              .toList();
          print('todays task from api   ${trainingController.todayTasksLst}');

          trainingController.update();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load today tasks: ${response.statusCode}');
      }
    });
    update();
  }

  //function for display today tasks
  Future<void> getTodayExamDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final String staffId = prefs.getString('darlsco_id') ?? "";
    await HttpRequest.httpGetRequest(
            endPoint: HttpUrls.getExamDetailsNow + staffId)
        .then((response) {
      if (response.statusCode == 200) {
        todayExam.clear();
        final responseData = response.data as List<dynamic>;
        print(responseData);
        if (responseData.isNotEmpty) {
          final todayExamList = responseData[0] as List<dynamic>;
          todayExam.value = todayExamList
              .map((result) => GetExamDetailsNowModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load today tasks: ${response.statusCode}');
      }
    });
    update();
  }

  //11.function for display upcoming tasks
  Future<void> getUpComingTask() async {
    final prefs = await SharedPreferences.getInstance();
    final String staffId = prefs.getString('darlsco_id') ?? "";
    await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.getUpComingTask + staffId,
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        print(responseData);
        if (responseData.isNotEmpty) {
          upComingTasks.clear();
          final upComingTaskList = responseData[0] as List<dynamic>;
          upComingTasks.value = upComingTaskList
              .map((result) => UpComingTaskModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception(
            'Failed to load upcoming tasks: ${response.statusCode}');
      }
    });
    update();
  }

  //12.function for display total training attended
  Future<void> getTotalTraining() async {
    final prefs = await SharedPreferences.getInstance();
    final String staffId = prefs.getString('darlsco_id') ?? "";
    await HttpRequest.httpGetRequest(
            endPoint: HttpUrls.getTrainingAttended + staffId)
        .then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        print(responseData);
        if (responseData.isNotEmpty) {
          totalTrainingData.clear();
          final totalTrainingDetails = responseData[0] as List<dynamic>;
          totalTrainingData.value = totalTrainingDetails
              .map((result) => GetTotalTrainingModel.fromJson(result))
              .toList();
        }
      }
    });
    update();
  }

//13 function for getting orders details
  Future<void> getOrders() async {
    await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.getOrder,
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;

        if (responseData.isNotEmpty) {
          final orderDataList = responseData[0] as List<dynamic>;
          final results = orderDataList
              .map((result) => GetOrderModel.fromJson(result))
              .toList();
          print(results);
          orderData.addAll(results as Iterable<GetOrderItemModelElement>);
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });
    update();
  }

//function for getting price view
  Future<void> getPriceView() async {
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.getItemDetails}/3',
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;

        if (responseData.isNotEmpty) {
          final priceDetailsDatalist = responseData[0] as List<dynamic>;
          print(priceDetailsDatalist);
          priceDetailsData.value = responseData[1]
              .map((result) => PriceDetailsModelElement.fromJson(result))
              .toList();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load price details: ${response.statusCode}');
      }
    });
    update();
  }

  String formatText(String input) {
    List<String> words = input.split(' ');

    List<String> chunks = [];
    for (int i = 0; i < words.length; i += 6) {
      String chunk = words
          .sublist(i, i + 6 > words.length ? words.length : i + 6)
          .join(' ');
      chunks.add(chunk);
    }

    // Join chunks with line breaks
    return chunks.join('\n');
  }

//function for reschedule course
  rescheduleCourse(RescheduleUser user, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('darlsco_id') ?? "";
    final formattedReason = formatText(user.notes);
    Map<String, dynamic> mapData = {
      "Order_Details_Id": user.orderDetailsId,
      "Training_Course_Id": user.trainingCourseId,
      "Training_Course_Category_Id": user.trainingCourseCategoryId,
      "Training_Course_Name": user.trainingCourseName,
      "Category_Name": user.categoryName,
      "Reschedule_Date": user.rescheduleDate,

      "Trainer_Id": user.trainerId,
      "Trainer_Name": user.trainerName,
      "Notes": formattedReason,
      "Current_Status_Id": user.currentStatusId,
      "Current_Status_Name": user.currentStatusName,
      // "User_Id": userId,
      // "Remarks": user.remarks,

      'Order_No': user.orderNo,
      'Location_Name': user.orderLocationName,
      'Start_Time': user.startTime,
      'End_Time': user.endTime,

      "Order_Details_Sub_Id": user.orderDetailsSubId,

      "Order_Location_Id": user.orderLocationId,
      "Quantity": user.quantity,
      "Customer_Id": userId,
    };
    print(mapData);

    await HttpRequest.httpPostBodyRequest(
      bodyData: mapData,
      endPoint: HttpUrls.rescheduleCourse,
    ).then((response) async {
      if (response != null && response.statusCode == 200) {
        print(response);
        await trainingController.getLocationsCount(
            user.orderDetailsId.toString(), user.orderLocationId.toString());
        trainingController.update();
        Get.back();
        print("Successfull");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Reschedule Request sent Successfully')));
        print(response.statusCode);
      } else {
        print(response);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reschedule request failed')));
        print("Not Successfull");
      }
    });

    update();
  }

//function for get trainee details
  Future<void> getTraineeDetails(String orderDetailsId, String orderLocationId,
      String examMasterId) async {
    // final prefs = await SharedPreferences.getInstance();
    // final String customerId = prefs.getString('darlsco_id') ?? "";
    await HttpRequest.httpGetRequest(
      endPoint:
          '${HttpUrls.getTraineeDetails + orderDetailsId}/$orderLocationId/$examMasterId',
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          traineeDetails.clear();
          final traineeDetailsData = responseData[0] as List<dynamic>;
          traineeDetails.value = traineeDetailsData
              .map((result) => GetTraineeDetailModel.fromJson(result))
              .toList();
          print('dfwrnfjer ${traineeDetails}');
          dropdownValues.value = List.generate(
              trainingController.traineeDetails.length,
              (index) => eligibleList.first);
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });

    update();
  }

  Future<void> getCategoryDocumentation() async {
    // final prefs = await SharedPreferences.getInstance();
    // final String customerId = prefs.getString('darlsco_id') ?? "";
    isDocumentationscreenLoading.value = true;
    await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.getCategoryEligibility,
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          isDocumentationscreenLoading.value = false;

          categoryEligibilityDetails.clear();
          final categoryEligibilityDetailsData =
              responseData[0] as List<dynamic>;
          categoryEligibilityDetails.value = categoryEligibilityDetailsData
              .map((result) => CategoryEligibleModelElement.fromJson(result))
              .toList();
        } else {
          isDocumentationscreenLoading.value = false;

          throw Exception('Empty response data');
        }
      } else {
        isDocumentationscreenLoading.value = false;

        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });

    update();
  }

//function for stop training course
  stopTrainingCourse(
      StopTrainingCourseModel item, BuildContext context, int index) async {
    await getTodayTask();
    await getTraineeDetails(
        trainingController.todayTasksLst[index].orderDetailsId.toString(),
        trainingController.todayTasksLst[index].orderLocationId.toString(),
        trainingController.todayTasksLst[index].examMasterId.toString());
    Map<String, dynamic> jsonData = {
      "Order_Details_Sub_Id_": item.orderDetailsSubId
    };
    await HttpRequest.httpPostBodyRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.stopTrainingCourse,
    ).then((response) async {
      if (response?.data is List<dynamic> && response?.data.isNotEmpty) {
        var eligibility = response?.data[0]['Eligibility'];
        if (trainingController.todayTasksLst[index].examMasterId == 0 &&
            eligibility == 0) {
          // print(todayTasksLst);
          Get.offAll(() => EligibleExamPage(
                model: trainingController.todayTasksLst[index],
              ));
        } else {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD8EAFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                  child: Lottie.network(
                    'https://lottie.host/ffc44d55-21a7-428c-83bb-8ec5a2e77c4c/6WF3nan42F.json',
                    width: 200,
                    height: 200,
                  ),
                ),
                actions: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Day completed",
                          style: TextStyle(
                              color: const Color(0xFF294C73),
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: BeveledRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: const Color(0xFFE5AA17)),
                          onPressed: () async {
                            // widget.model.remainingDaysCount == 1
                            // Get.to(() => EligibleExamPage());
                            await trainingController.fetchTaskCount();
                            todayTaskController.update();
                            // await trainingController.fetchTaskCount();

                            Get.to(() => const TrainingInspectionScreen());
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                                color: const Color(0xFF294C73),
                                fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
      } else {
        print(response);
        print("Not Successfull");
      }
    });

    update();
  }

//function for stop exam
  stopExam(StopExamModel item, BuildContext context) async {
    Map<String, dynamic> jsonData = {"Exam_Master_Id_": item.examMasterId};
    await HttpRequest.httpPostBodyRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.stopExam,
    ).then((response) {
      if (response?.data is List<dynamic> && response?.data.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 200,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  color: Color(0xFFD8EAFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(100),
                  ),
                ),
                child: Lottie.network(
                  'https://lottie.host/ffc44d55-21a7-428c-83bb-8ec5a2e77c4c/6WF3nan42F.json',
                  width: 200,
                  height: 200,
                ),
              ),
              actions: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Exam completed",
                        style: TextStyle(
                            color: const Color(0xFF294C73),
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: BeveledRectangleBorder(
                                side: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)),
                            backgroundColor: const Color(0xFFE5AA17)),
                        onPressed: () async {
                          await todayTaskController.fetchTaskCount();
                          Get.to(() => const TrainingInspectionScreen());
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                              color: const Color(0xFF294C73), fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      } else {
        print(response);
        print("Not Successfull");
      }
    });

    update();
  }

//function for start training course
  saveAttendance(SaveAttendanceModel item) async {
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "";
    Map<String, dynamic> jsonData = {
      "Attendance_Date_": item.attendanceDate,
      "Attendance_Time_": item.attendanceTime,
      "User_Id_": customerId,
      "Order_Details_Sub_Id_": item.orderDetailsSubId,
      "Attendance_Details_": item.attendanceDetails
          .map((e) => {
                "Training_Course_Id": e.trainingCourseId,
                "Training_Course_Name": e.trainingCourseName,
                "Training_Course_Category_Id": e.trainingCourseCategoryId,
                "Category_Name": e.categoryName,
                "Trainee_Id": e.traineeId,
                "Trainee_Name": e.traineeName,
                "Attendance_Status_Id": e.attendanceStatusId,
                "Attendance_Status_Name": e.attendanceStatusName,
              })
          .toList()
    };
    await HttpRequest.httpPostBodyRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.saveAttendance,
    ).then((response) {
      if (response != null && response.statusCode == 200) {
        print(response);
        print("Successfull");
      } else {
        print(response);
        print("Not Successfull");
      }
    });
    update();
  }

//function for start exam
  saveExamAttendance(ExamAttendanceModel item) async {
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "";
    Map<String, dynamic> jsonData = {
      "Attendance_Date_": item.attendanceDate,
      "Attendance_Time_": item.attendanceTime,
      "User_Id_": customerId,
      "Exam_Master_Id_": item.examMasterId,
      "Exam_Details_": item.examDetails
          .map((e) => {
                "Trainer_Id": customerId,
                "Trainer_Name": e.trainerName,
                "Training_Course_Category_Id": e.trainingCourseCategoryId,
                "Category_Name": e.categoryName,
                "Trainee_Id": e.traineeId,
                "Trainee_Name": e.traineeName,
                "Training_Course_Id": e.trainingCourseId,
                "Training_Course_Name": e.trainingCourseName,
                "Attendance_Status_Id": e.attendanceStatusId,
                "Attendance_Status_Name": e.attendanceStatusName,
              })
          .toList()
    };
    await HttpRequest.httpPostBodyRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.startExam,
    ).then((response) {
      if (response != null && response.statusCode == 200) {
        print(response);
        print("Successfull");
      } else {
        print(response);
        print("Not Successfull");
      }
    });
    update();
  }

  saveEligibility(EligibleExamModel item) async {
    Map<String, dynamic> jsonData = {
      "Eligibility_Details_": item.eligibilityDetails
          .map((e) => {
                "Trainee_Details_Id": e.traineeDetailsId,
                "Eligibility_Status_Id": e.eligibilityStatusId,
                "Eligibility_Status_Name": e.eligibilityStatusName,
              })
          .toList()
    };
    await HttpRequest.httpPostDataRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.saveEligibilityExamSave,
    ).then((response) {
      if (response != null && response.statusCode == 200) {
        print(response);
        print("Successfull");
      } else {
        print(response);
        print("Not Successfull");
      }
    });
    update();
  }

//function for updating selected category
  updateSelectedCategory(String categoryName) {
    selectCategory.value = categoryName;
    print('Selected Category: $categoryName');
    // Print the selected category
    update();
  }

  getCertificate() async {
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "0";
    await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.certificateView + customerId,
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          certificateDetails.clear();
          final certificateData = responseData[0] as List<dynamic>;
          certificateDetails.value = certificateData
              .map((result) => CertificateModelElement.fromJson(result))
              .toList();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });

    update();
  }

//function for fetching category data
  fetchCategoryData(String trainingCourseId,
      {bool isCategorySelected = false}) async {
    print('adasd');
    // trainingController.cartPriceList.clear();
    priceDetailsList.clear();
    catdisplay.clear();
    await HttpRequest.httpGetRequest(
            endPoint: '${HttpUrls.getItemDetails}/$trainingCourseId')
        .then((response) async {
      if (response.statusCode == 200) {
        // getItemCart();
        List responseData = response.data[1];
        List responsePriceDetails = response.data[1];

        getTriningDetailList = response.data[0];
        print(' getTriningDetailList  $getTriningDetailList');
        catdisplay.value = responseData
            .map((result) => CategorySelectModelElement.fromJson(result))
            .toList();
        List data = response.data[1];

        // selectedCategory.value = catdisplay[0];
        // trainingDetailsCourse.value = data
        //     .map((result) => TrainingCourseDetailsModel.fromJson(result))
        //     .toList();
        // print('TRAINING COURSE DETAILS LIST$trainingDetailsCourse');
        priceDetailsList = responsePriceDetails
            .map((result) => CategorySelectModelElement.fromJson(result))
            .toList();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            'transaction_fee', priceDetailsList[0].serviceCharge.toString());

        double subtotal = 0;

        // trainingController.cartPriceList.clear();
        trainingController.cartPriceList.value = List.generate(
          1,
          (index) {
            double price = double.tryParse(priceList.toString()) ?? 0.0;
            int quantity = tcontoller.quantity.value;
            double quantPrice = price * quantity;
            double applicationFee =
                double.parse(catdisplay[index].applicationFees) * quantity;
            double examinationFee =
                double.parse(catdisplay[index].examinationFees) * quantity;
            double certificateFee =
                double.parse(catdisplay[index].certificateFees) * quantity;

            // double applicationVat = applicationFee * 2 / 100;
            // double examinationVat = examinationFee * 2 / 100;
            // double certificateVat = certificateFee * 2 / 100;

            double itemSubtotal =
                applicationFee + examinationFee + certificateFee + quantPrice;

            return CartPriceModel(
                trainingCourseName:
                    response.data[0][0]['Training_Course_Name'] ?? 'Product',
                trainingCourseId: catdisplay[index].trainingCourseId.toString(),
                trainingCourseCategoryId:
                    catdisplay[index].trainingCourseCategoryId,
                categoryName: catdisplay[index].categoryName,
                quantity: tcontoller.quantity.value,
                amount: price.toString(),
                price: price.toString(),
                applicationFee: catdisplay[index].applicationFees,
                examinationFee: catdisplay[index].examinationFees,
                certificateFee: catdisplay[index].certificateFees,
                vat: catdisplay[index].tax,
                subTotal: itemSubtotal.toString(),
                grandTotal: itemSubtotal.toString(),
                deleteStatus: catdisplay[index].deleteStatus,
                applicationTax: catdisplay[index].applicationTax,
                certificateTax: catdisplay[index].certificateTax,
                examinationTax: catdisplay[index].examinationTax,
                serviceCharge: catdisplay[index].serviceCharge,
                tax: catdisplay[index].tax,
                retakeOnlyPracticalTax:
                    catdisplay[index].retakeOnlyPracticalTax,
                retakeOnlyWrittenTax: catdisplay[index].retakeOnlyWrittenTax,
                retakeWrittenFee: catdisplay[index].retakeOnlyWritenFess,
                retakepracticalFee: catdisplay[index].retakeOnlyPracticalFees,
                duration: catdisplay[index].duration,
                trainingWithExamFee: catdisplay[index].trainingwithExamFees);
          },
        );
        print(catdisplay);
        print('cart price list:${trainingController.cartPriceList}');

        // fn();
      } else {
        throw Exception('Failed to load category data: ${response.statusCode}');
      }
    });
    print('ssss ${selectedCategoryAfterNavigation.value?.categoryName}');

    if (isCategorySelected) {
      final listcategoryData = trainingController.catdisplay.where((item) {
        print('asdfghjkl ${item.categoryName}');
        print(
            'hghghghg ${trainingController.selectedCategoryAfterNavigation.value?.categoryName}');

        return item.categoryName ==
            trainingController
                .selectedCategoryAfterNavigation.value?.categoryName;
      }).toList();
      if (listcategoryData.isNotEmpty) {
        trainingController.selectedCategory.value = listcategoryData[0];
      }
    }
    // selectedCategory.value = selectedCategoryAfterNavigation.value;
    //  trainingController.selectedCategory.value=catdisplay.where((category) =>category );

    update();
  }

//method for updating price
  updatePrice(double price) {
    priceList.value = price;
    print('Updated price: $price');
    update();
  }

//method for updating selected value for radiobutton
  updateSelected(String examtype) {
    selectType.value = examtype;
    print(examtype); // Print the selected category
    update();
  }

//method for add and edit profile
  addProfileEdit(
      ProfileEditModel profileEditModel, isFromPurchase, isFromHomePage,
      {bool isEdit = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "0";
    Map<String, dynamic> jsonData = {
      "Customer_Id_": customerId,
      "Customer_Name_": profileEditModel.customerName,
      "Mobile_": profileEditModel.mobile,
      "Email_": profileEditModel.email,
      "Contact_Name_": profileEditModel.contactName,
      // "Company_Name_": profileEditModel.companyName,

      "Emirates_Id_": profileEditModel.emiratesId,
      "Emirates_Date_": profileEditModel.emiratesDate ?? '',
      "Country_Code_Name_": profileEditModel.countryCodeName,
      "Country_Code_Id_": globalHomeController.currentCountryCode.value,
      "Individual_": profileEditModel.individual,
      "Corporate_": profileEditModel.corporate,
      "Trade_License_No_": profileEditModel.tradeLicenceNo,
      "Trade_License_No_Expiry_Date_":
          profileEditModel.tradeLicenceExpiryDate ?? '',
      "File_Path_": profileEditModel.filePath != null &&
              profileEditModel.filePath!.isNotEmpty
          ? Uri.tryParse(profileEditModel.filePath.toString())!.path
          : '',
    };

    await HttpRequest.httpPostDataRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.saveProfile,
    ).then((response) async {
      if (response != null && response.statusCode == 200) {
        prefs.setString(
            'customerId', response.data[0]['Customer_Id_'].toString());
        prefs.setString('customerName', response.data[0]['Name'].toString());
        prefs.setString('email_user', response.data[0]["Email"].toString());
        prefs.setString('Mobile_user', response.data[0]["Mobile"].toString());
        if (response.data[0]['Customer_Id_'].toString() == '-1') {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
              const SnackBar(content: Text('Email ID Already Exists!')));
        } else if (response.data[0]['Customer_Id_'].toString() == '-2') {
          ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
              content: Text('Trade Licence No Already Exists!')));
        } else if (response.data[0]['Customer_Id_'].toString() == '-3') {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
              const SnackBar(content: Text('Emirates ID Already Exists!')));
        } else {
          print(response);
          trainingController.customerNameController.clear();
          trainingController.emailIDController.clear();
          trainingController.phoneNumberController.clear();
          trainingController.contactPersonController.clear();
          trainingController.emiratesIDController.clear();
          trainingController.tradeLicenceNoController.clear();
          trainingController.emiratesIdExpiryDateController.clear();
          trainingController.tradeLicenceExpiryDateController.clear();

          print("Successfull");
          if (!isEdit) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
                const SnackBar(content: Text('Profile Successfully Added')));
          } else {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
                const SnackBar(content: Text('Profile Successfully Edited')));
            Get.to(() => BottomNavigationWidget());
          }

          if (isFromPurchase == false && isFromHomePage == true) {
            Get.to(() => BottomNavigationWidget());
          } else if (isFromPurchase == true) {
            log(tcontoller.totalPrice.toString());
            log(tcontoller.coursePrice.toString());
            print(
                'Cartdata in telr//////// ${trainingController.cartPriceList.length}');
            await homeController.purchaseGateWay(
                name: response.data[0]['Name'],
                phoneNumber: response.data[0]["Mobile"],
                email: response.data[0]['Email'],
                Get.context!,
                tcontoller.coursePrice.toStringAsFixed(2));
            print(
                'Cartdata in telr//////// ${trainingController.cartPriceList.length}');
          } else {
            Get.to(() => BottomNavigationWidget());
          }
        }

        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Profile Successfully Added')));
      } else {
        print(response);
        trainingController.customerNameController.clear();
        trainingController.emailIDController.clear();
        trainingController.phoneNumberController.clear();
        trainingController.contactPersonController.clear();
        trainingController.emiratesIDController.clear();
        trainingController.tradeLicenceNoController.clear();
        trainingController.emiratesIdExpiryDateController.clear();
        trainingController.tradeLicenceExpiryDateController.clear();

        print("Not Successfull");
      }
    });

    update();
  }

  Future<void> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "0";
    await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.getProfile + customerId,
    ).then((response) {
      print('dsfgsdrg ${response.data}');
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          profileDetails.clear();
          final profileDetailsData = responseData[0] as List<dynamic>;
          profileDetails.value = profileDetailsData
              .map((result) => ProfileViewModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });

    update();
  }

  Future<void> getIndividualTrainee() async {
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "6";
    try {
      await HttpRequest.httpGetRequest(
        endPoint: HttpUrls.getIndividualTrainee + customerId,
      ).then((response) {
        if (response.statusCode == 200) {
          print('response data ${response.data}');
          final responseData = response.data as List<dynamic>;
          if (responseData.isNotEmpty) {
            getIndivivdualDetails.clear();
            final profileDetailsData = responseData[0] as List<dynamic>;
            getIndivivdualDetails.value = profileDetailsData
                .map((result) => ProfileViewModel.fromJson(result))
                .toList();
          } else {
            throw Exception('Empty response data');
          }
        } else {
          throw Exception(
              'Failed to load training data: ${response.statusCode}');
        }
      });
    } catch (e) {
      print(e.toString());
    }

    update();
  }

//method for view exam failed list
  Future<void> getExamFailedDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "6";
    await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.examFailedDetails + customerId,
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          examFailDetails.clear();
          final examFailDetailsData = responseData[0] as List<dynamic>;
          examFailDetails.value = examFailDetailsData
              .map((result) => ExamFailDetailsModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });

    update();
  }

  // Future<ProfileEditModel> fetchUserProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? emiratesDateString = prefs.getString('emiratesDate');
  //   DateTime? emiratesDate;

  //   if (emiratesDateString != null && emiratesDateString.isNotEmpty) {
  //     try {
  //       emiratesDate = DateTime.parse(emiratesDateString);
  //     } catch (e) {
  //       emiratesDate = null; // or set to a default value
  //     }
  //   }

  //   return ProfileEditModel(
  //     customerId: prefs.getString('Customer_Id_') ?? '',
  //     customerName: prefs.getString('Customer_Name_') ?? '',
  //     mobile: prefs.getString('Mobile_') ?? '',
  //     email: prefs.getString('Email_') ?? 'gsanjayvkp000@gmail.com',
  //     contactName: prefs.getString('Contact_Name_') ?? '',
  //     companyName: prefs.getString('Company_Name_') ?? '',
  //     emiratesId: prefs.getString('emiratesId') ?? '',
  //     emiratesDate: emiratesDate ?? DateTime(1970, 1, 1),
  //     countryCodeName: prefs.getString('Country_Code_Name_') ?? '',
  //   );
  // }

  // Future<String> fetchUserEmail() async {
  //   ProfileEditModel profile = await fetchUserProfile();
  //   print('email:${profile.email}');
  //   return profile.email;
  // }

//method for getting exam failed trainee details
  Future<void> getExamFailedTraineeDetails(String trainingCid,
      String trainingCourseCategoryId, String orderDetailsId) async {
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "6";
    await HttpRequest.httpGetRequest(
      endPoint:
          '${HttpUrls.examFailedTraineeDetails}$trainingCid/$trainingCourseCategoryId/$customerId/$orderDetailsId',
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          examFailedTraineeDetails.clear();
          final examFailTraineeDetailsData = responseData[0] as List<dynamic>;
          examFailedTraineeDetails.value = examFailTraineeDetailsData
              .map((result) => ExamFailTraineeDetailsModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });

    update();
  }

//method for getting locations list
  Future<void> getLocationsList() async {
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "0";
    await HttpRequest.httpGetRequest(
        endPoint: HttpUrls.locationDetails,
        bodyData: {
          'Customer_Id_': customerId,
        }).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          locList.clear();
          if (responseData[0].isNotEmpty) {
            final locListData = responseData[0] as List<dynamic>;
            locList.value = locListData
                .map((result) => LocationListModel.fromJson(result))
                .toList();
            // print('hiiiis ${locList[0].locationName}');
            locList.insert(
                0,
                LocationListModel(
                    locationId: -1,
                    customerId: int.parse(customerId),
                    locationName: 'Custom',
                    link: '',
                    latitude: '',
                    longitude: '',
                    deleteStatus: 0,
                    nickname: ''));
          } else {
            locList.insert(
                0,
                LocationListModel(
                    locationId: -1,
                    customerId: int.parse(customerId),
                    locationName: 'Custom',
                    link: '',
                    latitude: '',
                    longitude: '',
                    deleteStatus: 0,
                    nickname: ''));
          }
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });

    update();
  }

  Future<void> getTrainerList() async {
    try {
      final response = await HttpRequest.httpGetRequest(
        endPoint: HttpUrls.getTrainerList,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          final returnValue = responseData['returnvalue'];
          if (returnValue is Map<String, dynamic> &&
              returnValue.containsKey('Leads')) {
            final leads = returnValue['Leads'] as List<dynamic>;

            trainerList.value =
                leads.map((result) => Lead.fromJson(result)).toList();
          } else {
            throw Exception('Key "Leads" not found in return value');
          }
        } else {
          throw Exception(
              'Unexpected response data type: ${responseData.runtimeType}');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error fetching trainer list: $e');
    } finally {
      update();
    }
  }

  Future<void> eligibilityData(int orderDetailsSubid, int index) async {
    await getTodayTask();
    await getTotalTraining();
    // await getTraineeDetails(
    //     trainingController.todayTasksLst[index].orderDetailsId.toString(),
    //     trainingController.todayTasksLst[index].orderLocationId.toString(),
    //     trainingController.todayTasksLst[index].examMasterId.toString());
    try {
      final response = await HttpRequest.httpGetRequest(
        endPoint: HttpUrls.eligibilityDetails + orderDetailsSubid.toString(),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          final returnValue = responseData['returnvalue'];

          if (returnValue is Map<String, dynamic> &&
              returnValue.containsKey('Leads')) {
            final eligible = returnValue['Leads'];

            if (eligible is List<dynamic>) {
              eligibilityDetails.clear();
              eligibilityDetails.value = eligible
                  .map((result) => EligibleModel.fromJson(result))
                  .toList();
              var eligibility =
                  response.data['returnvalue']['Leads'][0]['Eligibility'];
              if (eligibility == 0) {
                Get.offAll(() => EligibleExamPage(
                      model: todayTasksLst[index],
                    ));
              }
            } else {
              throw Exception(
                  'Expected List<dynamic> for "Leads", but got ${eligible.runtimeType}');
            }
          } else {
            throw Exception('Key "Leads" not found in return value');
          }
        } else {
          throw Exception(
              'Unexpected response data type: ${responseData.runtimeType}');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error fetching trainer list: $e');
    } finally {
      update();
    }
  }

  // Future<void> getFirstStartApp(String orderDetailsId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String customerId = prefs.getString('darlsco_id') ?? "6";
  //   await HttpRequest.httpGetRequest(
  //     endPoint: HttpUrls.getTraineesFirstApp + orderDetailsId,
  //   ).then((response) {
  //     if (response.statusCode == 200) {
  //       final responseData = response.data as List<dynamic>;
  //       if (responseData.isNotEmpty) {
  //         traineeDetailsStart.clear();
  //         final traineeDetailsStartData = responseData[0] as List<dynamic>;
  //         traineeDetailsStart.value = traineeDetailsStartData
  //             .map((result) => TraineeDetailsStart.fromJson(result))
  //             .toList();
  //       } else {
  //         throw Exception('Empty response data');
  //       }
  //     } else {
  //       throw Exception('Failed to load training data: ${response.statusCode}');
  //     }
  //   });

  //   update();
  // }

  //method for getting locations count
  Future<void> getLocationsCount(
      String orderDetailsId, String orderLocationId) async {
    final prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('darlsco_id') ?? "0";
    await HttpRequest.httpGetRequest(
      endPoint:
          '${HttpUrls.locationDetailsCount}$userId/$orderDetailsId/$orderLocationId',
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          locationCountDetails.clear();
          final locListCountData = responseData[0] as List<dynamic>;

          print('response ${responseData[1]}');
          locationCountDetails.value = locListCountData
              .map((result) => GetLocationCountModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });

    update();
  }

  getAddedTraineeDetails(String orderMasterId) async {
    viewAddTrainees.clear();
    final prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('darlsco_id') ?? "6";
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.viewAddTraineeDetails}$orderMasterId',
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          final viewAddTraineesData = responseData[1] as List<dynamic>;
          viewAddTrainees.value = viewAddTraineesData
              .map((result) =>
                  ViewAddTraineeDetailsModelElement.fromJson(result))
              .toList();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });

    update();
  }

  rescheduleExam(
      {required BuildContext context,
      required GetTodayTaskModel todaysExamDetails,
      required DateTime selectedDate,
      required String notes}) async {
    print('reschedule ');

    final prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('darlsco_id') ?? "0";
    // String formattedDate = selectedDate.toIso8601String();
    print('reschedule ');
    // Example JSON data
    Map<String, dynamic> jsonData = {
      'Exam_Reschedule_Id': 0,
      'Order_Location_Id': todaysExamDetails.orderLocationId,
      'Exam_Master_Id': todaysExamDetails.examMasterId,
      'Reschedule_Date': DateFormat('yyy-MM-dd').format(selectedDate),
      'Trainer_Id': userId,
      'Trainer_Name': todaysExamDetails.traineeName,
      'Notes': notes,
      // 'Reschedule Requested': todaysExamDetails.,
      'User_Id': userId,
      'Remarks': '',
    };

    await HttpRequest.httpPostBodyRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.rescheduleExam,
    ).then((response) async {
      if (response != null && response.statusCode == 200) {
        print(response);
        print("Successfull");

        await getTodayTask();
        Get.back();
      } else {
        print(response);
        print("Not Successfull");
      }
    });

    print('reschedule ');

    update();
  }

//after payment
  saveTraineeRetake(paymentStatus, totalPrice, orderMasterId) async {
    print('retake purchase bill $retakePurchaseBillDataList');
    trainingController.transactionFee =
        await trainingController.getTransactionFee();
    double grantTotal = 0.00;
    double subTotal = 0.00;
    double totalVat = 0.00;
    final prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('darlsco_id') ?? "0";
    trainingController.getTransactionFee();
    for (var i = 0;
        i < trainingController.retakePurchaseBillDataList.length;
        i++) {
      grantTotal +=
          trainingController.retakePurchaseBillDataList[i]['grant_total'];
      subTotal += double.parse(trainingController.retakePurchaseBillDataList[i]
              ['Amount']
          .toString());
      totalVat += double.parse(
          trainingController.retakePurchaseBillDataList[i]['Vat'].toString());
    }

    List traineeDataList = [];

    if (failedTraineesData.isNotEmpty) {
      traineeDataList = failedTraineesData
          .where((element) => element['is_selected'] == true)
          .toList();
    }

    print(
        'retake purchase bill ${trainingHomeController.examFailedTraineeDetails[0].orderMasterId}');

    Map<String, dynamic> jsonData = {
      "Order_Master_Id_": orderMasterId,
      "Customer_Id_": int.parse(userId),
      "Customer_Name_": "",
      "Training_Course_Id_": 0,
      "Training_Course_Category_Id_": 0,
      "Training_Order_Details_Data": traineeDataList,
      "Payment_Status_": paymentStatus,
      "Grand_Total_": tcontoller.totalPrice,
      "Sub_Total": subTotal,
      "Vat_Amount": totalVat,
      "Service_Charge_":
          (subTotal * double.parse(trainingController.transactionFee) / 100),
      "Vat_": double.tryParse(trainingController.transactionFee),
      "Service_Tax": double.tryParse(trainingController.transactionFee),
      "Service_Tax_Amount":
          (subTotal * double.parse(trainingController.transactionFee) / 100),
    };

    await HttpRequest.httpPostBodyRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.saveTraineeRetake,
    ).then((response) async {
      if (response != null) {
        print(response);
      } else {}
    });
  }

  // getFaildDetails() async {
  //   final prefs = await SharedPreferences.getInstance();
  //     } else {

  //     }
  //   });
  // }

  clearProfile() {
    trainingController.customerNameController.clear();
    trainingController.emailIDController.clear();
    trainingController.phoneNumberController.clear();
    trainingController.contactPersonController.clear();
    trainingController.emiratesIDController.clear();
    trainingController.tradeLicenceNoController.clear();
    trainingController.emiratesIdExpiryDateController.clear();
    trainingController.tradeLicenceExpiryDateController.clear();
  }

  getFaildDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('darlsco_id') ?? "0";

    await HttpRequest.httpGetRequest(
      bodyData: {
        "Customer_Id_": userId,
      },
      endPoint: HttpUrls.searchFaildDetailsApp,
    ).then((response) async {
      print(response.data);

      if (response.statusCode == 200) {
        final responseData =
            response.data['returnvalue']['Leads'] as List<dynamic>;
        if (responseData.isNotEmpty) {
          examFailedTraineeDetails.clear();
          final examFailTraineeDetailsData = responseData;
          examFailDetails.value = examFailTraineeDetailsData
              .map((result) => ExamFailDetailsModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });
    update();
  }

  getExamFailedOrderDetails({required int orederId}) async {
    final prefs = await SharedPreferences.getInstance();
    await HttpRequest.httpGetRequest(
      bodyData: {
        "Order_Master_Id_": orederId,
      },
      endPoint: HttpUrls.searchFailedDetailsTrainees,
    ).then((response) async {
      print(response.data);

      if (response.statusCode == 200) {
        final responseData =
            response.data['returnvalue']['Leads'] as List<dynamic>;
        if (responseData.isNotEmpty) {
          examFailedTraineeDetails.clear();
          final examFailTraineeDetailsData = responseData;
          examFailedTraineeDetails.value = examFailTraineeDetailsData
              .map((result) => ExamFailTraineeDetailsModel.fromJson(result))
              .toList();
          prefs.setString('transaction_fee',
              examFailedTraineeDetails[0].serviceCharge.toString());
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });
    update();
  }

  getTraineeDetailsByEmiratesId({
    required String emiratesId,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController dobController,
    required TextEditingController contactNumberController,
    required TextEditingController emailIdController,
    required TextEditingController employeeIdController,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    Dio dio = Dio();

    print('${HttpUrls.baseUrl}${HttpUrls.searchEmiratesId}/$emiratesId');
    await dio
        .get(
      '${HttpUrls.baseUrl}${HttpUrls.searchEmiratesId}/$emiratesId',
      options: Options(headers: {
        'ngrok-skip-browser-warning': 'true',
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      }),
    )
        .then((response) async {
      if (response.statusCode == 200) {
        print(response);

        if (response.data[0].isNotEmpty) {
          firstNameController.text =
              response.data[0][0]['Employee_Firstname'] ?? "";
          lastNameController.text =
              response.data[0][0]['Employee_Lastname'] ?? "";

          if (response.data[0][0]['DateofBirth'] != null &&
              response.data[0][0]['DateofBirth'] != '') {
            String formattedDate = DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(response.data[0][0]['DateofBirth']));
            DateTime parsedDate = DateTime.parse(formattedDate);
            String newDate = DateFormat('dd/MM/yyyy').format(parsedDate);
            dobController.text = newDate;
          } else {
            dobController.text = response.data[0][0]['DateofBirth'] ?? "";
          }

          contactNumberController.text = response.data[0][0]['MobileNo'] ?? "";
          emailIdController.text = response.data[0][0]['EmailId'] ?? "";

          employeeIdController.text = response.data[0][0]['Employee_Id'] ?? "";
        } else {
          // firstNameController.clear();
          // lastNameController.clear();
          // dobController.clear();
          // contactNumberController.clear();
          // emailIdController.clear();
          // employeeIdController.clear();
        }
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });
    update();
  }

  getTransactionFee() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    transactionFee = preferences.getString('transaction_fee') ?? '0';

    print('transaction feee $transactionFee');
    trainingHomeController.update();
    update();
    return transactionFee;
  }

  updateItemCartQuatity({
    required int itemCartId,
    required int quantity,
    required double amount,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    Dio dio = Dio();

    await dio.get('${HttpUrls.baseUrl}${HttpUrls.updateItemCartQuatity}',
        options: Options(headers: {
          'ngrok-skip-browser-warning': 'true',
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        queryParameters: {
          "Item_Cart_Id_": itemCartId,
          "Quantity_": quantity,
          "Amount_": amount,
        }).then((response) async {
      print(amount);
      if (response.statusCode == 200) {
        print(response);
      } else {
        throw Exception('Failed to load training data: ${response.statusCode}');
      }
    });
    update();
  }

//     void getSuggestion(String input) async {
//       final prefs = await SharedPreferences.getInstance();
//     final String token = prefs.getString('token') ?? "";

//   String kPLACES_API_KEY = "AIzaSyB0wqVQ46RiwJW4BuTH9IzhmPuBS74GD0Y";
//   String type = '(places)';
//   String baseURL =
//       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//   String request =
//       '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$token';
//   var response = await Dio().get(request);
//   if (response.statusCode == 200) {
//     print(response);

//     final  _placeList = json.decode(response.data.toString())['predictions'];
//     print('dfdfdfdfd$_placeList');

//   } else {
//     throw Exception('Failed to load predictions');
//   }
// // }
//   }
}
















  // contactFormValidation(String fNameTxt, String mobText, String emailTxt,
  //     String messageText, BuildContext context) {
  //   if (fNameTxt.isEmpty ||
  //       mobText.isEmpty ||
  //       emailTxt.isEmpty ||
  //       messageText.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('All  feilds are required!')));
  //     //api call
  //   } else if (!ContactUsValidation.fullNameValidation(fNameTxt)) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Invalid Full Name!')));
  //   } else if (!ContactUsValidation.mobileNumberValidation(mobText)) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Invalid Contact Number!')));
  //   } else if (!ContactUsValidation.emailValidation(emailTxt)) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Invalid Email!')));
  //   } else if (!ContactUsValidation.fullNameValidation(messageText)) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Message is required!')));
  //   } else {
  //     //api call

  //     // customerEnquiry(fNameTxt, mobText, emailTxt, messageText, context);
  //   }
  // }

