class GetTraineeDetailModel {
  int traineeDetailsId;
  int orderDetailsSubId;
  int orderDetailsId;
  int trainingCourseId;
  int trainingCourseCategoryId;
  String trainingCourseName;
  String categoryName;

  String location;

  String employeeFirstname;
  String employeeLastname;
  String dateofBirth;
  String mobileNo;
  String emailId;
  String emirateId;
  String employeeId;
  int deleteStatus;

  GetTraineeDetailModel({
    required this.traineeDetailsId,
    required this.orderDetailsSubId,
    required this.orderDetailsId,
    required this.trainingCourseId,
    required this.trainingCourseCategoryId,
    required this.trainingCourseName,
    required this.categoryName,
    required this.employeeFirstname,
    required this.employeeLastname,
    required this.dateofBirth,
    required this.mobileNo,
    required this.emailId,
    required this.emirateId,
    required this.employeeId,
    required this.deleteStatus,
    required this.location,
  });

  factory GetTraineeDetailModel.fromJson(Map<String, dynamic> json) =>
      GetTraineeDetailModel(
        traineeDetailsId: json["Trainee_Details_Id"],
        orderDetailsSubId: json["Order_Details_Sub_Id"] ?? 0,
        orderDetailsId: json["Order_Details_Id"] ?? 0,
        trainingCourseId: json["Training_Course_Id"] ?? 0,
        trainingCourseCategoryId: json["Training_Course_Category_Id"] ?? 0,
        trainingCourseName: json["Training_Course_Name"],
        categoryName: json["Category_Name"],
        employeeFirstname: json["Employee_Firstname"],
        employeeLastname: json["Employee_Lastname"],
        dateofBirth: json["DateofBirth"] ?? "",
        mobileNo: json["MobileNo"] ?? "",
        emailId: json["EmailId"] ?? '',
        emirateId: json["Emirate_Id"] ?? '0',
        employeeId: json["Employee_Id"] ?? '1',
        deleteStatus: json["DeleteStatus"],
        location: json['Location_Name'],
      );

  Map<String, dynamic> toJson() => {
        "Trainee_Details_Id": traineeDetailsId,
        "Order_Details_Sub_Id": orderDetailsSubId,
        "Order_Details_Id": orderDetailsId,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Training_Course_Name": trainingCourseName,
        "Category_Name": categoryName,
        "Employee_Firstname": employeeFirstname,
        "Employee_Lastname": employeeLastname,
        "DateofBirth": dateofBirth,
        "MobileNo": mobileNo,
        "EmailId": emailId,
        "Emirate_Id": emirateId,
        "Employee_Id": employeeId,
        "DeleteStatus": deleteStatus,
      };
}

class PurpleGetTraineeDetail {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleGetTraineeDetail({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleGetTraineeDetail.fromJson(Map<String, dynamic> json) =>
      PurpleGetTraineeDetail(
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
