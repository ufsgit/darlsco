// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

List<dynamic> attendanceModelFromJson(String str) => List<dynamic>.from(json.decode(str).map((x) => x));

String attendanceModelToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

class AttendanceModelElement {
    int? attendanceStatusId;
    String? attendanceStatusName;
    int? examStatusId;
    String? examStatusName;
    int? paymentStatusId;
    String? paymentStatusName;

    AttendanceModelElement({
        this.attendanceStatusId,
        this.attendanceStatusName,
        this.examStatusId,
        this.examStatusName,
        this.paymentStatusId,
        this.paymentStatusName,
    });

    factory AttendanceModelElement.fromJson(Map<String, dynamic> json) => AttendanceModelElement(
        attendanceStatusId: json["Attendance_Status_Id"],
        attendanceStatusName: json["Attendance_Status_Name"],
        examStatusId: json["Exam_Status_Id"],
        examStatusName: json["Exam_Status_Name"],
        paymentStatusId: json["Payment_Status_Id"],
        paymentStatusName: json["Payment_Status_Name"],
    );

    Map<String, dynamic> toJson() => {
        "Attendance_Status_Id": attendanceStatusId,
        "Attendance_Status_Name": attendanceStatusName,
        "Exam_Status_Id": examStatusId,
        "Exam_Status_Name": examStatusName,
        "Payment_Status_Id": paymentStatusId,
        "Payment_Status_Name": paymentStatusName,
    };
}

class PurpleAttendanceModel {
    int fieldCount;
    int affectedRows;
    int insertId;
    String info;
    int serverStatus;
    int warningStatus;

    PurpleAttendanceModel({
        required this.fieldCount,
        required this.affectedRows,
        required this.insertId,
        required this.info,
        required this.serverStatus,
        required this.warningStatus,
    });

    factory PurpleAttendanceModel.fromJson(Map<String, dynamic> json) => PurpleAttendanceModel(
        fieldCount: json["fieldCount"],
        affectedRows: json["affectedRows"],
        insertId: json["insertId"],
        info: json["info"],
        serverStatus: json["serverStatus"],
        warningStatus: json["warningStatus"],
    );

    Map<String, dynamic> toJson() => {
        "fieldCount": fieldCount,
        "affectedRows": affectedRows,
        "insertId": insertId,
        "info": info,
        "serverStatus": serverStatus,
        "warningStatus": warningStatus,
    };
}
