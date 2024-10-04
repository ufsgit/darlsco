import 'dart:io';

import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/telr/telr_dummy_page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfPath;
  final String fileName;
  const PDFViewerPage(
      {required this.pdfPath, super.key, required this.fileName});

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePdf();
  }

  Future<bool> _downloadAndSavePdf() async {
    try {
      String filePath = '';

      final url =
          'https://darlsco-files.s3.ap-south-1.amazonaws.com/${widget.pdfPath}';
      print(url);
      ;
      final dio = Dio();

      if (Platform.isAndroid) {
        var dir = Directory('/storage/emulated/0/Downloads');
        filePath = "${dir.path}/${widget.fileName}.pdf";
      } else {
        var dir = await getApplicationDocumentsDirectory();

      print('jbutfghbn ${dir.path}');
        filePath = "${dir.path}/${widget.fileName}.pdf";
      }

      // Request storage permission
      var status = await Permission.storage.status;
      print('hiii permission asked 2 $status');
      bool havePermission = false;

      if (!status.isGranted) {
        // If permission is denied, request it
        await Permission.storage.request();
        status = await Permission.storage.status; // Check the status again
        final request = await [
          Permission.photos,
          Permission.videos,
          // Permission.storage,
          Permission.manageExternalStorage,
          //..... as needed
        ].request();
        havePermission = request.values
            .every((status) => status == PermissionStatus.granted);
      }

      // Proceed only if permission is granted
      if (status.isGranted || havePermission) {
        
        await dio.download(url, filePath);
        setState(() {
          localPath = filePath;
        });

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('${widget.fileName} Downloaded'),
        //   ),
        // );
        return true;
      } else {
        await Permission.storage.request();
        status = await Permission.storage.status;
        print('Storage permission is denied');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content:
        //         Text('Storage permission is denied. Cannot download file.'),
        //   ),
        // );
        return false;
      }
    } catch (e) {
      print('Error downloading ${widget.fileName}: $e');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Error downloading ${widget.fileName}'),
      //   ),
      // );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: ColorResources.backgroundColors3[0],
          actions: [
            IconButton(
              onPressed: () async => await _downloadAndSavePdf().then((v) =>
                  Get.snackbar(
                      '${widget.fileName} ${v ? 'Downloaded' : "Can't Download"}',
                      v ? 'Tap to open' : '',
                      duration: Duration(seconds: 2),
                      backgroundColor:
                          v ? ColorResources.colorBlue : Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM, onTap: (s) async {
                    if (v) {
                      if (Platform.isAndroid) {
                        DeviceInfoPlugin plugin = DeviceInfoPlugin();
                        AndroidDeviceInfo android = await plugin.androidInfo;
                        if (android.version.sdkInt != null &&
                                android.version.sdkInt! <= 33 ||
                            Platform.isIOS) {
                          final result = await OpenFile.open(localPath);

                          print(
                              'Open File Result: ${result.type}, Message: ${result.message}');
                        } else {
                          await launchUrl(Uri.parse(
                              'https://darlsco-files.s3.ap-south-1.amazonaws.com/${widget.pdfPath}'));
                        }
                      } else {
                        final result = await OpenFile.open(localPath);
                      }
                    }
                  })),
              icon: const Icon(Icons.download),
            ),
          ],
          title: Text(
            'Certificate',
            style: TextStyle(
              fontSize: 32.sp.h,
              color: ColorResources.color294C73,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              radius: 18.h,
              backgroundColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30.h,
                  color: ColorResources.color294C73,
                ),
              ),
            ),
          ),
        ),
        body: commonBackgroundLinearColorCart(
            childWidget: localPath != null
                ? PDFView(filePath: localPath)
                : const Column(
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )
            // childWidget: SingleChildScrollView(
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           children: [
            //             InkWell(
            //               onTap: () {
            //                 Get.back();
            //               },
            //               child: CircleAvatar(
            //                 radius: 18.h,
            //                 backgroundColor: Colors.transparent,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(left: 8),
            //                   child: Icon(
            //                     Icons.arrow_back_ios,
            //                     size: 30.h,
            //                     color: ColorResources.color294C73,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             const Spacer(),
            //             IconButton(
            //                 onPressed: () => _downloadAndSavePdf().then(
            //                       (value) =>
            //                           ScaffoldMessenger.of(context).showSnackBar(
            //                         const SnackBar(
            //                           content: Text('PDF Downloded'),
            //                         ),
            //                       ),
            //                     ),
            //                 icon: const Icon(Icons.download))
            //           ],
            //         ),
            //         Text(
            //           'Certificate',
            //           style: TextStyle(
            //             fontSize: 32.sp.h,
            //             color: ColorResources.color294C73,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         SizedBox(
            //           height: 16.h,
            //         ),
            //         localPath != null
            //             ? ClipRRect(
            //               borderRadius: BorderRadius.circular(8),
            //               child: PDFView(
            //                 filePath: localPath,
            //               ),
            //             )
            //             : const Center(child: CircularProgressIndicator()),
            //       ],
            //     ),
            //   ),
            // ),
            ),
      ),
    );
  }
}
