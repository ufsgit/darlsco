import 'package:darlsco/core/constants/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowDialogWidget extends StatelessWidget {
  final void Function()? fromGallery;
  final void Function()? fromCamera;
  const ShowDialogWidget(
      {super.key, required this.fromGallery, required this.fromCamera});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: false,
        shadowColor: ColorResources.colorBlack,
        elevation: 15,
        // title: Text(
        //   'Pick Image',
        //   style: GoogleFonts.dmSans(
        //     color: ColorResources.colorBlack,
        //     fontSize: 18,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        backgroundColor: ColorResources.whiteColor,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: fromGallery,
                  icon: const Icon(Icons.photo_size_select_actual_rounded),
                ),
                Text(
                  'Gallery',
                  style: GoogleFonts.dmSans(
                    color: ColorResources.colorBlack,
                    fontSize: 14.sp.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: fromCamera,
                    icon: const Icon(Icons.camera_alt_rounded)),
                Text(
                  'Camera',
                  style: GoogleFonts.dmSans(
                    color: ColorResources.colorBlack,
                    fontSize: 14.sp.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        )

        // ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //         backgroundColor: ColorResources.color294C73,
        //         shape: const RoundedRectangleBorder()),
        //     onPressed: fromGallery,
        //     child: Text(
        //       'From Gallery',
        //       style: GoogleFonts.dmSans(
        //         color: ColorResources.whiteColor,
        //       ),
        //     )),
        // ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //         backgroundColor: ColorResources.color294C73,
        //         shape: const RoundedRectangleBorder()),
        //     onPressed: fromCamera,
        //     child: Text(
        //       'From Camera',
        //       style: GoogleFonts.dmSans(
        //         color: ColorResources.whiteColor,
        //       ),
        //     )),

        );
  }
}
