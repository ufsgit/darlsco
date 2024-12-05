import 'dart:io';

import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/http/http_urls.dart';
import 'package:darlsco/view/training/view_certificate_page.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class CertificatePage extends StatefulWidget {
  const CertificatePage({super.key});

  @override
  State<CertificatePage> createState() => _CertificatePageState();
}

final TrainingControllerHomee trainingHomeController =
    Get.put(TrainingControllerHomee());

class _CertificatePageState extends State<CertificatePage> {
  final Dio _dio = Dio();
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  Future<void> downloadCertificate(String url, String fileName) async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    try {
      String? filePath;
      if (Platform.isAndroid) {
        var dir = Directory('/storage/emulated/0/Download');
        filePath = "${dir.path}/$fileName";
      } else {
        var dir = await getApplicationDocumentsDirectory();
        filePath = "${dir.path}/$fileName";
      }
      await _dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total <= 0) return;
          setState(() {
            _downloadProgress = received / total;
          });
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Certificate downloaded to $filePath"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to download certificate"),
        ),
      );
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: commonBackgroundLinearColorCart(
          childWidget: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30.h,
                      color: ColorResources.color294C73,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  trainingHomeController.certificateDetails.isEmpty
                      ? Container(
                          height: MediaQuery.sizeOf(context).height / 1.3,
                          child: Center(
                            child: Text('No Data found'),
                          ),
                        )
                      : GetBuilder<TrainingControllerHomee>(
                          init: trainingHomeController,
                          builder: (contr) {
                            return ListView.separated(
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 16.h,
                                );
                              },
                              itemCount: contr.certificateDetails.length,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final certificate =
                                    contr.certificateDetails[index];
                                final hasCertificate =
                                    certificate.certificate.isNotEmpty;

                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26),
                                    color: ColorResources.whiteColor,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            certificate.trainingCourseName,
                                            style: GoogleFonts.dmSans(
                                              color: ColorResources.color294C73,
                                              fontSize: 18.sp.h,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h.w,
                                          ),
                                          Container(
                                            height: 90.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: ColorResources.colorF1F8FF,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          certificate
                                                              .traineeName,
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            color: ColorResources
                                                                .color294C73,
                                                            fontSize: 17.sp.h,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      containerWidget(
                                                        text: 'Passed',
                                                        height: 22.w.h,
                                                        width: 65.w.h,
                                                        bgColor: ColorResources
                                                            .colorD2EAFF,
                                                        textColor:
                                                            ColorResources
                                                                .colorBlue,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      certificateButtonWidget(
                                                        onTap: hasCertificate
                                                            ? () {
                                                                Get.to(() => PDFViewerPage(
                                                                    fileName:
                                                                        certificate
                                                                            .trainingCourseName,
                                                                    pdfPath:
                                                                        certificate
                                                                            .certificate));
                                                              }
                                                            : null,
                                                        text:
                                                            'View Certificate',
                                                        color: hasCertificate
                                                            ? ColorResources
                                                                .whiteColor
                                                            : Colors.grey
                                                                .withOpacity(
                                                                    .6),
                                                        textColor: hasCertificate
                                                            ? ColorResources
                                                                .colorFF0950A0
                                                            : ColorResources
                                                                .whiteColor,
                                                        borderColor: hasCertificate
                                                            ? ColorResources
                                                                .colorFF0950A0
                                                            : Colors.grey
                                                                .withOpacity(
                                                                    .6),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      _isDownloading
                                                          ? CircularProgressIndicator(
                                                              value:
                                                                  _downloadProgress,
                                                              valueColor:
                                                                  const AlwaysStoppedAnimation<
                                                                      Color>(
                                                                ColorResources
                                                                    .colorFF0950A0,
                                                              ),
                                                            )
                                                          : certificateButtonWidget(
                                                              onTap:
                                                                  hasCertificate
                                                                      ? () {
                                                                          downloadCertificate(
                                                                              '${HttpUrls.imageBase}${certificate.certificate}',
                                                                              "certificate_${index + 1}.pdf");
                                                                        }
                                                                      : null,
                                                              text:
                                                                  'Download certificate',
                                                              color: hasCertificate
                                                                  ? ColorResources
                                                                      .colorFF0950A0
                                                                  : Colors.grey
                                                                      .withOpacity(
                                                                          .6),
                                                              textColor: hasCertificate
                                                                  ? ColorResources
                                                                      .whiteColor
                                                                  : ColorResources
                                                                      .whiteColor,
                                                              borderColor: hasCertificate
                                                                  ? ColorResources
                                                                      .colorFF0950A0
                                                                  : Colors.grey
                                                                      .withOpacity(
                                                                          .6),
                                                            ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
