// To parse this JSON data, do
//
//     final equipmentDetailModel = equipmentDetailModelFromJson(jsonString);

import 'dart:convert';

EquipmentDetailModel equipmentDetailModelFromJson(String str) => EquipmentDetailModel.fromJson(json.decode(str));

String equipmentDetailModelToJson(EquipmentDetailModel data) => json.encode(data.toJson());

class EquipmentDetailModel {
    Returnvalue ?returnvalue;

    EquipmentDetailModel({
         this.returnvalue,
    });

    factory EquipmentDetailModel.fromJson(Map<String, dynamic> json) => EquipmentDetailModel(
        returnvalue: Returnvalue.fromJson(json["returnvalue"]),
    );

    Map<String, dynamic> toJson() => {
        "returnvalue": returnvalue?.toJson(),
    };
}

class Returnvalue {
    List<Lead> leads;

    Returnvalue({
        required this.leads,
    });

    factory Returnvalue.fromJson(Map<String, dynamic> json) => Returnvalue(
        leads: List<Lead>.from(json["Leads"].map((x) => Lead.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Leads": List<dynamic>.from(leads.map((x) => x.toJson())),
    };
}

class Lead {
    int equipmentCertificateId;
    int equipmentId;
    String certificateNumber;
    DateTime issueDate;
    DateTime periodTo;
    String filePath;
    String fileKey;
    String issueDateG;
    String periodToG;

    Lead({
        required this.equipmentCertificateId,
        required this.equipmentId,
        required this.certificateNumber,
        required this.issueDate,
        required this.periodTo,
        required this.filePath,
        required this.fileKey,
        required this.issueDateG,
        required this.periodToG,
    });

    factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        equipmentCertificateId: json["Equipment_Certificate_Id"],
        equipmentId: json["Equipment_Id"],
        certificateNumber: json["Certificate_Number"],
        issueDate: DateTime.parse(json["Issue_Date"]),
        periodTo: DateTime.parse(json["Period_To"]),
        filePath: json["File_Path"],
        fileKey: json["File_Key"],
        issueDateG: json["Issue_Date_G"],
        periodToG: json["Period_To_G"],
    );

    Map<String, dynamic> toJson() => {
        "Equipment_Certificate_Id": equipmentCertificateId,
        "Equipment_Id": equipmentId,
        "Certificate_Number": certificateNumber,
        "Issue_Date": "${issueDate.year.toString().padLeft(4, '0')}-${issueDate.month.toString().padLeft(2, '0')}-${issueDate.day.toString().padLeft(2, '0')}",
        "Period_To": "${periodTo.year.toString().padLeft(4, '0')}-${periodTo.month.toString().padLeft(2, '0')}-${periodTo.day.toString().padLeft(2, '0')}",
        "File_Path": filePath,
        "File_Key": fileKey,
        "Issue_Date_G": issueDateG,
        "Period_To_G": periodToG,
    };
}
