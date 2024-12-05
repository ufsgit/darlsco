import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/http/http_urls.dart';
import 'package:darlsco/view/widgets/loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getMain;
import 'package:shared_preferences/shared_preferences.dart';

bool isNetworkConnected = true;

class HttpRequest {
  static Future<Response> httpGetRequest(
      {Map<String, dynamic>? bodyData, String endPoint = ''}) async {
    // Loader.showLoader();
    if (kDebugMode) {
      print('Adeeb get request ====> $endPoint $bodyData ');
    }
    final Dio dio = Client().init();

    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    print('regrt $token');

    // String token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOnsiVXNlcl9EZXRhaWxzX0lkIjoxNTEsIlVzZXJfRGV0YWlsc19OYW1lIjoiQWRtaW4iLCJVc2VyX1R5cGUiOjEsIlJvbGVfSWQiOjMwLCJCcmFuY2hfSWQiOjQxLCJEZXBhcnRtZW50X0lkIjozNzAsIk5vdGlmaWNhdGlvbl9Db3VudCI6MCwiRXh0ZW5zaW9uIjoiMSIsIkRlcGFydG1lbnRfTmFtZSI6IkFETUlOIiwiVXBkYXRlZF9TZXJpYWxfSWQiOjc3fSwiaWF0IjoxNzEwODI0ODM2fQ.lupsZPLvOUe7EhV2qvZa7qt3ps-nnXrZqiAcwM_9dQo';
    var response;
    try {
      response = await dio.get(
        '${HttpUrls.baseUrl}$endPoint',
        options: Options(headers: {
          'ngrok-skip-browser-warning': 'true',
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        queryParameters: bodyData,
      );

      print('get result ====> ${dio.options}  ');

      if (kDebugMode) {
        print('get result ====> $response  ');
      }
      final connectivityResult = await Connectivity().checkConnectivity();

      print('connectivity $connectivityResult');
      if (connectivityResult[0] == ConnectivityResult.none) {
        print(connectivityResult);
      } else {
        print(connectivityResult);
      }
      print('dfnrsifiug ${response.statusCode}');
      print('dfnrsifiug ${response.data}');

      if (response.statusCode == 401 || response.data == null) {
        Loader.stopLoader();

        await loginController.logout(getMain.Get.context!);
        return response;
      }

      // Loader.stopLoader();
    } catch (e) {
      Loader.stopLoader();
      print('dfnrsifiug ${response}');
      print('dfnrsifiug ${response}');

      if (response == null) {
        Loader.stopLoader();

        await loginController.logout(getMain.Get.context!);
        return response;
      }
      if (e is DioException) {
        // Check for connection error (Failed host lookup, timeout, etc.)
        if (e.type == DioExceptionType.connectionError) {
          isNetworkConnected = false;
          ScaffoldMessenger.of(getMain.Get.context!)
              .showSnackBar(SnackBar(content: Text('Network Error')));
        }
      } else {
        print('ijoi An unknown error occurred: $e');
      }
    }
    return response;
  }

  static Future<Response> httpGetBodyRequest(
      {Map<String, dynamic>? bodyData, String endPoint = ''}) async {
    Loader.showLoader();
    if (kDebugMode) {
      print('get request ====> $endPoint $bodyData ');
    }
    final Dio dio = Client().init();
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    // String token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOnsiVXNlcl9EZXRhaWxzX0lkIjoxNTEsIlVzZXJfRGV0YWlsc19OYW1lIjoiQWRtaW4iLCJVc2VyX1R5cGUiOjEsIlJvbGVfSWQiOjMwLCJCcmFuY2hfSWQiOjQxLCJEZXBhcnRtZW50X0lkIjozNzAsIk5vdGlmaWNhdGlvbl9Db3VudCI6MCwiRXh0ZW5zaW9uIjoiMSIsIkRlcGFydG1lbnRfTmFtZSI6IkFETUlOIiwiVXBkYXRlZF9TZXJpYWxfSWQiOjc3fSwiaWF0IjoxNzEwODI0ODM2fQ.lupsZPLvOUe7EhV2qvZa7qt3ps-nnXrZqiAcwM_9dQo';
    var response;
    try {
      response = await dio.get(
        '${HttpUrls.baseUrl}$endPoint',
        options: Options(headers: {
          'ngrok-skip-browser-warning': 'true',
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: jsonEncode(bodyData),
      );
      if (kDebugMode) {
        print('get result ====> $response  ');
      }
      if (response.data != null) {
        Loader.stopLoader();
      }
      print('dfnrsifiug ${response.statusCode}');
      print('dfnrsifiug ${response.data}');

      if (response.statusCode == 401 || response.data == null) {
        loginController.logout(getMain.Get.context!);
        return response;
      }
      return response;
    } catch (e) {
      Loader.stopLoader();
      print('dfnrsifiug ${response.statusCode}');
      print('dfnrsifiug ${response.data}');

      return response;
    }
  }

  static Future<Response?> httpPostRequest(
      {Map<String, dynamic>? bodyData,
      String endPoint = '',
      isBody = false}) async {
    Loader.showLoader();
    if (kDebugMode) {
      print('post request ====> $endPoint $bodyData ');
    }
    final Dio dio = Client().init();
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    try {
      final Response response = await dio.post(
        '${HttpUrls.baseUrl}$endPoint',
        options: Options(headers: {
          'ngrok-skip-browser-warning': 'true',
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        queryParameters: bodyData,
      );
      if (kDebugMode) {
        print('post result ====> ${response.data}  ');
      }

      Loader.stopLoader();
      print('dfnrsifiug ${response.statusCode}');
      print('dfnrsifiug ${response.data}');

      print('dfnrsifiug ${response.statusCode}');
      print('dfnrsifiug ${response.data}');

      return response;
    } catch (e) {
      Loader.stopLoader();
      return null;
    }
  }

  static Future<Response?> httpPostBodyRequest(
      {Map<String, dynamic>? bodyData, String endPoint = ''}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    print('print token $token');
    Loader.showLoader();
    if (kDebugMode) {
      print('post request ====> $endPoint $bodyData ');
    }
    final Dio dio = Client().init();

    try {
      final Response response = await dio.post(
        '${HttpUrls.baseUrl}$endPoint',
        options: Options(headers: {
          'ngrok-skip-browser-warning': 'true',
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: bodyData,
      );
      Loader.stopLoader();

      if (kDebugMode) {
        print('post result ====> ${response.data}  ');
      }
      print('dfnrsifiug ${response.statusCode}');
      print('dfnrsifiug ${response.data}');

      print('dfnrsifiug ${response.statusCode}');
      print('dfnrsifiug ${response.data}');

      return response;
    } catch (e) {
      print(e);

      Loader.stopLoader();
      return null;
    }
  }

  static Future<Response?> httpPostDataRequest(
      {Map<String, dynamic>? bodyData, String endPoint = ''}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    // String token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOnsiVXNlcl9EZXRhaWxzX0lkIjoxNTEsIlVzZXJfRGV0YWlsc19OYW1lIjoiQWRtaW4iLCJVc2VyX1R5cGUiOjEsIlJvbGVfSWQiOjMwLCJCcmFuY2hfSWQiOjQxLCJEZXBhcnRtZW50X0lkIjozNzAsIk5vdGlmaWNhdGlvbl9Db3VudCI6MCwiRXh0ZW5zaW9uIjoiMSIsIkRlcGFydG1lbnRfTmFtZSI6IkFETUlOIiwiVXBkYXRlZF9TZXJpYWxfSWQiOjc3fSwiaWF0IjoxNzEwODI0ODM2fQ.lupsZPLvOUe7EhV2qvZa7qt3ps-nnXrZqiAcwM_9dQo';
    Loader.showLoader();
    if (kDebugMode) {
      print('post request ====> $endPoint $bodyData ');
    }
    final Dio dio = Client().init();

    try {
      final Response response = await dio.post(
        '${HttpUrls.baseUrl}$endPoint',
        options: Options(headers: {
          'ngrok-skip-browser-warning': 'true',
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        queryParameters: bodyData,
      );
      Loader.stopLoader();

      if (kDebugMode) {
        print('post result ====> ${response.data}  ');
      }
      print('dfnrsifiug ${response.statusCode}');
      print('dfnrsifiug ${response.data}');

      print('dfnrsifiug ${response.statusCode}');
      print('dfnrsifiug ${response.data}');

      return response;
    } catch (e) {
      Loader.stopLoader();
      return null;
    }
  }
}

class Client {
  Dio init() {
    print(';dfsdf');
    final Dio dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('options ioi ${options.data}');
          // Add the access token to the request header
          return handler.next(options);
        },
        onError: (DioError e, handler) async {
          if (e.type == DioExceptionType.connectionError) {
            isNetworkConnected = false;

            ScaffoldMessenger.of(getMain.Get.context!)
                .showSnackBar(SnackBar(content: Text('Network Error')));
          }
          if (e.response?.statusCode == 401) {
            await loginController.logout(getMain.Get.context!);
          }
        },
      ),
    );
    return dio;
  }
}
