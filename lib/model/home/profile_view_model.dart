class ProfileViewModel {
  String customerId;
  String customerName;
  String mobile;
  String email;
  String contactName;
  // String companyName;
  String emiratesId;
  String emiratesDate;
  String countryCodeName;
  String countryCodeId;
  int individual;
  int corporate;
  String tradeLicenceNo;
  String tradeLicenceExpiryDate;

  String filePath;

  ProfileViewModel({
    required this.customerId,
    required this.customerName,
    required this.mobile,
    required this.email,
    required this.contactName,
    // required this.companyName,
    required this.emiratesId,
    required this.emiratesDate,
    required this.countryCodeName,
    required this.countryCodeId,
    required this.corporate,
    required this.individual,
    required this.tradeLicenceExpiryDate,
    required this.tradeLicenceNo,
    required this.filePath,
  });

  factory ProfileViewModel.fromJson(Map<String, dynamic> json) =>
      ProfileViewModel(
        customerId: json["Customer_Id_"] ?? '',
        customerName: json["Customer_Name"] ?? '',
        mobile: json["Mobile"] ?? '',
        email: json["Email"] ?? '',
        contactName: json["Contact_Name"] ?? '',
        // companyName: json["Company_Name_"],
        emiratesId: json["Emirates_Id"] ?? '',
        emiratesDate: json["Emirates_Date"] ?? '',
        countryCodeName: json["Country_Code_Name"] ?? '',
        countryCodeId: json["Country_Code_Id"] ?? '',
        corporate: json["Coorporate"] ?? 0,
        individual: json["Individual"] ?? 0,
        tradeLicenceNo: json["Trade_License_No"] ?? '',
        tradeLicenceExpiryDate: json["Trade_License_No_Expiry_Date"] ?? '',
        filePath: json["File_Path"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Customer_Id_": customerId,
        "Customer_Name": customerName,
        "Mobile": mobile,
        "Email": email,
        "Contact_Name": contactName,
        // "Company_Name_": companyName,
        "Emirates_Id": emiratesId,
        "Emirates_Date": emiratesDate,

        "Country_Code_Name": countryCodeName,
        "Country_Code_Id": countryCodeId,
        "Individual": individual,
        "Coorporate": corporate,
        "Trade_License_No": tradeLicenceNo,
        "Trade_License_No_Expiry_Date": tradeLicenceExpiryDate,
        "File_Path_": filePath
      };
}
