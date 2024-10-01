class GetTrainerModel {
  Returnvalue returnvalue;

  GetTrainerModel({
    required this.returnvalue,
  });

  factory GetTrainerModel.fromJson(Map<String, dynamic> json) =>
      GetTrainerModel(
        returnvalue: Returnvalue.fromJson(json["returnvalue"]),
      );

  Map<String, dynamic> toJson() => {
        "returnvalue": returnvalue.toJson(),
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
  int userDetailsId;
  String userDetailsName;

  Lead({
    required this.userDetailsId,
    required this.userDetailsName,
  });

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        userDetailsId: json["User_Details_Id"],
        userDetailsName: json["User_Details_Name"],
      );

  Map<String, dynamic> toJson() => {
        "User_Details_Id": userDetailsId,
        "User_Details_Name": userDetailsName,
      };
}
