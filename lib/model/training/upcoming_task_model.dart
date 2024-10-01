class UpComingTaskModel {
  int orderDetailsId;
  int trainingCourseId;
  String trainingCourseName;
  int trainingCourseCategoryId;
  String categoryName;
  int trainingTypeId;
  String trainingTypeName;
  int orderMasterId;
  int customerId;
  String customerName;
  // int traineeDetailsId;
  // String traineeName;
  int orderDetailsSubId;
  int traineeCount;
  int trainerId;
  String trainerName;
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  String statusId;
  String statusName;
  String type;

  UpComingTaskModel({
    required this.orderDetailsId,
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.trainingTypeId,
    required this.trainingTypeName,
    required this.orderMasterId,
    required this.customerId,
    required this.customerName,
    required this.traineeCount,
    // required this.traineeDetailsId,
    // required this.traineeName,
    required this.orderDetailsSubId,
    required this.trainerId,
    required this.trainerName,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.statusId,
    required this.statusName,
    required this.type,
    required this.endTime,
  });

  factory UpComingTaskModel.fromJson(Map<String, dynamic> json) =>
      UpComingTaskModel(
        orderDetailsId: json["Order_Details_Id"],
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        trainingTypeId: json["Training_Type_Id"] ?? 0,
        trainingTypeName: json["Training_Type_Name"] ?? '',
        orderMasterId: json["Order_Master_Id"],
        customerId: json["Customer_Id"],
        customerName: json["Customer_Name"],
        traineeCount: json["Trainee_Count"],
        // traineeDetailsId: json["Trainee_Details_Id"] ?? 0,
        // traineeName: json["Trainee_Name"],
        orderDetailsSubId: json["Order_Details_Sub_Id"],
        trainerId: json["Trainer_Id"],
        trainerName: json["Trainer_Name"],
        startDate: json["Start_Date"],
        endDate: json["End_Date"] ?? '',
        startTime: json["Start_Time"],
        endTime: json["End_Time"] ?? '',
        statusId: json['Status_Id'].toString(),
        statusName: json['Status_Name'] ?? '',
        type: json["Tp"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Order_Details_Id": orderDetailsId,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Training_Type_Id": trainingTypeId,
        "Training_Type_Name": trainingTypeName,
        "Order_Master_Id": orderMasterId,
        "Customer_Id": customerId,
        "Customer_Name": customerName,
        "Trainee_Count": traineeCount,
        // "Trainee_Details_Id": traineeDetailsId,
        // "Trainee_Name": traineeName,
        "Order_Details_Sub_Id": orderDetailsSubId,
        "Trainer_Id": trainerId,
        "Trainer_Name": trainerName,
        "Start_Date": startDate,
        "End_Date": endDate,
        "Start_Time": startTime,
        "Tp": type,
        "End_Time": endTime,
      };
}

class PurpleUpComingTaskModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleUpComingTaskModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleUpComingTaskModel.fromJson(Map<String, dynamic> json) =>
      PurpleUpComingTaskModel(
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
