class LoginModel {
  int customerId;
 
  String customerType;
  String customerOtp;

  LoginModel({
    required this.customerId,
    required this.customerOtp,

   required  this.customerType,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      customerId: json['Id'],
      customerOtp: json['OTP_'].toString(),
    
      customerType: json['tp'],
    );
  }
}
