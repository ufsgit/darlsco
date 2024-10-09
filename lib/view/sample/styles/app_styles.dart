import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle getHeadingTextStyle({double? fontSize, Color? fontColor}) {
    return GoogleFonts.plusJakartaSans(
        fontSize: fontSize ?? 18,
        fontWeight: FontWeight.w700,
        color: fontColor);
  }

  static TextStyle getBodyTextStyle({double? fontSize, Color? fontColor}) {
    return GoogleFonts.plusJakartaSans(
        fontSize: fontSize ?? 12,
        fontWeight: FontWeight.w500,
        color: fontColor);
  }

  static ButtonStyle getSecondaryButtonStyle(BuildContext context,
      {double? width, double? height}) {
    return OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryBlue,
        textStyle: AppStyles.getHeadingTextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      
        side: BorderSide(
          color: AppColors.primaryBlue,
        ),
        fixedSize:
            Size(width ?? MediaQuery.sizeOf(context).width, height ?? 45));
  }

  static ButtonStyle getPrimaryButtonStyle(BuildContext context,
      {double? width, double? height}) {
    return ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor:Colors.white,
        textStyle: AppStyles.getHeadingTextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      
        side: BorderSide(
          color: AppColors.primaryBlue,
        ),
        fixedSize:
            Size(width ?? MediaQuery.sizeOf(context).width, height ?? 45));
  }
}
