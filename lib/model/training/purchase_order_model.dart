class PurchaseOrderModel {
  String customerId;
  DateTime orderDate;
  String totalAmount;
  int vatAmount;
  int vatPers;
  int serviceCharge;
  double servicePers;
  int grandTotal;
  int paymentStatus;
  String paymentStatusName;
  String referenceId;
  int paymentModeId;
  String paymentModeName;
  String transactionId;
  DateTime transactionDateAndTime;
  List<OrderDetail> orderDetails;

  PurchaseOrderModel({
    required this.customerId,
    required this.orderDate,
    required this.totalAmount,
    required this.vatAmount,
    required this.vatPers,
    required this.serviceCharge,
    required this.servicePers,
    required this.grandTotal,
    required this.paymentStatus,
    required this.paymentStatusName,
    required this.referenceId,
    required this.paymentModeId,
    required this.paymentModeName,
    required this.transactionId,
    required this.transactionDateAndTime,
    required this.orderDetails,
  });

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) =>
      PurchaseOrderModel(
        customerId: json["Customer_Id_"],
        orderDate: DateTime.parse(json["Order_Date_"]),
        totalAmount: json["Total_Amount_"],
        vatAmount: json["Vat_Amount_"],
        vatPers: json["Vat_pers_"],
        serviceCharge: json["Service_Charge_"],
        servicePers: json["Service_pers_"]?.toDouble(),
        grandTotal: json["Grand_Total_"],
        paymentStatus: json["Payment_Status_"],
        paymentStatusName: json["Payment_Status_Name_"],
        referenceId: json["Reference_Id_"],
        paymentModeId: json["Payment_Mode_Id_"],
        paymentModeName: json["Payment_Mode_Name_"],
        transactionId: json["Transaction_Id_"],
        transactionDateAndTime:
            DateTime.parse(json["Transaction_Date_And_Time_"]),
        orderDetails: List<OrderDetail>.from(
            json["Order_Details"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Customer_Id_": customerId,
        "Order_Date_": orderDate.toIso8601String(),
        "Total_Amount_": totalAmount,
        "Vat_Amount_": vatAmount,
        "Vat_pers_": vatPers,
        "Service_Charge_": serviceCharge,
        "Service_pers_": servicePers,
        "Grand_Total_": grandTotal,
        "Payment_Status_": paymentStatus,
        "Payment_Status_Name_": paymentStatusName,
        "Reference_Id_": referenceId,
        "Payment_Mode_Id_": paymentModeId,
        "Payment_Mode_Name_": paymentModeName,
        "Transaction_Id_": transactionId,
        "Transaction_Date_And_Time_": transactionDateAndTime.toIso8601String(),
        "Order_Details":
            List<dynamic>.from(orderDetails.map((x) => x.toJson())),
      };
}

class OrderDetail {
  int trainingCourseId;
  String trainingCourseName;
  int trainingCourseCategoryId;
  String categoryName;
  String orderDetails;
  String duration;
  int isTrainingWithExamination;
  int isRetakeOnly;
  int isWritten;
  int isPractical;
  int applicationFees;
  int examinationFees;
  int certificateFees;
  int quantity;
  String startTime;
  String endTime;
  String notes;
  int statusId;
  String statusName;
  DateTime rescheduleDate;
  String rescheduleTime;

  OrderDetail({
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.orderDetails,
    required this.duration,
    required this.isTrainingWithExamination,
    required this.isRetakeOnly,
    required this.isWritten,
    required this.isPractical,
    required this.applicationFees,
    required this.examinationFees,
    required this.certificateFees,
    required this.quantity,
    required this.startTime,
    required this.endTime,
    required this.notes,
    required this.statusId,
    required this.statusName,
    required this.rescheduleDate,
    required this.rescheduleTime,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        orderDetails: json["Order_Details"],
        duration: json["Duration"],
        isTrainingWithExamination: json["Is_Training_with_examination"],
        isRetakeOnly: json["Is_Retake_Only"],
        isWritten: json["Is_Written"],
        isPractical: json["Is_Practical"],
        applicationFees: json["Application_Fees"],
        examinationFees: json["Examination_Fees"],
        certificateFees: json["Certificate_Fees"],
        quantity: json["Quantity"],
        startTime: json["StartTime"],
        endTime: json["End_Time"],
        notes: json["Notes"],
        statusId: json["Status_Id"],
        statusName: json["Status_Name"],
        rescheduleDate: DateTime.parse(json["Reschedule_Date"]),
        rescheduleTime: json["Reschedule_Time"],
      );

  Map<String, dynamic> toJson() => {
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Order_Details": orderDetails,
        "Duration": duration,
        "Is_Training_with_examination": isTrainingWithExamination,
        "Is_Retake_Only": isRetakeOnly,
        "Is_Written": isWritten,
        "Is_Practical": isPractical,
        "Application_Fees": applicationFees,
        "Examination_Fees": examinationFees,
        "Certificate_Fees": certificateFees,
        "Quantity": quantity,
        "StartTime": startTime,
        "End_Time": endTime,
        "Notes": notes,
        "Status_Id": statusId,
        "Status_Name": statusName,
        "Reschedule_Date":
            "${rescheduleDate.year.toString().padLeft(4, '0')}-${rescheduleDate.month.toString().padLeft(2, '0')}-${rescheduleDate.day.toString().padLeft(2, '0')}",
        "Reschedule_Time": rescheduleTime,
      };
}
