class ReassignModel {
  int orderDetailsSubId;
  int trainerId;
  String trainerName;
  String expectedDate;
  String notes;

  ReassignModel(
      {required this.orderDetailsSubId,
      required this.trainerId,
      required this.trainerName,
      required this.expectedDate,
      required this.notes});

  factory ReassignModel.fromJson(Map<String, dynamic> json) => ReassignModel(
        orderDetailsSubId: json["Order_Details_Sub_Id_"],
        trainerId: json["Trainer_Id_"],
        trainerName: json["Trainer_Name_"],
        expectedDate: json["Expected_Date_"],
        notes: json["Notes_Sub_"],
        // expectedDate: DateTime.parse(json["Expected_Date_"]),
      );

  Map<String, dynamic> toJson() => {
        "Order_Details_Sub_Id_": orderDetailsSubId,
        "Trainer_Id_": trainerId,
        "Trainer_Name_": trainerName,
        "Expected_Date_": trainerName,
        "Notes_sub_": notes,
        // "Expected_Date_":
        //     "${expectedDate.year.toString().padLeft(4, '0')}-${expectedDate.month.toString().padLeft(2, '0')}-${expectedDate.day.toString().padLeft(2, '0')}",
      };
}
