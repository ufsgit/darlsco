import 'dart:io';

import 'package:darlsco/core/constants/image_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/common_widgets.dart';

class UserBlockScreen extends StatefulWidget {

  const UserBlockScreen({super.key});

  @override
  State<UserBlockScreen> createState() => _UserBlockScreenState();
}

class _UserBlockScreenState extends State<UserBlockScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1),(){

      showPopBlockPopup(context); 





    });
   
   
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      drawer: const Drawer(),
      body: commonBackgroundLinearColor(
          childWidget: Center(
        child: Image.asset(
          splashScreenLogo,
          width: 210.w,
          height: 98.h,
        ),
      )),
    );
  }
}

 showPopBlockPopup(context)async{

  showDialog(
    

    barrierDismissible: false,
    
    
    context: context,
  builder: (context)=> AlertDialog(
    
    
    
    content: SizedBox(
      height: 200.h,
      child: Column( 

        mainAxisAlignment: MainAxisAlignment.center,
        
        
        
        
        children: [

          Image(
             width: 100.w,
          height: 100.h,
            
            
            image: AssetImage( splashScreenLogo)),
      
       const Text('you are not updated the application please update  and relaunch the app'),

        TextButton(onPressed: ()async{
          if(Platform.isAndroid){
             await launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.inspection.darlsco'));

          }else{
             await launchUrl(Uri.parse('https://apps.apple.com/in/app/darlsco-inspection-services/id6480330936'));

          }
        

          

        }, child: const Text('Update'))
      
      
      
      
      ]),
    ),



  ),

  
  
  
  );

 

}