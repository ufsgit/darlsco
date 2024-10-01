class StopTrainingCourseModel {
  String orderDetailsSubId;
  // String eligibility;

  StopTrainingCourseModel({
    required this.orderDetailsSubId,
    // required this.eligibility,
  });

  factory StopTrainingCourseModel.fromJson(Map<String, dynamic> json) =>
      StopTrainingCourseModel(
        orderDetailsSubId: json["Order_Details_Sub_Id_"],
        // eligibility: json["Eligibility"],
      );

  Map<String, dynamic> toJson() => {
        "Order_Details_Sub_Id_": orderDetailsSubId,
        // "Eligibility": eligibility,
      };
}
