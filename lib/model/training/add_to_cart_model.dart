class AddCart {
  String deviceId;
  int userId;
  List<TrainingCourse> trainingCourse;

  AddCart({
    required this.deviceId,
    required this.userId,
    required this.trainingCourse,
  });

  factory AddCart.fromJson(Map<String, dynamic> json) => AddCart(
        deviceId: json["Device_Id_"],
        userId: json["User_Id_"],
        trainingCourse: List<TrainingCourse>.from(
            json["Training_Course_"].map((x) => TrainingCourse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Device_Id_": deviceId,
        "User_Id_": userId,
        "Training_Course_":
            List<dynamic>.from(trainingCourse.map((x) => x.toJson())),
      };
}

class TrainingCourse {
  String? description;
  int? trainingCourseId;
  String trainingCourseName;
  int? trainingCourseCategoryId;
  String? categoryName;
  int? quantity;
  double? price;
  double? amount;
  String? fileName;
  String? imageName;
  String? type;

  TrainingCourse({
    required this.description,
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.quantity,
    required this.price,
    required this.amount,
    required this.type,
    required this.fileName,
    required this.imageName,
  });

  factory TrainingCourse.fromJson(Map<String, dynamic> json) => TrainingCourse(
        description: json["Description"],
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        quantity: json["Quantity"] ?? 0,
        price: json["Price"]?.toDouble(),
        amount: json["Amount"]?.toDouble(),
        fileName: json["File_Name"],
        imageName: json["Image_Name"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "Description": description,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Quantity": quantity,
        "Price": price,
        "Amount": amount,
        "File_Name": fileName,
        "Image_Name": imageName,
      };
}
