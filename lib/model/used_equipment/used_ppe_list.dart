class UsedPpeListModel {
  int equipmentId;
  String equipmentName;
  bool isCheckBox;
  UsedPpeListModel({required this.equipmentId, required this.equipmentName,required this.isCheckBox});
  factory UsedPpeListModel.fromJson(Map<String, dynamic> json) {
    return UsedPpeListModel(
        equipmentId: json['Test_PPE_Id'],
      isCheckBox: json['IsView']==0?false:true,
        equipmentName: json['Test_PPE_Name']);
  }
}