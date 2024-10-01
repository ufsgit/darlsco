class StopExamModel {
  String examMasterId;

  StopExamModel({
    required this.examMasterId,
  });

  factory StopExamModel.fromJson(Map<String, dynamic> json) => StopExamModel(
        examMasterId: json["Exam_Master_Id_"],
      );

  Map<String, dynamic> toJson() => {
        "Exam_Master_Id_": examMasterId,
      };
}
