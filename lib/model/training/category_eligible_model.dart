class CategoryEligibleModelElement {
  int trainingCourseCategoryId;
  String categoryName;
  String requiredDocuments;
  String eligibilityCriteria;

  CategoryEligibleModelElement({
    required this.trainingCourseCategoryId,
    required this.categoryName,
    required this.requiredDocuments,
    required this.eligibilityCriteria,
  });

  factory CategoryEligibleModelElement.fromJson(Map<String, dynamic> json) =>
      CategoryEligibleModelElement(
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        requiredDocuments: json["Required_Documents"],
        eligibilityCriteria: json["Eligibility_Criteria"],
      );

  Map<String, dynamic> toJson() => {
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Required_Documents": requiredDocuments,
        "Eligibility_Criteria": eligibilityCriteria,
      };
}

class PurpleCategoryEligibleModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleCategoryEligibleModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleCategoryEligibleModel.fromJson(Map<String, dynamic> json) =>
      PurpleCategoryEligibleModel(
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
