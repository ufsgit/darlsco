class GetTodayTaskModel {
  int customerId;
  int orderDetailsId;
  int orderMasterId;
  int examMasterId;
  int orderLocationId;
  int trainingCourseId;
  int trainingCourseCategoryId;
  String trainingCourseName;
  String categoryName;
  String actualSatrtTime;
  String actualendTime;
  String duration;
  int trainerId;
  int orderDetailsSubId;
  int locationId;
  String traineeName;
  String locationName;
  int remainingDaysCount;
  String customerName;
  String type;
  String statusId;
  String statusName;
  String traineeId;
  String startTime;
  String endTime;
  String eligibilityMarked;

  // String eligibility;

  GetTodayTaskModel({
    required this.eligibilityMarked,
    required this.customerId,
    required this.orderDetailsId,
    required this.orderLocationId,
    required this.orderMasterId,
    required this.trainingCourseId,
    required this.trainingCourseCategoryId,
    required this.trainingCourseName,
    required this.categoryName,
    required this.actualSatrtTime,
    required this.startTime,

    


    required this.endTime,
    required this.actualendTime,
    required this.duration,
    required this.trainerId,
    required this.traineeName,
    required this.orderDetailsSubId,
    required this.locationId,
    required this.locationName,
    required this.remainingDaysCount,
    required this.customerName,
    required this.type,
    required this.examMasterId,
    required this.statusId,
    required this.statusName,
    required this.traineeId,

    // required this.eligibility,
  });

  factory GetTodayTaskModel.fromJson(Map<String, dynamic> json) =>
      GetTodayTaskModel(
        eligibilityMarked: json["Eligibility_Marked"],
        customerId: json["Customer_Id"] ?? 0,
        orderDetailsId: json["Order_Details_Id"] ?? 0,
        orderMasterId: json["Order_Master_Id"] ?? 0,
        orderLocationId: json["Order_Location_Id"] ?? 0,
        examMasterId: json["Exam_Master_Id"] ?? 0,
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        trainingCourseName: json["Training_Course_Name"],
        categoryName: json["Category_Name"]??'',
        startTime: json["Start_Time"] ?? '',
        endTime: json["End_Time"] ?? '',
        duration: json["Duration"] ?? '',
        trainerId: json["Trainer_Id"] ?? 0,
        traineeName: json["Trainee_Name"] ?? 'trainer 1',
        orderDetailsSubId: json["Order_Details_Sub_Id"] ?? 0,
        locationId: json["Location_Id"] ?? 0,
        locationName: json["Location_Name"] ?? '',
        remainingDaysCount: json["Remaining_days_count"] ?? 0,
        customerName: json["Customer_Name"] ?? '',
        type: json["tp"] ?? '',
        statusId: json['Status_Id'].toString(),
        statusName: json['Status_Name'] ?? '',
        traineeId: json['Trainee_Details_Id'] ?? '0',
        actualSatrtTime: json['Expected_Start_Time']??'',
        actualendTime: json['Expected_End_Time']??'',

        // eligibility: json["Eligibility"],
      );

  Map<String, dynamic> toJson() => {
        "Customer_Id": customerId,
        "Order_Details_Id": orderDetailsId,
        "Order_Master_Id": orderMasterId,
        "Order_Location_Id": orderLocationId,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Training_Course_Name": trainingCourseName,
        "Category_Name": categoryName,
        "Start_Time": startTime,
        "End_Time": endTime,
        "Duration": duration,
        "Trainer_Id": trainerId,
        "Trainee_Name": traineeName,
        "Order_Details_Sub_Id": orderDetailsSubId,
        "Location_Id": locationId,
        "Location_Name": locationName,
        "Remaining_days_count": remainingDaysCount,
        "Customer_Name": customerName,
        "tp": type, // "Eligibility": eligibility,
        "Exam_Master_Id": examMasterId,
      };
}

class PurpleGetTodayTaskModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleGetTodayTaskModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleGetTodayTaskModel.fromJson(Map<String, dynamic> json) =>
      PurpleGetTodayTaskModel(
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
