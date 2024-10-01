class GetCartItemModel {
  int itemCartId;
  String deviceId;
  int userId;
  String description;
  int trainingCourseId;
  String trainingCourseName;
  int trainingCourseCategoryId;
  String categoryName;
  int quantity;
  String price;
  String amount;
  String fileName;
  String duration;
  String imageName;
  int deleteStatus;
  String applicationFee;
  String examinationFee;
  String certificateFee;
  String trainingWithExamFee;
  String applicationTax;
  String certificateTax;
  String examinationTax;
  String serviceCharge;
  String tax;
  String retakeOnlyWrittenTax;
  String retakeOnlyPracticalTax;
  String vat;
   String retakeOnlyWrittenFee;
  String retakeOnlyPracticalFee;

  GetCartItemModel({
    required this.itemCartId,
    required this.deviceId,
    required this.userId,
    required this.description,
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.quantity,
    required this.price,
    required this.amount,
    required this.fileName,
    required this.imageName,
    required this.deleteStatus,
    required this.applicationFee,
    required this.examinationFee,
    required this.certificateFee,
    required this.trainingWithExamFee,
    required this.applicationTax,
    required this.certificateTax,
    required this.examinationTax,
    required this.tax,
    required this.retakeOnlyPracticalTax,
    required this.retakeOnlyWrittenTax,
    required this.serviceCharge,
    required this.vat,
    required this.duration,
    required this.retakeOnlyPracticalFee,
    required this.retakeOnlyWrittenFee,
  });

  factory GetCartItemModel.fromJson(Map<String, dynamic> json) =>
      GetCartItemModel(
        itemCartId: json["Item_Cart_Id"],
        deviceId: json["Device_Id"],
        userId: json["User_Id"],
        description: json["Description"] ?? '',
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        quantity: json["Quantity"],
        price: json["Price"],
        amount: json["Amount"],
        applicationFee: json["Application_Fees"],
        examinationFee: json["Examination_Fees"],
        certificateFee: json["Certificate_Fees"],
        vat: json["Vat_Amount"],
        fileName: json["File_Name"],
        imageName: json["Image_Name"],
        trainingWithExamFee: json["TrainingwithExam_Fees"],
        applicationTax: json["Application_Tax"],
        certificateTax: json["Certificate_Tax"],
        examinationTax: json["Examination_Tax"],
        tax: json["Tax"],
        retakeOnlyPracticalTax: json["Retake_Only_Practical_Tax"],
        retakeOnlyWrittenTax: json["Retake_Only_Written_Tax"],
        serviceCharge: json["Service_Charge"],
        deleteStatus: json["DeleteStatus"],
        duration: json["Duration"],
        retakeOnlyPracticalFee:json['RetakeOnly_Writen_Fess']??'',
        retakeOnlyWrittenFee: json['RetakeOnly_Practical_Fees']??'',

      );

  Map<String, dynamic> toJson() => {
        "Item_Cart_Id": itemCartId,
        "Device_Id": deviceId,
        "User_Id": userId,
        "Description": description,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Quantity": quantity,
        "Price": price,
        "Amount": amount,
        "Application_Fees": applicationFee,
        "Examination_Fees": examinationFee,
        "Certificate_Fees": certificateFee,
        "Vat_Amount": vat,
        "File_Name": fileName,
        "Image_Name": imageName,
        "TrainingwithExam_Fees": trainingWithExamFee,
        "Application_Tax": applicationTax,
        "Certificate_Tax": certificateTax,
        "Examination_Tax": examinationTax,
        "Tax": tax,
        "Retake_Only_Practical_Tax": retakeOnlyPracticalTax,
        "Retake_Only_Written_Tax": retakeOnlyWrittenTax,
        "Service_Charge": serviceCharge,
        "DeleteStatus": deleteStatus,
        "Duration": duration,
      };
}

class GetCartItem {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  GetCartItem({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory GetCartItem.fromJson(Map<String, dynamic> json) => GetCartItem(
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
