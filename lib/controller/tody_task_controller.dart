import 'package:darlsco/model/training/get_trainee_details_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/http_request.dart';
import '../http/http_urls.dart';
import '../model/training/count_model.dart';
import '../model/training/get_today_task_model.dart';

class TodayTaskController extends GetxController {
  var todayTasksLst = <GetTodayTaskModel>[].obs;

  var traineeAttendanceList = <GetTraineeDetailModel>[].obs;
  var taskPageCount = <CountModel>[].obs;
  var attendanceTime = ''.obs;

  // Future<void> fetchTaskCount() async {
  //   taskPageCount.clear();
  //   print('calling...........................');
  //   final prefs = await SharedPreferences.getInstance();
  //   final String customerId = prefs.getString('darlsco_id') ?? "";
  //   await HttpRequest.httpGetRequest(endPoint: HttpUrls.getCount + customerId)
  //       .then((response) {
  //     if (response.statusCode == 200) {
  //       final responseData = response.data as List<dynamic>;
  //       if (responseData.isNotEmpty) {
  //         final countDataList = responseData[0] as List<dynamic>;
  //         print(countDataList);
  //         final count = CountModel.fromJson(countDataList[0]);
  //         print(count);
  //         taskPageCount.add(count);
  //         print(taskPageCount);
  //       } else {
  //         throw Exception('Empty response data');
  //       }
  //     } else {
  //       throw Exception('Failed to load tasks count: ${response.statusCode}');
  //     }
  //   });

  //   update();
  // }
  Future<void> fetchTaskCount() async {
    print('calling...........................');
    final prefs = await SharedPreferences.getInstance();
    final String customerId = prefs.getString('darlsco_id') ?? "";

    try {
      final response = await HttpRequest.httpGetRequest(
          endPoint: HttpUrls.getCount + customerId);

      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          final countDataList = responseData[0] as List<dynamic>;
          print(countDataList);
          final List<CountModel> counts =
              countDataList.map((data) => CountModel.fromJson(data)).toList();

          taskPageCount.value = counts;

          print(taskPageCount);
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load tasks count: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching task count: $error');
    }
  }

  getTodayTaskList() async {
    todayTasksLst.clear();
    final prefs = await SharedPreferences.getInstance();
    final String staffId = prefs.getString('darlsco_id') ?? "";
    await HttpRequest.httpGetRequest(endPoint: HttpUrls.getTodayTask + staffId)
        .then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        print(responseData);
        if (responseData.isNotEmpty) {
          final todayTaskList = responseData[0] as List<dynamic>;
          todayTasksLst.value = todayTaskList
              .map((result) => GetTodayTaskModel.fromJson(result))
              .toList();
          print('todays task from api   $todayTasksLst');

          update();
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to load today tasks: ${response.statusCode}');
      }
    });
    update();
  }

  startExamOrTrainging(
      {required String orderDetailsSubId, required String examMasterId}) async {
    final prefs = await SharedPreferences.getInstance();
    final String staffId = prefs.getString('darlsco_id') ?? "";

    Map<String, dynamic> mapData = {
      "Order_Details_Sub_Id_": orderDetailsSubId,
      "User_Id_": staffId,
      "Exam_Master_Id_": examMasterId
    };

    await HttpRequest.httpPostBodyRequest(
            endPoint: HttpUrls.startExamOrTrainging, bodyData: mapData)
        .then((response) async {
      await getTodayTaskList();

      print('result success');
    });
  }

  Future<void> getTraineeAttendanceDetails(
    String orderDetailsId,
    String orderLocationId,
    String examMasterId,
  ) async {
    traineeAttendanceList.clear();
    // final prefs = await SharedPreferences.getInstance();
    // final String customerId = prefs.getString('darlsco_id') ?? "";
    await HttpRequest.httpGetRequest(
      endPoint:
          '${HttpUrls.getTraineeDetails + orderDetailsId}/$orderLocationId/$examMasterId',
    ).then((response) {
      if (response.statusCode == 200) {
        final responseData = response.data as List<dynamic>;
        if (responseData.isNotEmpty) {
          final traineeDetailsData = responseData[0] as List<dynamic>;
          traineeAttendanceList.value = traineeDetailsData
              .map((result) => GetTraineeDetailModel.fromJson(result))
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


}
