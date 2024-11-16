import 'dart:developer';
import 'dart:io';

import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
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

class _PDFViewerPageState extends State<PDFViewerPage>
    with WidgetsBindingObserver {
  String? localPath;
  bool isIinitstate = false;
  int fileNumber = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _downloadAndSavePdf(isInitState: isIinitstate);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print('App is in background');
      _downloadAndSavePdf(isInitState: isIinitstate);
      Get.back();
    } else if (state == AppLifecycleState.resumed) {
      print('App is in foreground');
      // _downloadAndSavePdf();
    }
  }

  Future<bool> _downloadAndSavePdf({required bool isInitState}) async {
    // PermissionStatus photoStatus =await Permission.photos.status;
    PermissionStatus storage = await Permission.storage.status;
    if(await Permission.storage.isLimited){
      Get.back();

    await Permission.photos.request();
    await Permission.storage.request();
    }
    if (storage.isDenied) {
      
    await Permission.photos.request();
    await Permission.storage.request();
    }
    // await Permission.manageExternalStorage.request();
    Dio dio = Dio();

    try {
    String filePath = '';
    final url =
        'https://darlsco-files.s3.ap-south-1.amazonaws.com/${widget.pdfPath}';
    log('PDF SAVE : URL = $url');
    Directory dir;

    if (Platform.isAndroid) {
      log('PDF SAVE : isAndroid =true');
      DeviceInfoPlugin plugin = DeviceInfoPlugin();
      AndroidDeviceInfo android = await plugin.androidInfo;
      log('SDK ${android.version.sdkInt}');
      if (android.version.sdkInt >= 31) {
        log('true');
        dir = await getExternalStorageDirectory() ??
            Directory('/storage/emulated/0/Download');
      } else {
        dir = Directory('/storage/emulated/0/Download');
      }
      if (await File(filePath).exists()) {
        Set<int> fileNumbers = {};
        List<FileSystemEntity> filesList = dir.listSync();
        log('FileNumber $fileNumber');
        for (var i = 0; i < filesList.length; i++) {
          String path = filesList[i].path;
          try {
            fileNumbers.add(
              int.parse(path
                  .split('/')
                  .last
                  .split('-')
                  .last
                  .replaceRange(1, null, ' ')
                  .trim()),
            );
          } catch (e) {
         
          }
        }
        log('FileList $filesList');
        int highestNumber = fileNumbers
            .reduce((value, element) => value > element ? value : element);
        setState(() {
          fileNumber = highestNumber + 1;
        });

        print('sdffrw ${filesList.length}');
      }

      log('PDF SAVE : isAndroid filepath = $filePath');
    } else {
      log('PDF SAVE : isAndroid = false');
      dir = await getApplicationDocumentsDirectory();
      filePath = "${dir.path}/${widget.fileName}.pdf";
      log('PDF SAVE : isIOS filepath = $filePath');
    }

    filePath = "${dir.path}/${widget.fileName}-$fileNumber.pdf";
    if (await File(filePath).exists()) {
      Set<int> fileNumbers = {};
      List<FileSystemEntity> filesList = dir.listSync();
      log('FileNumber $fileNumber');
      for (var i = 0; i < filesList.length; i++) {
        String path = filesList[i].path;
        try {
          fileNumbers.add(
            int.parse(path
                .split('/')
                .last
                .split('-')
                .last
                .replaceRange(1, null, ' ')
                .trim()),
          );
        } catch (e) {}
      }
      log('FileList $filesList');
      int highestNumber = fileNumbers
          .reduce((value, element) => value > element ? value : element);
      setState(() {
        fileNumber = highestNumber + 1;
      });

      print('sdffrw ${filesList.length}');
    }

    // Download the file
    if (!isIinitstate) {
      await dio.download(url, filePath, onReceiveProgress: (received, total) {
        // if (total != -1) {
        //   print('Progress: ${(received / total * 100).toStringAsFixed(0)}%');
        // }
      });
    }

    setState(() {
      localPath = filePath;
    });
    print('File downloaded to: $filePath');
    return true;
    } catch (e) {
      print('Error downloading file: $e');
        //  showDialog(context: context, builder:(c)=> AlertDialog(
        //       content: Text(e.toString()),
        //     ));
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
              onPressed: () async {
                if (Platform.isAndroid) {
                  DeviceInfoPlugin plugin = DeviceInfoPlugin();
                  AndroidDeviceInfo android = await plugin.androidInfo;

                  if (android.version.sdkInt >= 33) {
                    await launchUrl(Uri.parse(
                        'https://darlsco-files.s3.ap-south-1.amazonaws.com/${widget.pdfPath}'));
                  } else {
                    await _downloadAndSavePdf(isInitState: false).then((v) =>
                        Get.snackbar(
                            '${widget.fileName}-$fileNumber ${v ? 'Downloaded' : "Can't Download"}',
                            // '${widget.fileName} ${v ? 'Downloaded' : "Can't Download"}',
                            v ? 'Tap to open ' : '',
                            duration: const Duration(seconds: 10),
                            backgroundColor:
                                v ? ColorResources.colorBlue : Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            onTap: (s) async {
                          if (v) {
                            if (Platform.isAndroid) {
                              final result = await OpenFilex.open(localPath!);
                              // DeviceInfoPlugin plugin = DeviceInfoPlugin();
                              // AndroidDeviceInfo android = await plugin.androidInfo;
                              // if (android.version.sdkInt <= 33 ||
                              //     Platform.isIOS) {
                              //   final result = await OpenFilex.open(localPath!);

                              //   print(
                              //       'Open File Result: ${result.type}, Message: ${result.message}');
                              // } else {
                              //   await launchUrl(Uri.parse(
                              //       'https://darlsco-files.s3.ap-south-1.amazonaws.com/${widget.pdfPath}'));
                              // }
                            } else {
                              final result = await OpenFilex.open(localPath!);
                            }
                          }
                        }));
                  }
                } else {
                  _downloadAndSavePdf(isInitState: false).then((v) =>
                      Get.snackbar(
                          '${widget.fileName}-$fileNumber ${v ? 'Downloaded' : "Can't Download"}',
                          // '${widget.fileName} ${v ? 'Downloaded' : "Can't Download"}',
                          v ? 'Tap to open ' : '',
                          duration: const Duration(seconds: 10),
                          backgroundColor:
                              v ? ColorResources.colorBlue : Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          onTap: (s) async {
                        if (v) {
                          if (Platform.isAndroid) {
                            final result = await OpenFilex.open(localPath!);
                            // DeviceInfoPlugin plugin = DeviceInfoPlugin();
                            // AndroidDeviceInfo android = await plugin.androidInfo;
                            // if (android.version.sdkInt <= 33 ||
                            //     Platform.isIOS) {
                            //   final result = await OpenFilex.open(localPath!);

                            //   print(
                            //       'Open File Result: ${result.type}, Message: ${result.message}');
                            // } else {
                            //   await launchUrl(Uri.parse(
                            //       'https://darlsco-files.s3.ap-south-1.amazonaws.com/${widget.pdfPath}'));
                            // }
                          } else {
                            final result = await OpenFilex.open(localPath!);
                          }
                        }
                      }));
                }
              },
              icon: const Icon(Icons.download),
            ),
          ],
          centerTitle: true,
          title: Text(
            'Download',
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

bool checkBackgroundTerminated({localPath}) {
  if (localPath == '') {
    return true;
  }
  return false;
}
