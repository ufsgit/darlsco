class ViewAddTraineeDetailsModelElement {
  int traineeDetailsId;
  String employeeFirstName;
  String employeeLastName;
  String applicationId;
  String dateofBirth;
  String mobileNo;
  String emailId;
  String emirateId;
  String employeeId;
  int locationId;
  String locationName;
  String photo;
  String countryCodeId;
  String countryCodeName;

  ViewAddTraineeDetailsModelElement({
    required this.traineeDetailsId,
    required this.employeeFirstName,
    required this.employeeLastName,
    required this.dateofBirth,
    required this.mobileNo,
    required this.emailId,
    required this.emirateId,
    required this.employeeId,
    required this.applicationId,
    required this.locationId,
    required this.locationName,
    required this.photo,
    required this.countryCodeId,
    required this.countryCodeName,
  });

  factory ViewAddTraineeDetailsModelElement.fromJson(
          Map<String, dynamic> json) =>
      ViewAddTraineeDetailsModelElement(
        traineeDetailsId: json["Trainee_Details_Id"]??0,
        employeeFirstName: json["First_Name"]??'',
        employeeLastName: json["Last_Name"],
        dateofBirth: json["Dob"] ?? '',
        mobileNo: json["Mobile_No"]??'',
        emailId: json["Email_Id"]??'',
        emirateId: json["Emirates_Id"]??'',
        employeeId: json["Employee_Id"]??'',
        applicationId: json["Application_Number"] ?? '',
        locationId: json["Location_Id"]??0,
        locationName: json["Location_Name"]??'',
        photo: json["Photo"] ?? '',
        countryCodeId: json["Country_Code_Id"] ?? '',
        countryCodeName: json["Country_Code_Name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Trainee_Details_Id": traineeDetailsId,
        "Employee_FirstName": employeeFirstName,
        "Employee_LastName": employeeLastName,
        "DateofBirth": dateofBirth,
        "MobileNo": mobileNo,
        "EmailId": emailId,
        "Emirate_Id": emirateId,
        "Employee_Id": employeeId,
        "Application_Number": applicationId,
        "Location_Id": locationId,
        "Location_Name": locationName,
        "Photo": photo,
        "Country_Code_Id": countryCodeId,
        "Country_Code_Name": countryCodeName,
      };
}

class PurpleViewAddTraineeDetailsModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleViewAddTraineeDetailsModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleViewAddTraineeDetailsModel.fromJson(
          Map<String, dynamic> json) =>
      PurpleViewAddTraineeDetailsModel(
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
