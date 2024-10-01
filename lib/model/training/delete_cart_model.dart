class DeleteCartModel {
  int itemCartId;

  DeleteCartModel({
    required this.itemCartId,
  });

  factory DeleteCartModel.fromJson(Map<String, dynamic> json) =>
      DeleteCartModel(
        itemCartId: json["Item_Cart_Id_"],
      );

  Map<String, dynamic> toJson() => {
        "Item_Cart_Id_": itemCartId,
      };
}

class PurpleDeleteCartModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  PurpleDeleteCartModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
  });

  factory PurpleDeleteCartModel.fromJson(Map<String, dynamic> json) =>
      PurpleDeleteCartModel(
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
