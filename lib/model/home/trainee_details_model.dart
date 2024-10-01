class AddTraineeModel {
  int traineeDetailsId;
  int orderDetailsSubId;
  int orderDetailsId;
  List<TraineeDetails> traineeDetails;

  AddTraineeModel({
    required this.traineeDetailsId,
    required this.orderDetailsSubId,
    required this.orderDetailsId,
    required this.traineeDetails,
  });

  factory AddTraineeModel.fromJson(Map<String, dynamic> json) =>
      AddTraineeModel(
        traineeDetailsId: json["Trainee_Details_Id_"],
        orderDetailsSubId: json["Order_Details_Sub_Id_"],
        orderDetailsId: json["Order_Details_Id_"],
        traineeDetails: List<TraineeDetails>.from(
            json["Trainee_Details_"].map((x) => TraineeDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Trainee_Details_Id_": traineeDetailsId,
        "Order_Details_Sub_Id_": orderDetailsSubId,
        "Order_Details_Id_": orderDetailsId,
        "Trainee_Details_":
            List<dynamic>.from(traineeDetails.map((x) => x.toJson())),
      };
}

class TraineeDetails {
  int trainingCourseId;
  String trainingCourseName;
  int trainingCourseCategoryId;
  String categoryName;
  String employeeFirstname;
  String employeeLastname;
  int employeeId;
  String? dateofBirth;
  String emailId;
  String mobileNo;
  String emirateId;

  TraineeDetails({
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.employeeFirstname,
    required this.employeeLastname,
    required this.employeeId,
    required this.dateofBirth,
    required this.emailId,
    required this.mobileNo,
    required this.emirateId,
  });

  factory TraineeDetails.fromJson(Map<String, dynamic> json) => TraineeDetails(
        trainingCourseId: json["Training_Course_Id"]??0,
        trainingCourseName: json["Training_Course_Name"]??"",
        trainingCourseCategoryId: json["Training_Course_Category_Id"]??0,
        categoryName: json["Category_Name"]??'',
        employeeFirstname: json["Employee_Firstname"]??'',
        employeeLastname: json["Employee_Lastname"]??'',
        employeeId: json["Employee_Id"]??0,
        // dateofBirth: DateTime.parse(json["DateofBirth"]),
        dateofBirth: json["DateofBirth"]??"",
        emailId: json["Email_Id"]??"",
        mobileNo: json["MobileNo"]??'',
        emirateId: json["Emirate_Id"]??'',
      );

  Map<String, dynamic> toJson() => {
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Employee_Firstname": employeeFirstname,
        "Employee_Lastname": employeeLastname,
        "Employee_Id": employeeId,
        "DateofBirth": dateofBirth,
        // "DateofBirth":
        //     "${dateofBirth!.year.toString().padLeft(4, '0')}-${dateofBirth!.month.toString().padLeft(2, '0')}-${dateofBirth!.day.toString().padLeft(2, '0')}",
        "Email_Id": emailId,
        "MobileNo": mobileNo,
        "Emirate_Id": emirateId,
      };
}