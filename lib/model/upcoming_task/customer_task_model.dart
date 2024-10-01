class CustomerTaskModel {
  int taskId;
  String taskName;
  String taskDate;
  String taskTime;
  String estimatedTime;
  String entryDate;
  String remark;
  int customerId;
  int customerRequestId;
  String customerLocation;

  CustomerTaskModel({
    required this.taskId,
    required this.taskName,
    required this.taskDate,
    required this.taskTime,
    required this.estimatedTime,
    required this.entryDate,
    required this.remark,
    required this.customerId,
    required this.customerRequestId,
    required this.customerLocation,
  });

  factory CustomerTaskModel.fromJson(Map<String, dynamic> json) {
    return CustomerTaskModel(
        taskId: json['Task_Id'],
        taskName: json['Task_Name'],
        taskDate: json['Task_Date'],
        taskTime: json['Time'],
        estimatedTime: json['Estimated_Time'],
        entryDate: json['Entry_Date'],
        remark: json['Remark'],
        customerId: json['Customer_Id'],
        customerLocation: json['Location_Name'],
        customerRequestId: json['Customer_Request_Id']);
  }
}
