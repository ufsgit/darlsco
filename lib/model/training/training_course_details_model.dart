class TrainingCourseDetailsModel {
  int trainingCourseCategoryId;
  int trainingCourseId;
  String categoryName;
  String duration;
  String description;
  String applicationFees;
  String examinationFees;
  String certificateFees;
  String trainingwithExamFees;
  String retakeOnlyWritenFess;
  String retakeOnlyPracticalFees;
  String tax;
  int statusId;
  String statusName;
  int deleteStatus;
  String applicationTax;
  String certificateTax;
  String examinationTax;

  TrainingCourseDetailsModel({
    required this.trainingCourseCategoryId,
    required this.trainingCourseId,
    required this.categoryName,
    required this.duration,
    required this.description,
    required this.applicationFees,
    required this.examinationFees,
    required this.certificateFees,
    required this.trainingwithExamFees,
    required this.retakeOnlyWritenFess,
    required this.retakeOnlyPracticalFees,
    required this.tax,
    required this.statusId,
    required this.statusName,
    required this.deleteStatus,
    required this.applicationTax,
    required this.certificateTax,
    required this.examinationTax,
  });

  factory TrainingCourseDetailsModel.fromJson(Map<String, dynamic> json) =>
      TrainingCourseDetailsModel(
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        trainingCourseId: json["Training_Course_Id"],
        categoryName: json["Category_Name"],
        duration: json["Duration"],
        description: json["Description"],
        applicationFees: json["Application_Fees"],
        examinationFees: json["Examination_Fees"],
        certificateFees: json["Certificate_Fees"],
        trainingwithExamFees: json["TrainingwithExam_Fees"],
        retakeOnlyWritenFess: json["RetakeOnly_Writen_Fess"],
        retakeOnlyPracticalFees: json["RetakeOnly_Practical_Fees"],
        tax: json["Tax"],
        statusId: json["Status_Id"],
        statusName: json["Status_Name"],
        deleteStatus: json["DeleteStatus"],
        applicationTax: json["Application_Tax"],
        certificateTax: json["Certificate_Tax"],
        examinationTax: json["Examination_Tax"],
      );

  Map<String, dynamic> toJson() => {
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Training_Course_Id": trainingCourseId,
        "Category_Name": categoryName,
        "Duration": duration,
        "Description": description,
        "Application_Fees": applicationFees,
        "Examination_Fees": examinationFees,
        "Certificate_Fees": certificateFees,
        "TrainingwithExam_Fees": trainingwithExamFees,
        "RetakeOnly_Writen_Fess": retakeOnlyWritenFess,
        "RetakeOnly_Practical_Fees": retakeOnlyPracticalFees,
        "Tax": tax,
        "Status_Id": statusId,
        "Status_Name": statusName,
        "DeleteStatus": deleteStatus,
        "Application_Tax": applicationTax,
        "Certificate_Tax": certificateTax,
        "Examination_Tax": examinationTax,
      };
}
