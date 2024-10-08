import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:darlsco/view/sample/widgets/inspection_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SampleHomeScreen extends StatefulWidget {
  const SampleHomeScreen({super.key});

  @override
  State<SampleHomeScreen> createState() => _SampleHomeScreenState();
}

class _SampleHomeScreenState extends State<SampleHomeScreen> {
  TextEditingController inspectionDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton.filledTonal(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white)),
            onPressed: () {},
            icon: const Icon(
              Icons.power_settings_new_rounded,
            ),
          ),
          const SizedBox(width: 16, height: 10),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/inspection_logo.png',
                height: 30,
                width: 30,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: 5),
              Text(
                'Inspection',
                style: AppStyles.getHeadingTextStyle(
                    fontColor: AppColors.primaryBlue),
              ),
            ],
          ),
          SizedBox(height: 16),
          InspectionCardWidget(),
          Text(
            "  We’re ready to Inspect",
            style: AppStyles.getHeadingTextStyle(),
          ),
          SizedBox(height: 16),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/inspection_cover_image.png'),
                  SizedBox(height: 16),
                  Text(
                    'Please Fill Out This Form',
                    style: AppStyles.getHeadingTextStyle(),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                      value: null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.black))),
                      onChanged: (value) {},
                      hint: const Text(
                        'Location',
                        style: TextStyle(color: Colors.black),
                      ),
                      items: data
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ))
                          .toList()),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: AppStyles.getSecondaryButtonStyle(context),
                    child: Text(
                      'Choose Equipment',
                    ),
                  ),
                  SizedBox(height: 12),
                  datepickerWidget(
                      titleSpacing: 0,
                      initialDate: DateTime.now(),
                      startDate: DateTime.now(),
                      context: context,
                      datePickController: inspectionDateController,
                      labelText: 'Inspection Date',
                      titleText: ''),
                  SizedBox(height: 12),
                  TextFormField(
                    maxLines: 3,
                    maxLength: 250,
                    decoration:  InputDecoration(
                      // prefixIcon: Icon(Icons.chat_bubble_outline),
                      labelText: 'Remark',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                            255,
                            27,
                            27,
                            27,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column datepickerWidget(
      {required BuildContext context,
      required String labelText,
      required DateTime initialDate,
      required DateTime startDate,
      required double titleSpacing,
      required TextEditingController datePickController,
      required String titleText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: titleSpacing.h,
        ),
        SizedBox(
          height: 80.h,
          child: TextField(
            style: TextStyle(fontSize: 14.sp),
            controller: datePickController,
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18.sp,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black)),
                label: Text(
                  labelText,
                  style: const TextStyle(color: Colors.black),
                )),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  barrierDismissible: false,
                  context: context,
                  initialDate: initialDate,
                  firstDate: startDate,
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);

                setState(() {
                  datePickController.text = formattedDate;
                });
              } else {}
            },
          ),
        ),
      ],
    );
  }
}

List<String> data = ['Trans Asia', 'Uduppi'];
