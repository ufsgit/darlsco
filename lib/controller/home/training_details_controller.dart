// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:darlsco/http/http_urls.dart';
// import 'package:darlsco/model/home/category_select_model.dart';
// import 'package:darlsco/model/home/details_course_model.dart';
// import 'package:darlsco/model/home/profile_model.dart';
// import 'package:darlsco/model/home/traing_course_model.dart';
// import 'package:darlsco/model/training/add_to_cart_model.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
// import 'package:darlsco/http/http_request.dart';

// class TrainingHomeController extends GetxController {
//   @override
//   void onInit() {
//     initState();
//     // TODO: implement onInit
//     super.onInit();
//   }

//   var trainingData = <TrainingHomeModel>[];
//   var getItemDetailsData = <TrainingCourseDetailElement>[];
//   List catdisplay = [];
//   var selectedCategory = Rx<CategorySelectModelElement?>(null);
//   var selectCategory = ''.obs;
//   var isLoading = true.obs;
//   var priceList;
//   Dio dio = Dio();
//   Future<String?> _getId() async {
//     var deviceInfo = DeviceInfoPlugin();
//     if (Platform.isIOS) {
//       var iosDeviceInfo = await deviceInfo.iosInfo;
//       return iosDeviceInfo.identifierForVendor;
//     } else if (Platform.isAndroid) {
//       var androidDeviceInfo = await deviceInfo.androidInfo;
//       return androidDeviceInfo.id;
//     }
//     return null;
//   }

//   static String token =
//       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOnsiVXNlcl9EZXRhaWxzX0lkIjoxNTEsIlVzZXJfRGV0YWlsc19OYW1lIjoiQWRtaW4iLCJVc2VyX1R5cGUiOjEsIlJvbGVfSWQiOjMwLCJCcmFuY2hfSWQiOjQxLCJEZXBhcnRtZW50X0lkIjozNzAsIk5vdGlmaWNhdGlvbl9Db3VudCI6MCwiRXh0ZW5zaW9uIjoiMSIsIkRlcGFydG1lbnRfTmFtZSI6IkFETUlOIiwiVXBkYXRlZF9TZXJpYWxfSWQiOjc3fSwiaWF0IjoxNzEwODI0ODM2fQ.lupsZPLvOUe7EhV2qvZa7qt3ps-nnXrZqiAcwM_9dQo';

//   String trainingCourseId = '';

//   void initState() {
//     // fetchTrainingHomeData();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       fetchTrainingHomeData();
//       fetchDataCourse();
//     });

//     super.onInit();
//   }

//   void fetchTrainingHomeData() async {
//     await HttpRequest.httpGetRequest(
//       endPoint: HttpUrls.getTrainingCourse,
//     ).then((response) {
//       if (response.statusCode == 200) {
//         final responseData = response.data as List<dynamic>;
//         final trainingDataList = responseData[0] as List<dynamic>;
//         trainingData = trainingDataList
//             .map((result) => TrainingHomeModel.fromJson(result))
//             .toList();
//       } else {
//         throw Exception('Failed to load training data: ${response.statusCode}');
//       }
//     });

//     update();
//   }

//   void fetchDataCourse() async {
//     await HttpRequest.httpGetRequest(
//       endPoint: HttpUrls.getTrainingCourse,
//     ).then((response) {
//       if (response.statusCode == 200) {
//         final responseData = response.data as List<dynamic>;
//         final courseDataList = responseData[0] as List<dynamic>;
//         final results = courseDataList
//             .map((result) => TrainingCourseDetailElement.fromJson(result))
//             .toList();
//         getItemDetailsData.assignAll(results);
//       } else {
//         throw Exception('Failed to load training data: ${response.statusCode}');
//       }
//     });

//     update();
//   }

//   updateSelectedCategory(String categoryName) {
//     selectCategory.value = categoryName;
//     print('Selected Category: $categoryName'); // Print the selected category
//   }

//   void fetchCategoryData(String trainingCourseId) async {
//     await HttpRequest.httpGetRequest(
//             endPoint: '${HttpUrls.getItemDetails}/$trainingCourseId')
//         .then((response) {
//       if (response.statusCode == 200) {
//         List responseData = response.data[1];
//         print('${responseData}');
//         catdisplay = responseData
//             .map((result) => CategorySelectModelElement.fromJson(result))
//             .toList();
//         print('mapp json ${catdisplay[1].categoryName}');

//         update();
//       } else {
//         throw Exception('Failed to load category data: ${response.statusCode}');
//       }
//     });

//     update(['category']);
//   }

//   updatePrice(double price) {
//     priceList = price;
//     print('Updated price: $price');
//     update();
//   }

//   void addProfileEdit(ProfileEditModel profileEditModel) async {
//     Map<String, dynamic> jsonData = {
//       "Customer_Id_": profileEditModel.customerId,
//       "Customer_Name_": profileEditModel.customerName,
//       "Mobile_": profileEditModel.mobile,
//       "Email_": profileEditModel.email,
//       "Contact_Name_": profileEditModel.contactName,
//       "Company_Name_": profileEditModel.companyName,
//       "Emirates_Id_": profileEditModel.emiratesId,
//       "Emirates_Date_": profileEditModel.emiratesDate.toIso8601String(),
//       "Country_Code_Name_": profileEditModel.countryCodeName,
//     };

//     await HttpRequest.httpPostRequest(
//       bodyData: jsonData,
//       endPoint: HttpUrls.saveProfile,
//     ).then((response) {
//       if (response != null && response.statusCode == 200) {
//         print(response);
//         print("Successfull");
//       } else {
//         print(response);
//         print("Not Successfull");
//       }
//     });

//     update();
//   }

//   void addTocart(AddCart item) async {
//     String? deviceId = await _getId();
//     print(deviceId);
//     Map<String, dynamic> jsonData = {
//       "Device_Id_": deviceId,
//       "User_Id_": item.userId,
//       "Training_Course_": item.trainingCourse
//           .map(
//             (e) => {
//               "Description": e.description,
//               "Training_Course_Id": e.trainingCourseId,
//               "Training_Course_Name": e.trainingCourseName,
//               "Training_Course_Category_Id": e.trainingCourseCategoryId,
//               "Category_Name": e.categoryName,
//               "Quantity": e.quantity,
//               "Price": e.price,
//               "Amount": e.amount,
//               "File_Name": e.fileName,
//               "Image_Name": e.imageName,
//             },
//           )
//           .toList()
//     };
//     await HttpRequest.httpPostRequest(
//       bodyData: jsonData,
//       endPoint: HttpUrls.saveToCart,
//     ).then((response) {
//       if (response != null && response.statusCode == 200) {
//         print(response);
//         print("Successfull");
//       } else {
//         print(response);
//         print("Not Successfull");
//       }
//     });

//     update();
//   }

// // Display names only if selectedCategory is not null
// void displayCategoryNames() {
//   if (selectedCategory.value != null) {
//     for (var category in categoryDataList) {
//       print(category.categoryName);
//     }
//   }
// }
// void handleCategorySelection(CategorySelectModelElement? selectedCategory) {
//   // Assign the selected category to the selectedCategory property
//   this.selectedCategory.value = selectedCategory;
//   // Add any additional logic here, such as updating other UI elements or making API calls

//   // Example: Print the selected category name
//   if (selectedCategory != null) {
//     print('Selected category: ${selectedCategory.categoryName}');
//   }
// }

  // void addTocart(TrainingCourse item) async {
  //   try {
  //     var response = await Dio().post(
  //       TrainingHttpUrls.baseUrl + TrainingHttpUrls.saveToCart,
  //       data: {
  //         "Description": item.description,
  //         "Training_Course_Id": item.trainingCourseId,
  //         "Training_Course_Name": item.trainingCourseName,
  //         "Training_Course_Category_Id": item.trainingCourseCategoryId,
  //         "Category_Name": item.categoryName,
  //         "Quantity": item.quantity,
  //         "Price": item.price,
  //         "Amount": item.amount,
  //         "File_Name": item.fileName,
  //         "Image_Name": item.imageName,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       log('Success');
  //     } else {
  //       throw Exception('Error ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     throw Exception('Error: $e');
  //   }
  // }
// }
