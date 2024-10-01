class GetTotalTrainingModel {
  int customerId;
  String customerName;
  int orderMasterId;
  int orderDetailsId;
  int trainingCourseId;
  String trainingCourseName;
  int trainingCourseCategoryId;
  String categoryName;
  int orderDetailsSubId;
  int trainerId;
  String trainerName;
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  int traineeCount;
  String trainingType;
  String statusName;
  String expectedStartTime;
  String expectedEndTime;

  int statusId;
  
  // int traineeDetailsId;
  // String traineeName;
  String duration;

  GetTotalTrainingModel({
    required this.customerId,
    required this.customerName,
    required this.orderMasterId,
    required this.orderDetailsId,
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.orderDetailsSubId,
    required this.trainerId,
    required this.trainerName,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.traineeCount,
    required this.trainingType,
    required this.statusName,
    required this.expectedStartTime,
    required this.expectedEndTime,

    required this.statusId,
    // required this.traineeDetailsId,
    // required this.traineeName,
    required this.duration,
  });

  factory GetTotalTrainingModel.fromJson(Map<String, dynamic> json) =>
      GetTotalTrainingModel(
        customerId: json["Customer_Id"],
        customerName: json["Customer_Name"] ?? "",
        orderMasterId: json["Order_Master_Id"],
        orderDetailsId: json["Order_Details_Id"],
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        orderDetailsSubId: json["Order_Details_Sub_Id"],
        trainerId: json["Trainer_Id"],
        trainerName: json["Trainer_Name"],
        startDate:json["Start_Date"]??'',
        endDate: json["End_Date"]??'',
        startTime: json["Expected_Start_Time"]??'',
        traineeCount: json["Trainee_Count"]??0,
        endTime: json["Expected_End_Time"]??'',
        trainingType: json['tp']??'',

        statusName: json['Status_Name']??'',

        statusId: json['Status_Id']??0,
        expectedEndTime: json["End_Time"]??'',
        expectedStartTime: json["Start_Time"]??'',

        // traineeDetailsId: json["Trainee_Details_Id"],
        // traineeName: json["Trainee_Name"],
        duration: json["Duration"],
      );

  Map<String, dynamic> toJson() => {
        "Customer_Id": customerId,
        "Customer_Name": customerName,
        "Order_Master_Id": orderMasterId,
        "Order_Details_Id": orderDetailsId,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Order_Details_Sub_Id": orderDetailsSubId,
        "Trainer_Id": trainerId,
        "Trainer_Name": trainerName,
        "Start_Date": startDate.toString(),
        "End_Date": endDate.toString(),
        "Start_Time": startTime,
        "End_Time": endTime,
        "Trainee_Count": traineeCount,
        // "Trainee_Details_Id": traineeDetailsId,
        // "Trainee_Name": traineeName,
        'tp':trainingType,
        "Duration": duration,
      };
}

class PurpleGetTotalTrainingModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleGetTotalTrainingModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleGetTotalTrainingModel.fromJson(Map<String, dynamic> json) =>
      PurpleGetTotalTrainingModel(
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
