class GetOtpModel {
  List<GetOtp> data;

  GetOtpModel({
    required this.data,
  });

  factory GetOtpModel.fromJson(Map<String, dynamic> json) => GetOtpModel(
        data: List<GetOtp>.from(json["Data"].map((x) => GetOtp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetOtp {
  int customerId;
  int otp;
  String phone;

  GetOtp({
    required this.customerId,
    required this.otp,
    required this.phone,
  });

  factory GetOtp.fromJson(Map<String, dynamic> json) => GetOtp(
        customerId: json["Customer_Id"],
        otp: json["OTP"],
        phone: json["Phone"],
      );

  Map<String, dynamic> toJson() => {
        "Customer_Id": customerId,
        "OTP": otp,
        "Phone": phone,
      };
}
