// class GetCartItemModel {
//   int itemCartId;
//   String deviceId;
//   int userId;
//   String description;
//   int trainingCourseId;
//   String trainingCourseName;
//   int trainingCourseCategoryId;
//   String categoryName;
//   int quantity;
//   String price;
//   String amount;
//   String fileName;
//   String imageName;
//   int deleteStatus;

//   GetCartItemModel({
//     required this.itemCartId,
//     required this.deviceId,
//     required this.userId,
//     required this.description,
//     required this.trainingCourseId,
//     required this.trainingCourseName,
//     required this.trainingCourseCategoryId,
//     required this.categoryName,
//     required this.quantity,
//     required this.price,
//     required this.amount,
//     required this.fileName,
//     required this.imageName,
//     required this.deleteStatus,
//   });

//   factory GetCartItemModel.fromJson(Map<String, dynamic> json) =>
//       GetCartItemModel(
//         itemCartId: json["Item_Cart_Id"],
//         deviceId: json["Device_Id"],
//         userId: json["User_Id"],
//         description: json["Description"],
//         trainingCourseId: json["Training_Course_Id"],
//         trainingCourseName: json["Training_Course_Name"],
//         trainingCourseCategoryId: json["Training_Course_Category_Id"],
//         categoryName: json["Category_Name"],
//         quantity: json["Quantity"],
//         price: json["Price"],
//         amount: json["Amount"],
//         fileName: json["File_Name"],
//         imageName: json["Image_Name"],
//         deleteStatus: json["DeleteStatus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Item_Cart_Id": itemCartId,
//         "Device_Id": deviceId,
//         "User_Id": userId,
//         "Description": description,
//         "Training_Course_Id": trainingCourseId,
//         "Training_Course_Name": trainingCourseName,
//         "Training_Course_Category_Id": trainingCourseCategoryId,
//         "Category_Name": categoryName,
//         "Quantity": quantity,
//         "Price": price,
//         "Amount": amount,
//         "File_Name": fileName,
//         "Image_Name": imageName,
//         "DeleteStatus": deleteStatus,
//       };
// }

// class GetCartItem {
//   int fieldCount;
//   int affectedRows;
//   int insertId;
//   String info;
//   int serverStatus;
//   int warningStatus;

//   GetCartItem({
//     required this.fieldCount,
//     required this.affectedRows,
//     required this.insertId,
//     required this.info,
//     required this.serverStatus,
//     required this.warningStatus,
//   });

//   factory GetCartItem.fromJson(Map<String, dynamic> json) => GetCartItem(
//         fieldCount: json["fieldCount"],
//         affectedRows: json["affectedRows"],
//         insertId: json["insertId"],
//         info: json["info"],
//         serverStatus: json["serverStatus"],
//         warningStatus: json["warningStatus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "fieldCount": fieldCount,
//         "affectedRows": affectedRows,
//         "insertId": insertId,
//         "info": info,
//         "serverStatus": serverStatus,
//         "warningStatus": warningStatus,
//       };
// }