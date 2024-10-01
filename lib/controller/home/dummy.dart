// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart'; // Add this dependency if you haven't already

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   _CategoryScreenState createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   List<CategorySelectModelElement> _categoryDataList = [];
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   void fetchData() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       var response = await Dio().get(
//         'https://0924-103-214-232-135.ngrok-free.app/Public_Data/Get_Training_Course_Details_App/13', // Replace this with your API endpoint
//       );

//       if (response.statusCode == 200) {
//         final responseData = response.data as List<dynamic>;

//         List<CategorySelectModelElement> categoryDataList = [];

//         for (var sublist in responseData) {
//           if (sublist is List<dynamic> && sublist.isNotEmpty) {
//             for (var data in sublist) {
//               if (data is Map<String, dynamic>) {
//                 categoryDataList.add(CategorySelectModelElement.fromJson(data));
//               }
//             }
//           }
//         }

//         setState(() {
//           _categoryDataList = categoryDataList;
//           _isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load category data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching category data: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Category Prices and Application Fees'),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _categoryDataList.length,
//               itemBuilder: (context, index) {
//                 final category = _categoryDataList[index];
//                 return ListTile(
//                   title: Text(category.categoryName ?? ''),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Duration: ${category.duration ?? ''}'),
//                       Text(
//                           'Application Fees: \$${category.applicationFees ?? ''}'),
//                       Text(
//                           'Examination Fees: \$${category.examinationFees ?? ''}'),
//                       Text(
//                           'Certificate Fees: \$${category.certificateFees ?? ''}'),
//                       Text(
//                           'Training with Exam Fees: \$${category.trainingwithExamFees ?? ''}'),
//                       Text(
//                           'Retake Only Written Fees: \$${category.retakeOnlyWritenFess ?? ''}'),
//                       Text(
//                           'Retake Only Practical Fees: \$${category.retakeOnlyPracticalFees ?? ''}'),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// Models
class CategorySelectModelElement {
  int trainingCourseId;
  String? trainingCourseName;
  String description;
  String? fileName;
  dynamic imageName;
  int statusId;
  String statusName;
  int deleteStatus;
  int? trainingCourseCategoryId;
  String? categoryName;
  String? duration;
  String? applicationFees;
  String? examinationFees;
  String? certificateFees;
  String? trainingwithExamFees;
  String? retakeOnlyWritenFess;
  String? retakeOnlyPracticalFees;
  String? examinationTax;
  String? applicationTax;
  String? certificateTax;
  String? serviceCharge;
  String? tax;
  String? retakeOnlyWrittenTax;
  String? retakeOnlyPracticalTax;

  CategorySelectModelElement({
    required this.trainingCourseId,
    this.trainingCourseName,
    required this.description,
    this.fileName,
    this.imageName,
    required this.statusId,
    required this.statusName,
    required this.deleteStatus,
    this.trainingCourseCategoryId,
    this.categoryName,
    this.duration,
    this.applicationFees,
    this.examinationFees,
    this.certificateFees,
    this.trainingwithExamFees,
    this.retakeOnlyWritenFess,
    this.retakeOnlyPracticalFees,
    this.applicationTax,
    this.certificateTax,
    this.examinationTax,
    this.tax,
    this.retakeOnlyPracticalTax,
    this.retakeOnlyWrittenTax,
    this.serviceCharge,
  });

  factory CategorySelectModelElement.fromJson(Map<String, dynamic> json) =>
      CategorySelectModelElement(
        trainingCourseId: json["Training_Course_Id"],
        trainingCourseName: json["Training_Course_Name"],
        description: json["Description"] ?? '',
        fileName: json["File_Name"],
        imageName: json["Image_name"],
        statusId: json["Status_Id"],
        statusName: json["Status_Name"],
        deleteStatus: json["DeleteStatus"],
        trainingCourseCategoryId: json["Training_Course_Category_Id"],
        categoryName: json["Category_Name"],
        duration: json["Duration"],
        applicationFees: json["Application_Fees"],
        examinationFees: json["Examination_Fees"],
        certificateFees: json["Certificate_Fees"],
        trainingwithExamFees: json["TrainingwithExam_Fees"],
        retakeOnlyWritenFess: json["RetakeOnly_Writen_Fess"],
        retakeOnlyPracticalFees: json["RetakeOnly_Practical_Fees"],
        examinationTax: json['Examination_Tax'] ?? '0.00',
        applicationTax: json['Application_Tax'] ?? '0.00',
        certificateTax: json['Certificate_Tax'] ?? '0.00',
        tax: json["Tax"] ?? '0.00',
        retakeOnlyPracticalTax: json["Retake_Only_Practical_Tax"],
        retakeOnlyWrittenTax: json["Retake_Only_Written_Tax"],
        serviceCharge: json["Service_Charge"] ?? '2.5',
      );

  Map<String, dynamic> toJson() => {
        "Training_Course_Id": trainingCourseId,
        "Training_Course_Name": trainingCourseName,
        "Description": description,
        "File_Name": fileName,
        "Image_name": imageName,
        "Status_Id": statusId,
        "Status_Name": statusName,
        "DeleteStatus": deleteStatus,
        "Training_Course_Category_Id": trainingCourseCategoryId,
        "Category_Name": categoryName,
        "Duration": duration,
        "Application_Fees": applicationFees,
        "Examination_Fees": examinationFees,
        "Certificate_Fees": certificateFees,
        "TrainingwithExam_Fees": trainingwithExamFees,
        "RetakeOnly_Writen_Fess": retakeOnlyWritenFess,
        "RetakeOnly_Practical_Fees": retakeOnlyPracticalFees,
        "Examination_Tax": examinationTax,
        "Application_Tax": applicationTax,
        "Certificate_Tax": certificateTax,
        "Tax": tax,
        "Retake_Only_Practical_Tax": retakeOnlyPracticalTax,
        "Retake_Only_Written_Tax": retakeOnlyWrittenTax,
        "Service_Charge": serviceCharge,
      };
}
