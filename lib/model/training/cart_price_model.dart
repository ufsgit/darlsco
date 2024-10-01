class CartPriceModel {
  String trainingCourseName;
  String trainingCourseId;
  int? trainingCourseCategoryId;

  String categoryName;
  int quantity;
  String price;
  String amount;
  String applicationFee;
  String examinationFee;
  String certificateFee;
  String vat;
  String subTotal;
  String grandTotal;
  String trainingWithExamFee;
  String applicationTax;
  String certificateTax;
  String examinationTax;
  String tax;
  String retakeOnlyWrittenTax;
  String retakeOnlyPracticalTax;
  String serviceCharge;
  String duration;
  int deleteStatus;
  String retakepracticalFee;
  String retakeWrittenFee;


  CartPriceModel({
    required this.trainingCourseName,
    required this.trainingCourseId,
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.quantity,
    required this.price,
    required this.amount,
    required this.applicationFee,
    required this.examinationFee,
    required this.certificateFee,
    required this.duration,
    required this.vat,
    required this.subTotal,
    required this.grandTotal,
    required this.trainingWithExamFee,
    required this.applicationTax,
    required this.certificateTax,
    required this.examinationTax,
    required this.tax,
    required this.retakeOnlyPracticalTax,
    required this.retakeOnlyWrittenTax,
    required this.serviceCharge,

    required this.retakeWrittenFee,
    required this.retakepracticalFee,

    required this.deleteStatus,
  });

  factory CartPriceModel.fromJson(Map<String, dynamic> json) => CartPriceModel(
        trainingCourseName: json["Training_Course_Name"],
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        quantity: json["Quantity_"],
        price: json["Price"],
        amount: json["Amount"],
        applicationFee: json["Application_Fees"],
        examinationFee: json["Examination_Fees"],
        certificateFee: json["Certificate_Fees"],
        vat: json["Vat_Amount"],
        duration: json["Duration"],
        subTotal: json["Sub_Total"],
        grandTotal: json["Grand_Total"],
        trainingWithExamFee: json["TrainingwithExam_Fees"],
        applicationTax: json["Application_Tax"],
        certificateTax: json["Certificate_Tax"],
        examinationTax: json["Examination_Tax"],
        tax: json["Tax"],
        retakeOnlyPracticalTax: json["Retake_Only_Practical_Tax"],
        retakeOnlyWrittenTax: json["Retake_Only_Written_Tax"],
        serviceCharge: json["Service_Charge"],
        deleteStatus: json["DeleteStatus"],

        retakeWrittenFee:  json["RetakeOnly_Writen_Fess"],

         retakepracticalFee:  json["RetakeOnly_Practical_Fees"],

      );

  Map<String, dynamic> toJson() => {
        "Training_Course_Name": trainingCourseName,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Quantity_": quantity,
        "Price": price,
        "Amount": amount,
        "Duration": duration,
        "Application_Fees": applicationFee,
        "Examination_Fees": examinationFee,
        "Certificate_Fees": certificateFee,
        "Vat_Amount": vat,
        "Sub_Total": subTotal,
        "Grand_Total": grandTotal,
        "TrainingwithExam_Fees": trainingWithExamFee,
        "Application_Tax": applicationTax,
        "Certificate_Tax": certificateTax,
        "Examination_Tax": examinationTax,
        "Tax": tax,
        "Retake_Only_Practical_Tax": retakeOnlyPracticalTax,
        "Retake_Only_Written_Tax": retakeOnlyWrittenTax,
        "Service_Charge": serviceCharge,
        "DeleteStatus": deleteStatus,
      };
}
