class ExamFailDetailsModel {
  int orderMasterId;
  String customerId;
  String orderDate;
  String orderNo;
  int paymentStatusID;
  String paymentStatusName;
  String customerName;
  String contactName;
  String mobileNumber;


  ExamFailDetailsModel({
    required this.orderMasterId,
    required this.customerId,
    required this.orderDate,
    required this.orderNo,
    required this.paymentStatusID,
    required this.paymentStatusName,
    required this.customerName,
    required this.contactName,
    required this.mobileNumber,
  });

  factory ExamFailDetailsModel.fromJson(Map<String, dynamic> json) =>
      ExamFailDetailsModel(
        orderMasterId: json["Order_Master_Id"]??0,
        customerId: json["Customer_Id"].toString(),
        orderDate: json["Order_Date"].toString(),
        orderNo: json["Order_No"]??"",
        paymentStatusID: json["Payment_Status"]??0,
        paymentStatusName: json["Payment_Status_Name"]??'',

                customerName: json["Customer_Name"]??'',
        contactName: json["Contact_Name"]??'',
        mobileNumber: json["Mobile"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Order_Master_Id": orderMasterId,
        "Customer_Id": customerId,
        "Order_Date": orderDate,
        "Order_No": orderNo,
        "Payment_Status": paymentStatusID,
        "Payment_Status_Name": paymentStatusName,

         "Customer_Name": customerName,
        "Contact_Name": contactName,
        "Mobile": mobileNumber,

      };
}

class PurpleExamFailDetailsModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleExamFailDetailsModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleExamFailDetailsModel.fromJson(Map<String, dynamic> json) =>
      PurpleExamFailDetailsModel(
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
