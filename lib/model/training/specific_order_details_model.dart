// To parse this JSON data, do
//
//     final specificOrderDetailsModel = specificOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

SpecificOrderDetailsModel specificOrderDetailsModelFromJson(String str) => SpecificOrderDetailsModel.fromJson(json.decode(str));

String specificOrderDetailsModelToJson(SpecificOrderDetailsModel data) => json.encode(data.toJson());

class SpecificOrderDetailsModel {
    int orderDetailsId;
    int trainingCourseCategoryId;
    String categoryName;
    String trainingwithExamFees;
    String retakeOnlyWritenFess;
    String retakeOnlyPracticalFees;
    String applicationFees;
    
    String examinationFees;
    String certificateFees;
    int quantity;
    int statusId;
    String statusName;
    int trainingTypeId;
    String trainingTypeName;
    String totalAmount;
    int trainingCourseId;
    String trainingCourseName;
    String fileName;
    String duration;
    String orderNo;
    int orderMasterId;
    int orderLocationId;
    String orderLocationName;
    String startTime;
    String endTime;

    SpecificOrderDetailsModel({
        required this.orderDetailsId,
        required this.trainingCourseCategoryId,
        required this.categoryName,
        required this.trainingwithExamFees,
        required this.retakeOnlyWritenFess,
        required this.retakeOnlyPracticalFees,
        required this.applicationFees,
        required this.examinationFees,
        required this.certificateFees,
        required this.quantity,
        required this.statusId,
        required this.statusName,
        required this.trainingTypeId,
        required this.trainingTypeName,
        required this.totalAmount,
        required this.trainingCourseId,
        required this.trainingCourseName,
        required this.fileName,
        required this.duration,
       required this.orderNo,
       required this.orderMasterId,
       required this.orderLocationId,
       required this.orderLocationName,
       required this.startTime,
       required this.endTime,
    });

    factory SpecificOrderDetailsModel.fromJson(Map<String, dynamic> json) => SpecificOrderDetailsModel(
        orderDetailsId: json["Order_Details_Id"]??0,
        trainingCourseCategoryId: json["Training_Course_Category_Id"]??0,
        categoryName: json["Category_Name"]??'',
        trainingwithExamFees: json["TrainingwithExam_Fees"]??'',
        retakeOnlyWritenFess: json["RetakeOnly_Writen_Fess"]??'',
        retakeOnlyPracticalFees: json["RetakeOnly_Practical_Fees"]??'',
        applicationFees: json["Application_Fees"]??'',
        examinationFees: json["Examination_Fees"]??'',
        certificateFees: json["Certificate_Fees"]??'',
        quantity: json["Quantity"]??0,
        statusId: json["Status_Id"]??0,
        statusName: json["Status_Name"]??'',
        trainingTypeId: json["Training_Type_Id"]??0,
        trainingTypeName: json["Training_Type_Name"]??'',
        totalAmount: json["Total_Amount"]??'',
        trainingCourseId: json["Training_Course_Id"]??'',
        trainingCourseName: json["Training_Course_Name"]??'',
        fileName: json["File_Name"]??'',
        duration: json["Duration"]??"",
        orderNo: json['Order_No']??'',
        orderMasterId: json['Order_Master_Id']??0,
        orderLocationId: json['Order_Location_Id']??0,
        orderLocationName: json['Location_Name']??'',
        startTime: json['Start_Time']??'',
        endTime: json['End_Time']??'',

        
    );

    Map<String, dynamic> toJson() => {
        "Order_Details_Id": orderDetailsId,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "TrainingwithExam_Fees": trainingwithExamFees,
        "RetakeOnly_Writen_Fess": retakeOnlyWritenFess,
        "RetakeOnly_Practical_Fees": retakeOnlyPracticalFees,
        "Application_Fees": applicationFees,
        "Examination_Fees": examinationFees,
        "Certificate_Fees": certificateFees,
        "Quantity": quantity,
        "Status_Id": statusId,
        "Status_Name": statusName,
        "Training_Type_Id": trainingTypeId,
        "Training_Type_Name": trainingTypeName,
        "Total_Amount": totalAmount,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "File_Name": fileName,
        "Duration": duration,
    };
}
