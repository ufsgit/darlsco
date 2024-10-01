class LoginOtpModel {
  String customerId;
  String customerType;
  String customerName;
  String customerMobileNo;

  LoginOtpModel(
      {
        required this.customerId,
      required this.customerType,
      required this.customerName,
      required this.customerMobileNo
      
      
      });
  factory LoginOtpModel.fromJson(json) {
    return LoginOtpModel(
        customerId:json['Id'].toString() ,
        customerType: json['tp'].toString(),
        customerName: json['Name'].toString(),
        customerMobileNo: json['Mobile'].toString()
        );
  }
}
