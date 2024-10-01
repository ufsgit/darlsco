
class RescheduleUser {
  // int rescheduleCourseId;
  String orderNo;
  int orderDetailsId;
  int trainingCourseId;
  int trainingCourseCategoryId;
  String trainingCourseName;
  String categoryName;
  String rescheduleDate;
  // String rescheduleTime;
  int trainerId;
  String trainerName;
  String notes;
  int currentStatusId;
  String currentStatusName;
  // int userId;
  // String remarks;
  int quantity;
  int orderLocationId;
  int orderDetailsSubId;
  String orderLocationName;
  String startTime;
  String endTime;

  RescheduleUser({
    // required this.rescheduleCourseId,
    required this.orderNo,
    required this.orderDetailsId,
    required this.trainingCourseId,
    required this.trainingCourseCategoryId,
    required this.trainingCourseName,
    required this.categoryName,
    required this.rescheduleDate,
    required this.orderLocationId,
    required this.trainerId,
    required this.trainerName,
    required this.notes,
    required this.currentStatusId,
    required this.currentStatusName,
    // required this.userId,
    // required this.remarks,
    required this.orderLocationName,
    required this.quantity,
    required this.orderDetailsSubId,
    required this.startTime,
    required this.endTime,

  });

  factory RescheduleUser.fromJson(Map<String, dynamic> json) => RescheduleUser(
        // rescheduleCourseId: json["Reschedule_Course_Id"],
        orderDetailsId: json["Order_Details_Id"],
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        trainingCourseName: json["Training_Course_Name"],
        categoryName: json["Category_Name"],
        rescheduleDate: json["Reschedule_Date"],
        // rescheduleTime: json["Reschedule_Time"],
        trainerId: json["Trainer_Id"],
        trainerName: json["Trainer_Name"],
        notes: json["Notes"],
        currentStatusId: json["Current_Status_Id"],
        currentStatusName: json["Current_Status_Name"],
        // userId: json["User_Id"],
        // remarks: json["Remarks"],
        orderNo: json['Order_No']??'',
        orderLocationName: json['Location_Name']??'',
        startTime: json['Start_Time']??'',
        endTime: json['End_Time']??'',
        orderDetailsSubId: json['Order_Details_Sub_Id']??0,

        orderLocationId: json["Order_Location_Id"]??'',
        quantity: json["Quantity"],
      );

  Map<String, dynamic> toJson() => {
        // "Reschedule_Course_Id": rescheduleCourseId,
        "Order_Details_Id": orderDetailsId,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Training_Course_Name": trainingCourseName,
        "Category_Name": categoryName,
        "Reschedule_Date": rescheduleDate,
        // "Reschedule_Time": rescheduleTime,
        "Trainer_Id": trainerId,
        "Trainer_Name": trainerName,
        "Notes": notes,
        "Current_Status_Id": currentStatusId,
        "Current_Status_Name": currentStatusName,
        // "User_Id": userId,
        // "Remarks": remarks,
        "Quantity": quantity,
      };
}
