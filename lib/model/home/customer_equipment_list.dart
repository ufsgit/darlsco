class CustomerEquipmentList {
  int equipmentId;
  String location;
  String equipmentName;
  String equipmentMake;
  String equipmentModel;
  String serialNo;
  String experingDate;
  int experingIn;
  String description;
  int checked;
int certificateCount;
  int statusId;
  String statusName;

  String equipmentType;

  CustomerEquipmentList({
    required this.certificateCount,
    required this.checked,
    required this.statusId,
    required this.statusName,
    required this.location,
    required this.equipmentId,
    required this.equipmentName,
    required this.equipmentMake,
    required this.equipmentModel,
    required this.serialNo,
    required this.experingDate,
    required this.experingIn,
    required this.description,
    required this.equipmentType,
  });
  factory CustomerEquipmentList.fromJson(Map<String, dynamic> json) {
    return CustomerEquipmentList(
      certificateCount: json['Certificate_Count']??0,
        statusId: int.parse(json['Status_Id'].toString() == 'null'
            ? '0'
            : json['Status_Id'].toString()),
        statusName: json['Status_Name'] ?? '',
        equipmentId: json['Equipment_Id'] ?? 0,
        location: json['Location_Name'] ?? '',
        equipmentName: json['Equipment_Name'] ?? '',
        experingIn: json['Expires_In'] ?? 0,
        equipmentMake: json['Make'] ?? '',
        equipmentModel: json['Model'] ?? '',
        experingDate: json['Expiry_Date'] ?? '',
        serialNo: json['Seraial_No'] ?? '',
        description: json['description'] ?? '',
        checked: int.parse(json['Checked'].toString() == 'null'
            ? '0'
            : json['Checked'].toString()),
        equipmentType: json['Equipment_Type'] ?? '');
  }
}
