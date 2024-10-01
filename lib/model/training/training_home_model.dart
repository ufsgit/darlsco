class TrainingHomeModel {
  int trainingCourseId;
  String trainingCourseName;
  String description;
  dynamic fileName;
  dynamic imageName;
  int statusId;
  String statusName;
  int deleteStatus;

  TrainingHomeModel({
    required this.trainingCourseId,
    required this.trainingCourseName,
    required this.description,
    required this.fileName,
    required this.imageName,
    required this.statusId,
    required this.statusName,
    required this.deleteStatus,
  });

  factory TrainingHomeModel.fromJson(Map<String, dynamic> json) =>
      TrainingHomeModel(
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        description: json["Description"],
        fileName: json["File_Name"],
        imageName: json["Image_name"],
        statusId: json["Status_Id"] ?? 0,
        statusName: json["Status_Name"] ?? '',
        deleteStatus: json["DeleteStatus"],
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
      };
}
