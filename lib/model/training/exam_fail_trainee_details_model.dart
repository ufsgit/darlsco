// To parse this JSON data, do
//
//     final examFailTraineeDetailsModel = examFailTraineeDetailsModelFromJson(jsonString);

import 'dart:convert';

List<ExamFailTraineeDetailsModel> examFailTraineeDetailsModelFromJson(
        String str) =>
    List<ExamFailTraineeDetailsModel>.from(
        json.decode(str).map((x) => ExamFailTraineeDetailsModel.fromJson(x)));

String examFailTraineeDetailsModelToJson(
        List<ExamFailTraineeDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExamFailTraineeDetailsModel {
  int examDetailsId;
  String traineeName;
  int traineeId;
  int orderDetailsId;
  int orderLocationId;
  int writenStatusId;
  String writenStatusName;
  int praticalStatusId;
  String praticalStatusName;
  int retakeCount;
  DateTime validity;
  String trainingCourseName;
  String locationName;
  String validityStatus;

  String subTotal;
  String vatAmount;
  String vatPercentage;
  

  String amount;

  String categoryName;

  int orderMasterId;
  int categoryId;
  int locationId;
  String serviceCharge;

  ExamFailTraineeDetailsModel({
    required this.examDetailsId,
    required this.traineeName,
    required this.traineeId,
    required this.orderDetailsId,
    required this.orderLocationId,
    required this.writenStatusId,
    required this.writenStatusName,
    required this.praticalStatusId,
    required this.praticalStatusName,
    required this.retakeCount,
    required this.validity,
    required this.serviceCharge,
   
    required this.locationId,
    required this.trainingCourseName,
    required this.locationName,
    required this.validityStatus,
    required this.categoryName,
    required this.subTotal,
    required this.amount,
    required this.vatAmount,
    required this.vatPercentage,
    required this.orderMasterId,
    required this.categoryId,
  });

  factory ExamFailTraineeDetailsModel.fromJson(Map<String, dynamic> json) =>
      ExamFailTraineeDetailsModel(
        examDetailsId: json["Exam_Details_Id"],
        traineeName: json["Trainee_Name"],
        locationId: json['Location_Id'],
        traineeId: json["Trainee_Id"],
        orderDetailsId: json["Order_Details_Id"],
        orderLocationId: json["Order_Location_Id"],
        writenStatusId: json["Writen_Status_Id"],
        writenStatusName: json["Writen_Status_Name"],
        praticalStatusId: json["Pratical_Status_Id"],
        praticalStatusName: json["Pratical_Status_Name"]??'',
        retakeCount: json["Retake_Count"],
        validity: DateTime.parse(json["Validity"]),
        trainingCourseName: json["Training_Course_Name"],
        locationName: json["Location_Name"],
        validityStatus: json["Validity_Status"],
        categoryName: json['Category_Name'],
        amount: json['Amount'] ?? '0',
        subTotal: json['Sub_Total'] ?? '0',
        vatAmount: json['Vat'] ?? '0',
        vatPercentage: json['Retake_Only_Written_Tax'] ?? '0',
        orderMasterId: int.parse(json['Order_Master_Id'].toString()),
        categoryId: int.parse(json['Training_Course_Category_Id'].toString()),
        serviceCharge: json['Service_Charge']??''
      );

  Map<String, dynamic> toJson() => {
        "Exam_Details_Id": examDetailsId,
        "Trainee_Name": traineeName,
        "Trainee_Id": traineeId,
        "Order_Details_Id": orderDetailsId,
        "Order_Location_Id": orderLocationId,
        "Writen_Status_Id": writenStatusId,
        "Writen_Status_Name": writenStatusName,
        "Pratical_Status_Id": praticalStatusId,
        "Pratical_Status_Name": praticalStatusName,
        "Retake_Count": retakeCount,
        "Validity":
            "${validity.year.toString().padLeft(4, '0')}-${validity.month.toString().padLeft(2, '0')}-${validity.day.toString().padLeft(2, '0')}",
        "Training_Course_Name": trainingCourseName,
        "Location_Name": locationName,
        "Validity_Status": validityStatus,
        "Category_Name": categoryName,
      };
}
