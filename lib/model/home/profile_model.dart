class ProfileEditModel {
  int customerId;
  String customerName;
  String mobile;
  String email;
  String contactName;
  // String companyName;
  String emiratesId;
  DateTime? emiratesDate;
  String countryCodeName;
  String countryCodeId;
  String individual;
  String corporate;
  String tradeLicenceNo;
  DateTime? tradeLicenceExpiryDate;

  String? filePath;

  ProfileEditModel({
    required this.customerId,
    required this.customerName,
    required this.mobile,
    required this.email,
    required this.contactName,
    // required this.companyName,
    required this.emiratesId,
    this.emiratesDate,
    required this.countryCodeName,
    required this.countryCodeId,
    required this.corporate,
    required this.individual,
    this.tradeLicenceExpiryDate,
    required this.tradeLicenceNo,
    required this.filePath,
  });

  factory ProfileEditModel.fromJson(Map<String, dynamic> json) =>
      ProfileEditModel(
        customerId: int.parse(json["Customer_Id_"]),
        customerName: json["Customer_Name_"] ?? '',
        mobile: json["Mobile_"] ?? '',
        email: json["Email_"] ?? '',
        contactName: json["Contact_Name_"] ?? '',
        // companyName: json["Company_Name_"],
        emiratesId: json["Emirates_Id_"] ?? "",
        emiratesDate: DateTime.parse(json["Emirates_Date_"]),
        countryCodeName: json["Country_Code_Name_"] ?? '',
        countryCodeId: json["Country_Code_Id_"] ?? '',
        corporate: json["Corporate_"] ?? '',
        individual: json["Individual_"] ?? '',
        tradeLicenceNo: json["Trade_License_No_"] ?? '',
        tradeLicenceExpiryDate: json["Trade_License_No_Expiry_Date_"] ?? '',
        filePath: json["File_Path_"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Customer_Id_": customerId,
        "Customer_Name_": customerName,
        "Mobile_": mobile,
        "Email_": email,
        "Contact_Name_": contactName,
        // "Company_Name_": companyName,
        "Emirates_Id_": emiratesId,
        // "Emirates_Date_":
        //     "${emiratesDate.year.toString().padLeft(4, '0')}-${emiratesDate.month.toString().padLeft(2, '0')}-${emiratesDate.day.toString().padLeft(2, '0')}",
        "Country_Code_Name_": countryCodeName,
        "Country_Code_Id_": countryCodeId,
        "Individual_": individual,
        "Corporate_": corporate,
        "Trade_License_No_": tradeLicenceNo,
        "Trade_License_No_Expiry_Date_": tradeLicenceExpiryDate,
        "File_Path_": filePath
      };
}
