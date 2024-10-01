// To parse this JSON data, do
//
//     final rescheduleDateModel = rescheduleDateModelFromJson(jsonString);

import 'dart:convert';

RescheduleDateModel rescheduleDateModelFromJson(String str) => RescheduleDateModel.fromJson(json.decode(str));

String rescheduleDateModelToJson(RescheduleDateModel data) => json.encode(data.toJson());

class RescheduleDateModel {
    int rescheduleCourseId;
    int orderDetailsSubId;
    int trainingCourseId;
    int trainingCourseCategoryId;
    String trainingCourseName;
    String categoryName;
    DateTime rescheduleDate;
    String rescheduleTime;
    int trainerId;
    String trainerName;
    String notes;
    int currentStatusId;
    String currentStatusName;
    int userId;
    String remarks;
    int quantity;

    RescheduleDateModel({
        required this.rescheduleCourseId,
        required this.orderDetailsSubId,
        required this.trainingCourseId,
        required this.trainingCourseCategoryId,
        required this.trainingCourseName,
        required this.categoryName,
        required this.rescheduleDate,
        required this.rescheduleTime,
        required this.trainerId,
        required this.trainerName,
        required this.notes,
        required this.currentStatusId,
        required this.currentStatusName,
        required this.userId,
        required this.remarks,
        required this.quantity,
    });

    factory RescheduleDateModel.fromJson(Map<String, dynamic> json) => RescheduleDateModel(
        rescheduleCourseId: json["Reschedule_Course_Id_"],
        orderDetailsSubId: json["Order_Details_Sub_Id_"],
        trainingCourseId: json["Training_Course_Id_"],
        trainingCourseCategoryId: json["Training_Course_Category_Id_"],
        trainingCourseName: json["Training_Course_Name_"],
        categoryName: json["Category_Name_"],
        rescheduleDate: DateTime.parse(json["Reschedule_Date_"]),
        rescheduleTime: json["Reschedule_Time_"],
        trainerId: json["Trainer_Id_"],
        trainerName: json["Trainer_Name_"],
        notes: json["Notes_"],
        currentStatusId: json["Current_Status_Id_"],
        currentStatusName: json["Current_Status_Name_"],
        userId: json["User_Id_"],
        remarks: json["Remarks_"],
        quantity: json["Quantity_"],
    );

    Map<String, dynamic> toJson() => {
        "Reschedule_Course_Id_": rescheduleCourseId,
        "Order_Details_Sub_Id_": orderDetailsSubId,
        "Training_Course_Id_": trainingCourseId,
        "Training_Course_Category_Id_": trainingCourseCategoryId,
        "Training_Course_Name_": trainingCourseName,
        "Category_Name_": categoryName,
        "Reschedule_Date_": rescheduleDate.toIso8601String(),
        "Reschedule_Time_": rescheduleTime,
        "Trainer_Id_": trainerId,
        "Trainer_Name_": trainerName,
        "Notes_": notes,
        "Current_Status_Id_": currentStatusId,
        "Current_Status_Name_": currentStatusName,
        "User_Id_": userId,
        "Remarks_": remarks,
        "Quantity_": quantity,
    };
}
