class TraineeDetailsStart {
  int traineeDetailsId;
  String traineeDetailsName;

  TraineeDetailsStart(
      {required this.traineeDetailsId, required this.traineeDetailsName});

  factory TraineeDetailsStart.fromJson(Map<String, dynamic> json) =>
      TraineeDetailsStart(
        traineeDetailsId: json["Trainee_Details_Id"],
        traineeDetailsName: json["Trainee_Name"],
      );

  Map<String, dynamic> toJson() => {
        "Trainee_Details_Id": traineeDetailsId,
        "Trainee_Name": traineeDetailsName,
      };
}
