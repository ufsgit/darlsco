class LocationListModel {
  int locationId;
  int customerId;
  String locationName;
  String link;
  String latitude;
  String longitude;
  int deleteStatus;
  String nickname;

  LocationListModel({
    required this.locationId,
    required this.customerId,
    required this.locationName,
    required this.link,
    required this.latitude,
    required this.longitude,
    required this.deleteStatus,
    required this.nickname,
  });

  factory LocationListModel.fromJson(Map<String, dynamic> json) =>
      LocationListModel(
        locationId: json["Location_Id"] ?? 0,
        customerId: json["Customer_Id"] ?? 0,
        locationName: json["Location_Name"] ?? '',
        link: json["Link"] ?? '',
        latitude: json["Latitude"] ?? '',
        longitude: json["Longitude"] ?? '',
        deleteStatus: json["DeleteStatus"] ?? 0,
        nickname: json["Nickname"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Location_Id": locationId,
        "Customer_Id": customerId,
        "Location_Name": locationName,
        "Link": link,
        "Latitude": latitude,
        "Longitude": longitude,
        "DeleteStatus": deleteStatus,
        "Nickname": nickname,
      };
}

class PurpleLocationListModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleLocationListModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleLocationListModel.fromJson(Map<String, dynamic> json) =>
      PurpleLocationListModel(
        fieldCount: json["fieldCount"],
        affectedRows: json["affectedRows"],
        insertId: json["insertId"],
        info: json["info"],
        serverStatus: json["serverStatus"],
        warningStatus: json["warningStatus"],
      );

  Map<String, dynamic> toJson() => {
        "fieldCount": fieldCount,
        "affectedRows": affectedRows,
        "insertId": insertId,
        "info": info,
        "serverStatus": serverStatus,
        "warningStatus": warningStatus,
      };
}
