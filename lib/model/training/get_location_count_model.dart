class GetLocationCountModel {
  int traineeInLocationCount;
  int orderLocationId;
  int locationId;
  String locationName;
  int orderDetailsId;
  int trainingCourseId;
  String trainingCourseName;
  String fileName;
  int orderMasterId;
  int customerId;
  int trainingCourseCategoryId;
  String categoryName;
  String? startDate;
  // DateTime? startDate;
  String currentStatusName;
  int currentStatusId;
  String orderNo;
  int orderDetailsSubId;
  int trainerId;
  String trainerName;
  int rescheduleCourseId;
  String statusName;
  int statusId;
  String endDate;
  String startTime;
  String endTime;
  String duration;
  String rescheduleRequested;
  int rescheduleRequestedId;
  

  GetLocationCountModel({
    required this.traineeInLocationCount,
    required this.orderLocationId,
    required this.locationId,
    required this.locationName,
    required this.orderDetailsId,
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.fileName,
    required this.orderMasterId,
    required this.customerId,
    required this.trainingCourseCategoryId,
    required this.startDate,
    required this.categoryName,
    required this.currentStatusId,
    required this.currentStatusName,
    required this.trainerId,
    required this.trainerName,
    required this.orderNo,
    required this.rescheduleCourseId,
    required this.orderDetailsSubId,
    required this.statusId,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.rescheduleRequested,
    required this.rescheduleRequestedId,

    


    required this.endDate,
    required this.statusName,
   
  });

  factory GetLocationCountModel.fromJson(Map<String, dynamic> json) =>
      GetLocationCountModel(
          traineeInLocationCount: json["Trainee_In_Location_Count"],
          orderLocationId: json["Order_Location_Id"],
          locationId: json["Location_Id"],
          locationName: json["Location_Name"],
          orderDetailsId: json["Order_Details_Id"],
          trainingCourseId: json["Training_Course_Id"],
          trainingCourseName: json["Training_Course_Name"],
          fileName: json["File_Name"],
          orderMasterId: json["Order_Master_Id"],
          customerId: json["Customer_Id"],
          trainerId: json["Trainer_Id"] ?? 0,
          trainerName: json["Trainer_Name"] ?? 'Not assigned yet',
          trainingCourseCategoryId: json["Training_Course_Category_Id"],
          currentStatusId: json["Current_Status_Id"] ?? 0,
          currentStatusName: json["Current_Status_Name"] ?? 'Not assigned yet',
          orderNo: json["Order_No"],
          rescheduleCourseId: json["Reschedue_Course_Id"],
          // startDate:
          //     DateTime.parse(json["Start_Date"] ?? DateTime.now().toString()),
          startDate: json["Start_Date"] ?? 'Not assigned yet',
          endDate: json['End_Date']??"Not assigned yet",
          categoryName: json["Category_Name"],
          statusId: json['Status_Id'] ?? 0,
          statusName: json['Status_Name'] ?? 'Not assigned yet',
          startTime: json['Start_Time']??'Not assigned yet',
          endTime: json['End_Time']??'Not assigned yet',

          duration: json['Duration']??'',

          rescheduleRequested: json['Reschedule_Status']??'',
          rescheduleRequestedId: json['Reschedue_Status_Id']??0,



          orderDetailsSubId: json["Order_Details_Sub_Id"] ?? 0);

  Map<String, dynamic> toJson() => {
        "Trainee_In_Location_Count": traineeInLocationCount,
        "Order_Location_Id": orderLocationId,
        "Location_Id": locationId,
        "Location_Name": locationName,
        "Order_Details_Id": orderDetailsId,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "File_Name": fileName,
        "Order_Master_Id": orderMasterId,
        "Customer_Id": customerId,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Start_Date": startDate ?? '',
        // "Start_Date": startDate?.toIso8601String(),
        "Order_No": orderNo,
        "Current_Status_Name": currentStatusName,
        "Current_Status_Id": currentStatusId,
        "Order_Details_Sub_Id": orderDetailsSubId,
        "Trainer_Id": trainerId,
        "Reschedue_Course_Id": rescheduleCourseId,
        "Trainer_Name": trainerName,
      };
}

class PurpleGetLocationCountModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleGetLocationCountModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleGetLocationCountModel.fromJson(Map<String, dynamic> json) =>
      PurpleGetLocationCountModel(
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
