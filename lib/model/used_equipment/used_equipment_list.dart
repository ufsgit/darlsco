class UsedEquipmentList {
  int equipmentId;
  String equipmentName;
  bool isCheckBox;
  UsedEquipmentList({required this.equipmentId, required this.equipmentName,required this.isCheckBox});
  factory UsedEquipmentList.fromJson(Map<String, dynamic> json) {
    return UsedEquipmentList(
        equipmentId: json['Test_Equiptment_Id'],
        equipmentName: json['Test_Equiptment_Name'],

        isCheckBox: json['IsView']==0?false:true
        
        
        
        );
  }
}
