class SaveTrainingModel {
  int orderDetailsId;
  int orderMasterId;
  int trainingCourseId;
  String trainingCourseName;
  int trainingCourseCategoryId;
  String categoryName;
  String description;
  String duration;
  int isTrainingWithExamination;
  int isRetakeOnly;
  int isWritten;
  int isPractical;
  int applicationFees;
  int examinationFees;
  int certificateFees;
  int quantity;
  int totalAmount;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  int currentStatusId;
  String currentStatusName;
  String notes;
  int statusId;
  String statusName;
  int activeStatusId;
  String activeStatusName;
  String rescheduleDate;
  String rescheduleTime;
  List<OrderDetailsSub> orderDetailsSub;

  SaveTrainingModel({
    required this.orderDetailsId,
    required this.orderMasterId,
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.description,
    required this.duration,
    required this.isTrainingWithExamination,
    required this.isRetakeOnly,
    required this.isWritten,
    required this.isPractical,
    required this.applicationFees,
    required this.examinationFees,
    required this.certificateFees,
    required this.quantity,
    required this.totalAmount,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.currentStatusId,
    required this.currentStatusName,
    required this.notes,
    required this.statusId,
    required this.statusName,
    required this.activeStatusId,
    required this.activeStatusName,
    required this.rescheduleDate,
    required this.rescheduleTime,
    required this.orderDetailsSub,
  });

  factory SaveTrainingModel.fromJson(Map<String, dynamic> json) =>
      SaveTrainingModel(
        orderDetailsId: json["Order_Details_Id_"],
        orderMasterId: json["Order_Master_Id_"],
        trainingCourseId: json["Training_Course_Id_"],
        trainingCourseName: json["Training_Course_Name_"],
        trainingCourseCategoryId: json["Training_Course_Category_Id_"],
        categoryName: json["Category_Name_"],
        description: json["Description_"],
        duration: json["Duration_"],
        isTrainingWithExamination: json["Is_Training_with_Examination_"],
        isRetakeOnly: json["Is_Retake_Only_"],
        isWritten: json["Is_Written_"],
        isPractical: json["Is_Practical_"],
        applicationFees: json["Application_Fees_"],
        examinationFees: json["Examination_Fees_"],
        certificateFees: json["Certificate_Fees_"],
        quantity: json["Quantity_"],
        totalAmount: json["Total_Amount_"],
        // startDate: DateTime.parse(json["StartDate_"]),
        startDate: json["StartDate_"],
        startTime: json["Start_Time_"],
        // endDate: DateTime.parse(json["End_Date_"]),
        endDate: json["End_Date_"],
        endTime: json["End_Time_"],
        currentStatusId: json["Current_Status_Id_"],
        currentStatusName: json["Current_Status_Name_"],
        notes: json["Notes_"],
        statusId: json["Status_Id_"],
        statusName: json["Status_Name_"],
        activeStatusId: json["Active_Status_Id_"],
        activeStatusName: json["Active_Status_Name_"],
        rescheduleDate: json["Reschedule_Date_"],
        // rescheduleDate: DateTime.parse(json["Reschedule_Date_"]),
        rescheduleTime: json["Reschedule_Time_"],
        orderDetailsSub: List<OrderDetailsSub>.from(
            json["Order_Details_Sub_"].map((x) => OrderDetailsSub.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Order_Details_Id_": orderDetailsId,
        "Order_Master_Id_": orderMasterId,
        "Training_Course_Id_": trainingCourseId,
        "Training_Course_Name_": trainingCourseName,
        "Training_Course_Category_Id_": trainingCourseCategoryId,
        "Category_Name_": categoryName,
        "Description_": description,
        "Duration_": duration,
        "Is_Training_with_Examination_": isTrainingWithExamination,
        "Is_Retake_Only_": isRetakeOnly,
        "Is_Written_": isWritten,
        "Is_Practical_": isPractical,
        "Application_Fees_": applicationFees,
        "Examination_Fees_": examinationFees,
        "Certificate_Fees_": certificateFees,
        "Quantity_": quantity,
        "Total_Amount_": totalAmount,
        // "StartDate_": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "Start_Time_": startTime,
        "StartDate_": startDate,
        "End_Date_": endDate,
        // "End_Date_": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "End_Time_": endTime,
        "Current_Status_Id_": currentStatusId,
        "Current_Status_Name_": currentStatusName,
        "Notes_": notes,
        "Status_Id_": statusId,
        "Status_Name_": statusName,
        "Active_Status_Id_": activeStatusId,
        "Active_Status_Name_": activeStatusName,
        "Reschedule_Date_": rescheduleDate,
        // "Reschedule_Date_": rescheduleDate.toIso8601String(),
        "Reschedule_Time_": rescheduleTime,
        "Order_Details_Sub_":
            List<dynamic>.from(orderDetailsSub.map((x) => x.toJson())),
      };
}

class OrderDetailsSub {
  int trainerId;
  String trainerName;
  String expectedDate;
  String expectedTime;

  OrderDetailsSub({
    required this.trainerId,
    required this.trainerName,
    required this.expectedDate,
    required this.expectedTime,
  });

  factory OrderDetailsSub.fromJson(Map<String, dynamic> json) =>
      OrderDetailsSub(
        trainerId: json["Trainer_Id"],
        trainerName: json["Trainer_Name"],
        expectedDate: json["Expected_Date"],
        // expectedDate: DateTime.parse(json["Expected_Date"]),
        expectedTime: json["Expected_Time"],
      );

  Map<String, dynamic> toJson() => {
        "Trainer_Id": trainerId,
        "Trainer_Name": trainerName,
        // "Expected_Date": expectedDate.toIso8601String(),
        "Expected_Date": expectedDate,
        "Expected_Time": expectedTime,
      };
}
