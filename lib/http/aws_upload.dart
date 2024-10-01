import 'dart:io';
import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:aws_s3_upload/enum/acl.dart';
import 'package:darlsco/view/widgets/loader.dart';
import 'package:dio/dio.dart';

class AwsUpload {
  String basePath = 'https://darlsco-files.s3.ap-south-1.amazonaws.com/';
  static Future<String?> uploadToAws(File result) async {
    Loader.showLoader();
    try {
      String filePath = result.path;
      FormData formData = FormData.fromMap({
        "myFile": await MultipartFile.fromFile(filePath,
            filename: result.path.split('/').last),
      });

      final uploadKey = 'Trainee/${DateTime.now().millisecondsSinceEpoch}.png';

      final data = await AwsS3.uploadFile(
        acl: ACL.public_read,
        accessKey: "AKIA3FLD32IEOUCNOQG7",
        secretKey: "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",
        file: result,
        bucket: "darlsco-files",
        region: "ap-south-1",
        key: uploadKey,
        metadata: {"test": "test"},
        contentType: 'image/png', // optional, ensure to specify content type
      );

      Loader.stopLoader();

      // Construct the public URL
      final publicUrl =
          'https://darlsco-files.s3.ap-south-1.amazonaws.com/$uploadKey';
      print('Public URL: $publicUrl');
      return publicUrl;
    } catch (e) {
      Loader.stopLoader();
      print('Error uploading to AWS: $e');
      return null;
    }
  }

  static Future<FormData?> prepareFormData(File result) async {
    try {
      String filePath = result.path;
      FormData formData = FormData.fromMap({
        "myFile": await MultipartFile.fromFile(filePath,
            filename: result.path.split('/').last),
      });

      print('FormData prepared: ${formData.files}');
      return formData;
    } catch (e) {
      print('Error preparing FormData: $e');
      return null;
    }
  }
}
