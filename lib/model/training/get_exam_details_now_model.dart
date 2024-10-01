class GetExamDetailsNowModel {
  int orderDetailsSubId;
  String startTime;
  String endTime;
  int orderDetailsId;
  int trainingCourseId;
  String trainingCourseName;
  int trainingCourseCategoryId;
  String categoryName;
  int orderLocationId;
  int locationId;
  String locationName;
  int customerId;
  String customerName;
  DateTime examDate;

  GetExamDetailsNowModel({
    required this.orderDetailsSubId,
    required this.startTime,
    required this.endTime,
    required this.orderDetailsId,
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.orderLocationId,
    required this.locationId,
    required this.locationName,
    required this.customerId,
    required this.customerName,
    required this.examDate,
  });

  factory GetExamDetailsNowModel.fromJson(Map<String, dynamic> json) =>
      GetExamDetailsNowModel(
        orderDetailsSubId: json["Order_Details_Sub_Id"],
        startTime: json["Start_Time"],
        endTime: json["End_Time"],
        orderDetailsId: json["Order_Details_Id"],
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        orderLocationId: json["Order_Location_Id"],
        locationId: json["Location_Id"],
        locationName: json["Location_Name"],
        customerId: json["Customer_Id"],
        customerName: json["Customer_Name"],
        examDate: DateTime.parse(json["Exam_Date"]),
      );

  Map<String, dynamic> toJson() => {
        "Order_Details_Sub_Id": orderDetailsSubId,
        "Start_Time": startTime,
        "End_Time": endTime,
        "Order_Details_Id": orderDetailsId,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Order_Location_Id": orderLocationId,
        "Location_Id": locationId,
        "Location_Name": locationName,
        "Customer_Id": customerId,
        "Customer_Name": customerName,
        "Exam_Date": examDate.toIso8601String(),
      };
}

class PurpleGetExamDetailsNow {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleGetExamDetailsNow({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleGetExamDetailsNow.fromJson(Map<String, dynamic> json) =>
      PurpleGetExamDetailsNow(
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
