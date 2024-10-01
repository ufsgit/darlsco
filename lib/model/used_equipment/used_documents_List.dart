class UsedDocumentListModel {
  int equipmentId;
  String equipmentName;
    bool isCheckBox;
  UsedDocumentListModel(
      {required this.equipmentId, required this.equipmentName,required this.isCheckBox});
  factory UsedDocumentListModel.fromJson(Map<String, dynamic> json) {
    return UsedDocumentListModel(
        equipmentId: json['Test_Document_Id'],
        equipmentName: json['Test_Document_Name'],
           isCheckBox: json['IsView']==0?false:true);
  }
}
