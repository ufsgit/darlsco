class EligibleExamModel {
  List<EligibilityDetails> eligibilityDetails;

  EligibleExamModel({
    required this.eligibilityDetails,
  });

  factory EligibleExamModel.fromJson(Map<String, dynamic> json) =>
      EligibleExamModel(
        eligibilityDetails: List<EligibilityDetails>.from(
            json["Eligibility_Details_"]
                .map((x) => EligibilityDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Eligibility_Details_":
            List<dynamic>.from(eligibilityDetails.map((x) => x.toJson())),
      };
}

class EligibilityDetails {
  int traineeDetailsId;
  int eligibilityStatusId;
  String eligibilityStatusName;

  EligibilityDetails({
    required this.traineeDetailsId,
    required this.eligibilityStatusId,
    required this.eligibilityStatusName,
  });

  factory EligibilityDetails.fromJson(Map<String, dynamic> json) =>
      EligibilityDetails(
        traineeDetailsId: json["Trainee_Details_Id"],
        eligibilityStatusId: json["Eligibility_Status_Id"],
        eligibilityStatusName: json["Eligibility_Status_Name"],
      );

  Map<String, dynamic> toJson() => {
        "Trainee_Details_Id": traineeDetailsId,
        "Eligibility_Status_Id": eligibilityStatusId,
        "Eligibility_Status_Name": eligibilityStatusName,
      };
}
