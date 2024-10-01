class ItemModelElement {
  int trainingCourseId;
  String? trainingCourseName;
  String description;
  String? fileName;
  dynamic imageName;
  int statusId;
  String statusName;
  int deleteStatus;
  int? trainingCourseCategoryId;
  String? categoryName;
  String? duration;
  String? applicationFees;
  String? examinationFees;
  String? certificateFees;
  String? trainingwithExamFees;
  String? retakeOnlyWritenFess;
  String? retakeOnlyPracticalFees;

  ItemModelElement({
    required this.trainingCourseId,
    this.trainingCourseName,
    required this.description,
    this.fileName,
    this.imageName,
    required this.statusId,
    required this.statusName,
    required this.deleteStatus,
    this.trainingCourseCategoryId,
    this.categoryName,
    this.duration,
    this.applicationFees,
    this.examinationFees,
    this.certificateFees,
    this.trainingwithExamFees,
    this.retakeOnlyWritenFess,
    this.retakeOnlyPracticalFees,
  });

  factory ItemModelElement.fromJson(Map<String, dynamic> json) =>
      ItemModelElement(
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        description: json["Description"],
        fileName: json["File_Name"],
        imageName: json["Image_name"],
        statusId: json["Status_Id"],
        statusName: json["Status_Name"],
        deleteStatus: json["DeleteStatus"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        duration: json["Duration"],
        applicationFees: json["Application_Fees"],
        examinationFees: json["Examination_Fees"],
        certificateFees: json["Certificate_Fees"],
        trainingwithExamFees: json["TrainingwithExam_Fees"],
        retakeOnlyWritenFess: json["RetakeOnly_Writen_Fess"],
        retakeOnlyPracticalFees: json["RetakeOnly_Practical_Fees"],
      );

  Map<String, dynamic> toJson() => {
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Description": description,
        "File_Name": fileName,
        "Image_name": imageName,
        "Status_Id": statusId,
        "Status_Name": statusName,
        "DeleteStatus": deleteStatus,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Duration": duration,
        "Application_Fees": applicationFees,
        "Examination_Fees": examinationFees,
        "Certificate_Fees": certificateFees,
        "TrainingwithExam_Fees": trainingwithExamFees,
        "RetakeOnly_Writen_Fess": retakeOnlyWritenFess,
        "RetakeOnly_Practical_Fees": retakeOnlyPracticalFees,
      };
}

class PurpleItemModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleItemModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleItemModel.fromJson(Map<String, dynamic> json) =>
      PurpleItemModel(
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
