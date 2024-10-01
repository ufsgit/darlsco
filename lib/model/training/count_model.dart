class CountModel {
  int countNow;
  int countFuture;
  int countPast;

  CountModel({
    required this.countNow,
    required this.countFuture,
    required this.countPast,
  });

  factory CountModel.fromJson(Map<String, dynamic> json) => CountModel(
        countNow: json["count_now"],
        countFuture: json["count_future"],
        countPast: json["count_past"],
      );

  Map<String, dynamic> toJson() => {
        "count_now": countNow,
        "count_future": countFuture,
        "count_past": countPast,
      };
}

class PurpleCountModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleCountModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleCountModel.fromJson(Map<String, dynamic> json) =>
      PurpleCountModel(
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
