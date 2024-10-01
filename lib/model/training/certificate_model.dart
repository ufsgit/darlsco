class CertificateModelElement {
  int traineeDetailsId;
  String traineeName;
  int trainingCourseId;
  String trainingCourseName;
  String certificate;

  CertificateModelElement({
    required this.traineeDetailsId,
    required this.traineeName,
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.certificate,
  });

  factory CertificateModelElement.fromJson(Map<String, dynamic> json) =>
      CertificateModelElement(
        traineeDetailsId: json["Trainee_Details_Id"],
        traineeName: json["Trainee_Name"],
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        certificate: json["Certificate"],
      );

  Map<String, dynamic> toJson() => {
        "Trainee_Details_Id": traineeDetailsId,
        "Trainee_Name": traineeName,
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Certificate": certificate,
      };
}

class PurpleCertificateModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleCertificateModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleCertificateModel.fromJson(Map<String, dynamic> json) =>
      PurpleCertificateModel(
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
