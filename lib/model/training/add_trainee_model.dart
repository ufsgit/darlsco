class AddTraineeModel {
  // int orderDetailsSubId;
  int orderDetailsId;
  int orderMasterId;
  String? duration;
  int quantity;
  // int orderLocationId;
  List<TraineeDetails> traineeDetails;

  AddTraineeModel({
    // required this.orderDetailsSubId,
    required this.orderDetailsId,
    required this.traineeDetails,
    required this.duration,
    // required this.orderLocationId,
    required this.orderMasterId,
    required this.quantity,
  });

  factory AddTraineeModel.fromJson(Map<String, dynamic> json) =>
      AddTraineeModel(
        // orderDetailsSubId: json["Order_Details_Sub_Id_"],
        orderDetailsId: json["Order_Details_Id_"],
        // orderLocationId: json["OrderLocation_Id_"],
        duration: json["Duration_"],
        orderMasterId: json["Order_Master_Id_"],
        quantity: json["Quantity_"],
        traineeDetails: List<TraineeDetails>.from(
            json["Trainee_Details_"].map((x) => TraineeDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "Order_Details_Sub_Id_": orderDetailsSubId,
        "Order_Details_Id_": orderDetailsId,
        // "OrderLocation_Id_": orderLocationId,
        "Duration_": duration,
        "Order_Master_Id_": orderMasterId,
        "Quantity_": quantity,
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
  String employeeId;
  String? dateofBirth;
  String emailId;
  String mobileNo;
  String emirateId;
  int locationId;
  String locationName;
  String countryCode;
  String countryCodeName;
  String  photoUrl;
   String applicationNumber;
   String latitude;
   String longitude;

  TraineeDetails(
      {required this.trainingCourseId,
      required this.trainingCourseName,
      required this.trainingCourseCategoryId,
      required this.categoryName,
      required this.employeeFirstname,
      required this.employeeLastname,
      required this.employeeId,
      required this.dateofBirth,
      required this.emailId,
      required this.mobileNo,
      required this.countryCode,
      required this.countryCodeName,
      required this.emirateId,
      required this.locationId,
      required this.photoUrl,
      required this.applicationNumber,
      required this.latitude,
      required this.longitude,
      required this.locationName});

  factory TraineeDetails.fromJson(Map<String, dynamic> json) => TraineeDetails(
      trainingCourseId: json["Training_Course_Id"],
      trainingCourseName: json["Training_Course_Name"],
      trainingCourseCategoryId: json["Training_Course_Category_Id"],
      categoryName: json["Category_Name"],
      employeeFirstname: json["Employee_Firstname"],
      employeeLastname: json["Employee_Lastname"],
      employeeId: json["Employee_Id"],

      latitude: json['Latitude']??'',
      longitude: json['Longitude']??'',

      countryCode: json['Country_Code_Id']??'',
      countryCodeName: json['Country_Code_Name']??'',
      // dateofBirth: DateTime.parse(json["DateofBirth"]),
      dateofBirth: json["DateofBirth"],
      emailId: json["Email_Id"],
      mobileNo: json["MobileNo"],
      emirateId: json["Emirate_Id"],
      locationId: json["Location_Id"],
      applicationNumber: json['Application_Number']??'',

      photoUrl: json['Photo']??"",
      locationName: json["Location_Name"]);

  Map<String, dynamic> toJson() => {
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Employee_Firstname": employeeFirstname,
        "Employee_Lastname": employeeLastname,
        "Employee_Id": employeeId,
        "DateofBirth": dateofBirth,
        "Location_Id": locationId,
        "Location_Name": locationName,

        "Latitude":latitude,
        "Longitude":longitude,
        
        // "DateofBirth":
        //     "${dateofBirth!.year.toString().padLeft(4, '0')}-${dateofBirth!.month.toString().padLeft(2, '0')}-${dateofBirth!.day.toString().padLeft(2, '0')}",
        "Email_Id": emailId,
        "MobileNo": mobileNo,
        "Emirate_Id": emirateId,
      };
}
