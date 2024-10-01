class SaveAttendanceModel {
  String attendanceDate;
  String attendanceTime;
  int userId;
  int orderDetailsSubId;
  List<AttendanceDetails> attendanceDetails;

  SaveAttendanceModel({
    required this.attendanceDate,
    required this.attendanceTime,
    required this.userId,
    required this.orderDetailsSubId,
    required this.attendanceDetails,
  });

  factory SaveAttendanceModel.fromJson(Map<String, dynamic> json) =>
      SaveAttendanceModel(
        // attendanceDate: DateTime.parse(json["Attendance_Date_"]),
        attendanceDate: json["Attendance_Date_"],
        attendanceTime: json["Attendance_Time_"],
        userId: json["User_Id_"],
        orderDetailsSubId: json["Order_Details_Sub_Id_"],
        attendanceDetails: List<AttendanceDetails>.from(
            json["Attendance_Details_"]
                .map((x) => AttendanceDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "Attendance_Date_":
        //     "${attendanceDate.year.toString().padLeft(4, '0')}-${attendanceDate.month.toString().padLeft(2, '0')}-${attendanceDate.day.toString().padLeft(2, '0')}",
        "Attendance_Date_": attendanceDate,
        "Attendance_Time_": attendanceTime,
        "User_Id_": userId,
        "Order_Details_Sub_Id_": orderDetailsSubId,
        "Attendance_Details_":
            List<dynamic>.from(attendanceDetails.map((x) => x.toJson())),
      };
}

class AttendanceDetails {
  int trainingCourseId;
  String trainingCourseName;
  int trainingCourseCategoryId;
  String categoryName;
  int traineeId;
  String traineeName;
  int attendanceStatusId;
  String attendanceStatusName;

  AttendanceDetails({
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.traineeId,
    required this.traineeName,
    required this.attendanceStatusId,
    required this.attendanceStatusName,
  });

  factory AttendanceDetails.fromJson(Map<String, dynamic> json) =>
      AttendanceDetails(
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        traineeId: json["Trainee_Id"],
        traineeName: json["Trainee_Name"],
        attendanceStatusId: json["Attendance_Status_Id"],
        attendanceStatusName: json["Attendance_Status_Name"],
      );

  Map<String, dynamic> toJson() => {
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Trainee_Id": traineeId,
        "Trainee_Name": traineeName,
        "Attendance_Status_Id": attendanceStatusId,
        "Attendance_Status_Name": attendanceStatusName,
      };
}
