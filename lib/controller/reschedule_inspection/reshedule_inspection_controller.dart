import 'package:darlsco/controller/upcoming_inspections/upcoming_inspection_controller.dart';
import 'package:darlsco/http/http_request.dart';
import 'package:darlsco/http/http_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

ResheduleInspectionController resheduleInspectionController =
    Get.put(ResheduleInspectionController());

class ResheduleInspectionController extends GetxController {
  TextEditingController reschudleDateController = TextEditingController();

  TextEditingController rescheduleTimeContorller = TextEditingController();
  TextEditingController resonController = TextEditingController();
  RxBool isRescheduled = false.obs;

  saveCustomerReschedule(taskId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int customerId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');

    Map<String, dynamic> mapData = {
      "User_Id": customerId,
      'Task_Id': taskId,
      'Date':   DateFormat('yyyy-MM-dd').format(
                            DateFormat('dd-MM-yyyy').parse((  reschudleDateController.text)))    ,
      "Remark": resonController.text,
      "Time": resheduleInspectionController
                                .rescheduleTimeContorller.text,
    };

    await HttpRequest.httpPostRequest(
      bodyData: mapData,
      endPoint: HttpUrls.saveCustomerReschedule,
    ).then((value) async{
      if (value != null) {
        if (value.data.isNotEmpty) {
          reschudleDateController.clear();
          resonController.clear();
          rescheduleTimeContorller.clear();
          // homeController. inspectionLocationController.clear();
          //  homeController.inspectionMessageController.clear();
          //  homeController. inspectionCategoryController.clear();

          ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
              content:  Text(
                  'Re-Schedule request submitted successfully. Our team will contact you soon')));
         await  upcomingInspectionsController.getCustomerTask(isFromSplash: true);
          await HttpRequest.httpPostRequest(endPoint: HttpUrls.notificationUrlReschedule,
               bodyData: {
                'Notification_Id_':value.data[0]['Notification_Id_'],
                'Task_Reschedule_Id_':value.data[0]['Task_Reschedule_Id_'],
                'Task_Id_':value.data[0]['Task_Id_'],
                'Task_Name_':value.data[0]['Task_Name_'],
                'Notification_Type_Name_':value.data[0]['Notification_Type_Name_'],



               });
          Get.back();
        }
      }
    });
  }
}
