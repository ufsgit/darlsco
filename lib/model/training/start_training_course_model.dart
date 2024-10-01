class StartTrainingCourseModel {
  int customerId;
  DateTime orderDate;
  int orderNo;
  int totalAmount;
  int vatAmount;
  int vatPers;
  int serviceCharge;
  int servicePers;
  int grandTotal;
  int paymentStatus;
  String paymentStatusName;
  String referenceId;
  int currentStatusId;
  String currentStatusName;
  int activeStatusId;
  String activeStatusName;
  int userId;
  int paymentModeId;
  String paymentModeName;
  String transactionId;
  DateTime transactionDateAndTime;
  List<OrderDetailsDetailsSub> orderDetailsDetailsSub;

  StartTrainingCourseModel({
    required this.customerId,
    required this.orderDate,
    required this.orderNo,
    required this.totalAmount,
    required this.vatAmount,
    required this.vatPers,
    required this.serviceCharge,
    required this.servicePers,
    required this.grandTotal,
    required this.paymentStatus,
    required this.paymentStatusName,
    required this.referenceId,
    required this.currentStatusId,
    required this.currentStatusName,
    required this.activeStatusId,
    required this.activeStatusName,
    required this.userId,
    required this.paymentModeId,
    required this.paymentModeName,
    required this.transactionId,
    required this.transactionDateAndTime,
    required this.orderDetailsDetailsSub,
  });

  factory StartTrainingCourseModel.fromJson(Map<String, dynamic> json) =>
      StartTrainingCourseModel(
        customerId: json["Customer_Id_"],
        orderDate: DateTime.parse(json["Order_Date_"]),
        orderNo: json["Order_No_"],
        totalAmount: json["Total_Amount_"],
        vatAmount: json["Vat_Amount_"],
        vatPers: json["Vat_pers_"],
        serviceCharge: json["Service_Charge_"],
        servicePers: json["Service_pers_"],
        grandTotal: json["Grand_Total_"],
        paymentStatus: json["Payment_Status_"],
        paymentStatusName: json["Payment_Status_Name_"],
        referenceId: json["Reference_Id_"],
        currentStatusId: json["Current_Status_Id_"],
        currentStatusName: json["Current_Status_Name_"],
        activeStatusId: json["Active_Status_Id_"],
        activeStatusName: json["Active_Status_Name_"],
        userId: json["User_Id_"],
        paymentModeId: json["Payment_Mode_Id_"],
        paymentModeName: json["Payment_Mode_Name_"],
        transactionId: json["Transaction_Id_"],
        transactionDateAndTime:
            DateTime.parse(json["Transaction_Date_And_Time_"]),
        orderDetailsDetailsSub: List<OrderDetailsDetailsSub>.from(
            json["Order_Details_DetailsSub_"]
                .map((x) => OrderDetailsDetailsSub.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Customer_Id_": customerId,
        "Order_Date_": orderDate.toIso8601String(),
        "Order_No_": orderNo,
        "Total_Amount_": totalAmount,
        "Vat_Amount_": vatAmount,
        "Vat_pers_": vatPers,
        "Service_Charge_": serviceCharge,
        "Service_pers_": servicePers,
        "Grand_Total_": grandTotal,
        "Payment_Status_": paymentStatus,
        "Payment_Status_Name_": paymentStatusName,
        "Reference_Id_": referenceId,
        "Current_Status_Id_": currentStatusId,
        "Current_Status_Name_": currentStatusName,
        "Active_Status_Id_": activeStatusId,
        "Active_Status_Name_": activeStatusName,
        "User_Id_": userId,
        "Payment_Mode_Id_": paymentModeId,
        "Payment_Mode_Name_": paymentModeName,
        "Transaction_Id_": transactionId,
        "Transaction_Date_And_Time_": transactionDateAndTime.toIso8601String(),
        "Order_Details_DetailsSub_":
            List<dynamic>.from(orderDetailsDetailsSub.map((x) => x.toJson())),
      };
}

class OrderDetailsDetailsSub {
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
  String notes;
  int statusId;
  String statusName;
  DateTime rescheduleDate;
  String rescheduleTime;
  DateTime expectedDate;
  String expectedTime;
  int trainerId;
  String trainerName;

  OrderDetailsDetailsSub({
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
    required this.notes,
    required this.statusId,
    required this.statusName,
    required this.rescheduleDate,
    required this.rescheduleTime,
    required this.expectedDate,
    required this.expectedTime,
    required this.trainerId,
    required this.trainerName,
  });

  factory OrderDetailsDetailsSub.fromJson(Map<String, dynamic> json) =>
      OrderDetailsDetailsSub(
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        description: json["Description"],
        duration: json["Duration"],
        isTrainingWithExamination: json["Is_Training_with_examination"],
        isRetakeOnly: json["Is_Retake_Only"],
        isWritten: json["Is_Written"],
        isPractical: json["Is_Practical"],
        applicationFees: json["Application_Fees"],
        examinationFees: json["Examination_Fees"],
        certificateFees: json["Certificate_Fees"],
        quantity: json["Quantity"],
        notes: json["Notes"],
        statusId: json["Status_Id"],
        statusName: json["Status_Name"],
        rescheduleDate: DateTime.parse(json["Reschedule_Date"]),
        rescheduleTime: json["Reschedule_Time"],
        expectedDate: DateTime.parse(json["Expected_Date"]),
        expectedTime: json["Expected_Time"],
        trainerId: json["Trainer_Id"],
        trainerName: json["Trainer_Name"],
      );

  Map<String, dynamic> toJson() => {
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Description": description,
        "Duration": duration,
        "Is_Training_with_examination": isTrainingWithExamination,
        "Is_Retake_Only": isRetakeOnly,
        "Is_Written": isWritten,
        "Is_Practical": isPractical,
        "Application_Fees": applicationFees,
        "Examination_Fees": examinationFees,
        "Certificate_Fees": certificateFees,
        "Quantity": quantity,
        "Notes": notes,
        "Status_Id": statusId,
        "Status_Name": statusName,
        "Reschedule_Date":
            "${rescheduleDate.year.toString().padLeft(4, '0')}-${rescheduleDate.month.toString().padLeft(2, '0')}-${rescheduleDate.day.toString().padLeft(2, '0')}",
        "Reschedule_Time": rescheduleTime,
        "Expected_Date":
            "${expectedDate.year.toString().padLeft(4, '0')}-${expectedDate.month.toString().padLeft(2, '0')}-${expectedDate.day.toString().padLeft(2, '0')}",
        "Expected_Time": expectedTime,
        "Trainer_Id": trainerId,
        "Trainer_Name": trainerName,
      };
}
