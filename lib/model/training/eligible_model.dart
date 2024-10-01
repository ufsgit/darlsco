class EligibleModel {
  int orderDetailsSubId;
  int eligibility;

  EligibleModel({
    required this.orderDetailsSubId,
    required this.eligibility,
  });

  factory EligibleModel.fromJson(Map<String, dynamic> json) => EligibleModel(
        orderDetailsSubId: json["Order_Details_Sub_Id_"],
        eligibility: json["Eligibility"],
      );

  Map<String, dynamic> toJson() => {
        "Order_Details_Sub_Id_": orderDetailsSubId,
        "Eligibility": eligibility,
      };
}
