class GetOrderModel {
  int orderMasterId;
  int customerId;
  DateTime orderDate;
  String orderNo;
  dynamic otp;
  String totalAmount;
  String vatAmount;
  String vatPers;
  String serviceCharge;
  String servicePers;
  String grandTotal;
  int paymentStatus;
  String paymentStatusName;
  String referenceId;
  int currentStatusId;
  String currentStatusName;
  DateTime startDate;
  DateTime endDate;
  int activeStatusId;
  String activeStatusName;
  int userId;
  int paymentModeId;
  String paymentModeName;
  String transactionId;
  DateTime transactionDateAndTime;
  int deleteStatus;

  GetOrderModel({
    required this.orderMasterId,
    required this.customerId,
    required this.orderDate,
    required this.orderNo,
    required this.otp,
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
    required this.startDate,
    required this.endDate,
    required this.activeStatusId,
    required this.activeStatusName,
    required this.userId,
    required this.paymentModeId,
    required this.paymentModeName,
    required this.transactionId,
    required this.transactionDateAndTime,
    required this.deleteStatus,
  });

  factory GetOrderModel.fromJson(Map<String, dynamic> json) => GetOrderModel(
        orderMasterId: json["Order_Master_Id"],
        customerId: json["Customer_Id"],
        orderDate: DateTime.parse(json["Order_Date"]),
        orderNo: json["Order_No"],
        otp: json["Otp"],
        totalAmount: json["Total_Amount"],
        vatAmount: json["Vat_Amount"],
        vatPers: json["Vat_pers"],
        serviceCharge: json["Service_Charge"],
        servicePers: json["Service_pers"],
        grandTotal: json["Grand_Total"],
        paymentStatus: json["Payment_Status"],
        paymentStatusName: json["Payment_Status_Name"],
        referenceId: json["Reference_Id"],
        currentStatusId: json["Current_Status_Id"],
        currentStatusName: json["Current_Status_Name"],
        startDate: DateTime.parse(json["Start_Date"]),
        endDate: DateTime.parse(json["End_Date"]),
        activeStatusId: json["Active_Status_Id"],
        activeStatusName: json["Active_Status_Name"],
        userId: json["User_Id"],
        paymentModeId: json["Payment_Mode_Id"],
        paymentModeName: json["Payment_Mode_Name"],
        transactionId: json["Transaction_Id"],
        transactionDateAndTime:
            DateTime.parse(json["Transaction_Date_And_Time"]),
        deleteStatus: json["DeleteStatus"],
      );

  Map<String, dynamic> toJson() => {
        "Order_Master_Id": orderMasterId,
        "Customer_Id": customerId,
        "Order_Date": orderDate.toIso8601String(),
        "Order_No": orderNo,
        "Otp": otp,
        "Total_Amount": totalAmount,
        "Vat_Amount": vatAmount,
        "Vat_pers": vatPers,
        "Service_Charge": serviceCharge,
        "Service_pers": servicePers,
        "Grand_Total": grandTotal,
        "Payment_Status": paymentStatus,
        "Payment_Status_Name": paymentStatusName,
        "Reference_Id": referenceId,
        "Current_Status_Id": currentStatusId,
        "Current_Status_Name": currentStatusName,
        "Start_Date": startDate.toIso8601String(),
        "End_Date": endDate.toIso8601String(),
        "Active_Status_Id": activeStatusId,
        "Active_Status_Name": activeStatusName,
        "User_Id": userId,
        "Payment_Mode_Id": paymentModeId,
        "Payment_Mode_Name": paymentModeName,
        "Transaction_Id": transactionId,
        "Transaction_Date_And_Time": transactionDateAndTime.toIso8601String(),
        "DeleteStatus": deleteStatus,
      };
}

class PurpleGetOrderModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleGetOrderModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleGetOrderModel.fromJson(Map<String, dynamic> json) =>
      PurpleGetOrderModel(
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
