// class GetOrderItemModelElement {
//   int orderDetailsId;
//   int orderMasterId;
//   int trainingCourseId;
//   String trainingCourseName;
//   int trainingCourseCategoryId;
//   String categoryName;
//   String description;
//   String duration;
//   int isTraingwithExamination;
//   int isRetakeOnly;
//   int isWriten;
//   int isPractical;
//   String applicationFees;
//   String examinationFees;
//   String certificateFees;
//   int quantity;
//   String totalAmount;
//   DateTime startDate;
//   String satrtTime;
//   DateTime endDate;
//   String endTime;
//   int currentStatusId;
//   String currentStatusName;
//   String notes;
//   int statusId;
//   String statusName;
//   int activeStatusId;
//   String activeStatusName;
//   DateTime reschedueDate;
//   String reschedueTime;
//   int deleteStatus;

//   GetOrderItemModelElement({
//     required this.orderDetailsId,
//     required this.orderMasterId,
//     required this.trainingCourseId,
//     required this.trainingCourseName,
//     required this.trainingCourseCategoryId,
//     required this.categoryName,
//     required this.description,
//     required this.duration,
//     required this.isTraingwithExamination,
//     required this.isRetakeOnly,
//     required this.isWriten,
//     required this.isPractical,
//     required this.applicationFees,
//     required this.examinationFees,
//     required this.certificateFees,
//     required this.quantity,
//     required this.totalAmount,
//     required this.startDate,
//     required this.satrtTime,
//     required this.endDate,
//     required this.endTime,
//     required this.currentStatusId,
//     required this.currentStatusName,
//     required this.notes,
//     required this.statusId,
//     required this.statusName,
//     required this.activeStatusId,
//     required this.activeStatusName,
//     required this.reschedueDate,
//     required this.reschedueTime,
//     required this.deleteStatus,
//   });

//   factory GetOrderItemModelElement.fromJson(Map<String, dynamic> json) =>
//       GetOrderItemModelElement(
//         orderDetailsId: json["Order_Details_Id"],
//         orderMasterId: json["Order_Master_Id"],
//         trainingCourseId: json["Training_Course_Id"],
//         trainingCourseName: json["Training_Course_Name"],
//         trainingCourseCategoryId: json["Training_Course_Category_Id"],
//         categoryName: json["Category_Name"],
//         description: json["Description"],
//         duration: json["Duration"],
//         isTraingwithExamination: json["Is_Traingwith_examination"],
//         isRetakeOnly: json["Is_Retake_Only"],
//         isWriten: json["Is_Writen"],
//         isPractical: json["Is_Practical"],
//         applicationFees: json["Application_Fees"],
//         examinationFees: json["Examination_Fees"],
//         certificateFees: json["Certificate_Fees"],
//         quantity: json["Quantity"],
//         totalAmount: json["Total_Amount"],
//         startDate: DateTime.parse(json["StartDate"]),
//         satrtTime: json["SatrtTime"],
//         endDate: DateTime.parse(json["End_Date"]),
//         endTime: json["End_Time"],
//         currentStatusId: json["Current_Status_Id"],
//         currentStatusName: json["Current_Status_Name"],
//         notes: json["Notes"],
//         statusId: json["Status_Id"],
//         statusName: json["Status_Name"],
//         activeStatusId: json["Active_Status_Id"],
//         activeStatusName: json["Active_Status_Name"],
//         reschedueDate: DateTime.parse(json["Reschedue_Date"]),
//         reschedueTime: json["Reschedue_Time"],
//         deleteStatus: json["DeleteStatus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Order_Details_Id": orderDetailsId,
//         "Order_Master_Id": orderMasterId,
//         "Training_Course_Id": trainingCourseId,
//         "Training_Course_Name": trainingCourseName,
//         "Training_Course_Category_Id": trainingCourseCategoryId,
//         "Category_Name": categoryName,
//         "Description": description,
//         "Duration": duration,
//         "Is_Traingwith_examination": isTraingwithExamination,
//         "Is_Retake_Only": isRetakeOnly,
//         "Is_Writen": isWriten,
//         "Is_Practical": isPractical,
//         "Application_Fees": applicationFees,
//         "Examination_Fees": examinationFees,
//         "Certificate_Fees": certificateFees,
//         "Quantity": quantity,
//         "Total_Amount": totalAmount,
//         "StartDate": startDate.toIso8601String(),
//         "SatrtTime": satrtTime,
//         "End_Date": endDate.toIso8601String(),
//         "End_Time": endTime,
//         "Current_Status_Id": currentStatusId,
//         "Current_Status_Name": currentStatusName,
//         "Notes": notes,
//         "Status_Id": statusId,
//         "Status_Name": statusName,
//         "Active_Status_Id": activeStatusId,
//         "Active_Status_Name": activeStatusName,
//         "Reschedue_Date": reschedueDate.toIso8601String(),
//         "Reschedue_Time": reschedueTime,
//         "DeleteStatus": deleteStatus,
//       };
// }

// class PurpleGetOrderItemModel {
//   int fieldCount;
//   int affectedRows;
//   int insertId;
//   String info;
//   int serverStatus;
//   int warningStatus;

//   PurpleGetOrderItemModel({
//     required this.fieldCount,
//     required this.affectedRows,
//     required this.insertId,
//     required this.info,
//     required this.serverStatus,
//     required this.warningStatus,
//   });

//   factory PurpleGetOrderItemModel.fromJson(Map<String, dynamic> json) =>
//       PurpleGetOrderItemModel(
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