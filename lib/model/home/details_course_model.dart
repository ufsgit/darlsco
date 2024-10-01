// To parse this JSON data, do
//
//     final trainingCourseDetails = trainingCourseDetailsFromJson(jsonString);

import 'dart:convert';

List<dynamic> trainingCourseDetailsFromJson(String str) => List<dynamic>.from(json.decode(str).map((x) => x));

String trainingCourseDetailsToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

class TrainingCourseDetailElement {
    int trainingCourseId;
    String trainingCourseName;
    String description;
    String? fileName;
    dynamic imageName;
    int statusId;
    String statusName;
    int deleteStatus;

    TrainingCourseDetailElement({
        required this.trainingCourseId,
        required this.trainingCourseName,
        required this.description,
        required this.fileName,
        required this.imageName,
        required this.statusId,
        required this.statusName,
        required this.deleteStatus,
    });

    factory TrainingCourseDetailElement.fromJson(Map<String, dynamic> json) => TrainingCourseDetailElement(
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        description: json["Description"],
        fileName: json["File_Name"],
        imageName: json["Image_name"],
        statusId: json["Status_Id"],
        statusName: json["Status_Name"],
        deleteStatus: json["DeleteStatus"],
    );

    Map<String, dynamic> toJson() => {
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Description": description,
        "File_Name": fileName,
        "Image_name": imageName,
        "Status_Id": statusId,
        "Status_Name": statusName,
        "DeleteStatus": deleteStatus,
    };
}

class PurpleTrainingCourseDetail {
    int fieldCount;
    int affectedRows;
    int insertId;
    String info;
    int serverStatus;
    int warningStatus;

    PurpleTrainingCourseDetail({
        required this.fieldCount,
        required this.affectedRows,
        required this.insertId,
        required this.info,
        required this.serverStatus,
        required this.warningStatus,
    });

    factory PurpleTrainingCourseDetail.fromJson(Map<String, dynamic> json) => PurpleTrainingCourseDetail(
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