import 'package:darlsco/controller/login/login_controller.dart';
import 'package:darlsco/http/http_request.dart';
import 'package:darlsco/http/http_urls.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../validations/contact_us/contaus_validations.dart';

final ContactUsController contactUsController = Get.put(ContactUsController());

class ContactUsController extends GetxController {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController additionMessageController = TextEditingController();

  void customerEnquiry(String fNameTxt, String mobText, String emailTxt,
      String messageText, context) async {
    // Loader.showLoader();
    Map<String, dynamic> mapData = {
      'Customer_Name': fNameTxt,
      'Mobile': mobText,
      'Enquiry_Type': 1,
      'Country_Code': loginController.countryCode.isEmpty
          ? homeController.currentCountryCode
          : loginController.countryCode,
      'Email': emailTxt,
      'Description': messageText
    };

    await HttpRequest.httpPostRequest(
      bodyData: mapData,
      endPoint:homeController.isCaliberationSection.value? HttpUrls.saveEnquiriesCaliberation: HttpUrls.saveEnquiries,
    ).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          // Loader.stopLoader();
          clearValues();

          ScaffoldMessenger.of(Get.context!).showSnackBar(
              const SnackBar(
                content: Text('Enquiry sent successfully')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(

              
              
              content: Text('server failure')));
      }
    });
  }

  clearValues() {
    fullnameController.clear();
    mobileNumberController.clear();
    emailController.clear();
    additionMessageController.clear();
  }

  contactFormValidation(String fNameTxt, String mobText, String emailTxt,
      String messageText, BuildContext context) {
    if (fNameTxt.isEmpty ||
        mobText.isEmpty ||
        emailTxt.isEmpty ||
        messageText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(

      dismissDirection: DismissDirection.down,
          clipBehavior: Clip.none, 
          behavior: SnackBarBehavior.fixed,  
            
            content: Text('All  feilds are required!')));
      //api call
    } else if (!ContactUsValidation.fullNameValidation(fNameTxt)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
             
            
            
            
            content: Text('Invalid Full Name!')));
    } else if (!ContactUsValidation.mobileNumberValidation(mobText)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(

             
            
            content: Text('Invalid Contact Number!')));
    } else if (!ContactUsValidation.emailValidation(emailTxt)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
             
            
            content: Text('Invalid Email!')));
    } else if (!ContactUsValidation.fullNameValidation(messageText)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(

             
            
            
            content: Text('Message is required!')));
    } else {
      //api call

      customerEnquiry(fNameTxt, mobText, emailTxt, messageText, context);
    }
  }

  savePublicInspection() async {
    Map<String, dynamic> mapData = {
      "Location": homeController.inspectionLocationController.text,
      'Additional_Message': homeController.inspectionMessageController.text,
      'Equipment': homeController.inspectionCategoryController.text,
    };

    await HttpRequest.httpPostRequest(
      bodyData: mapData,
      endPoint: HttpUrls.savePublicInspection,
    ).then((value) {
      if (value != null) {
        if (value.data.isNotEmpty) {
          homeController.inspectionLocationController.clear();
          homeController.inspectionMessageController.clear();
          homeController.inspectionCategoryController.clear();

          ScaffoldMessenger.of(Get.context!)
              .showSnackBar(const SnackBar(

                 
                
                
                content: Text('Success')));
        }
      }
    });
  }
}
