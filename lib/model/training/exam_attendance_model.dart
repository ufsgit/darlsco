class ExamAttendanceModel {
  String attendanceDate;
  String attendanceTime;
  int userId;
  int examMasterId;
  List<ExamAttendanceDetails> examDetails;

  ExamAttendanceModel({
    required this.attendanceDate,
    required this.attendanceTime,
    required this.userId,
    required this.examMasterId,
    required this.examDetails,
  });

  factory ExamAttendanceModel.fromJson(Map<String, dynamic> json) =>
      ExamAttendanceModel(
        // attendanceDate: DateTime.parse(json["Attendance_Date_"]),
        attendanceDate: json["Attendance_Date_"],
        attendanceTime: json["Attendance_Time_"],
        userId: json["User_Id_"],
        examMasterId: json["Exam_Master_Id_"],
        examDetails: List<ExamAttendanceDetails>.from(json["Exam_Details_"]
            .map((x) => ExamAttendanceDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "Attendance_Date_":
        //     "${attendanceDate.year.toString().padLeft(4, '0')}-${attendanceDate.month.toString().padLeft(2, '0')}-${attendanceDate.day.toString().padLeft(2, '0')}",
        "Attendance_Date_": attendanceDate,
        "Attendance_Time_": attendanceTime,
        "User_Id_": userId,
        "Exam_Master_Id_": examMasterId,
        "Attendance_Details_":
            List<dynamic>.from(examDetails.map((x) => x.toJson())),
      };
}

class ExamAttendanceDetails {
  String trainingCourseName;

  int trainerId;
  int traineeId;
  String traineeName;
  String trainerName;
  int trainingCourseId;
  int trainingCourseCategoryId;
  String categoryName;
  int attendanceStatusId;
  String attendanceStatusName;

  ExamAttendanceDetails({
    required this.trainingCourseName,
    required this.trainerId,
    required this.trainerName,
    required this.traineeId,
    required this.traineeName,
    required this.trainingCourseId,
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.attendanceStatusId,
    required this.attendanceStatusName,
  });

  factory ExamAttendanceDetails.fromJson(Map<String, dynamic> json) =>
      ExamAttendanceDetails(
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        traineeId: json["Trainee_Id"],
        traineeName: json["Trainee_Name"],
        trainerId: json["Trainer_Id"],
        trainerName: json["Trainer_Name"],
        attendanceStatusId: json["Attendance_Status_Id"],
        attendanceStatusName: json["Attendance_Status_Name"],
      );

  Map<String, dynamic> toJson() => {
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Trainee_Name": traineeName,
        "Trainee_Id": traineeId,
        "Trainer_Id": trainerId,
        "Trainer_Name": trainerName,
        "Attendance_Status_Id": attendanceStatusId,
        "Attendance_Status_Name": attendanceStatusName,
      };
}
