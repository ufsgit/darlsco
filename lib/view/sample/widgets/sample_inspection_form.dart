import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SampleInspectionForm extends StatefulWidget {
  const SampleInspectionForm(
      {super.key, required this.inspectionDateController});
  final TextEditingController inspectionDateController;
  @override
  State<SampleInspectionForm> createState() => _SampleInspectionFormState();
}

class _SampleInspectionFormState extends State<SampleInspectionForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text(
            'Please Fill Out This Form',
            style: AppStyles.getHeadingTextStyle(),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField(
              value: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.black))),
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
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: AppStyles.getSecondaryButtonStyle(context),
            child: const Text(
              'Choose Equipment',
            ),
          ),
          const SizedBox(height: 12),
          datepickerWidget(
              titleSpacing: 0,
              initialDate: DateTime.now(),
              startDate: DateTime.now(),
              context: context,
              datePickController: widget.inspectionDateController,
              labelText: 'Inspection Date',
              titleText: ''),
          const SizedBox(height: 12),
          TextFormField(
            maxLines: 3,
            maxLength: 250,
            decoration: InputDecoration(
              // prefixIcon: Icon(Icons.chat_bubble_outline),
              labelText: 'Remark',
              labelStyle: const TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
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
          const SizedBox(height: 12),
          ElevatedButton(
            style: AppStyles.getPrimaryButtonStyle(context),
            onPressed: () {},
            child: const Text('Confirm Request'),
          ),
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
                    borderSide: const BorderSide(color: Colors.black)),
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

              String formattedDate =
                  DateFormat('dd-MM-yyyy').format(pickedDate!);

              setState(() {
                datePickController.text = formattedDate;
              });
            },
          ),
        ),
      ],
    );
  }
}

List<String> data = ['Trans Asia', 'Uduppi'];
