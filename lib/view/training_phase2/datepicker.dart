import 'package:flutter/material.dart';

class DatePickerExample extends StatefulWidget {
  const DatePickerExample(
      {super.key,
      this.restorationId,
      this.onDateSelected,
      this.hintText = 'Select Date'});

  final String? restorationId;
  final Function(DateTime)? onDateSelected;
  final String hintText;

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample>
    with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2023),
          lastDate: DateTime(2025),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        widget.onDateSelected?.call(_selectedDate.value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        readOnly: true,
        controller: TextEditingController(
            text:
                '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFCECECE),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFCECECE),
            ),
          ),
          hintText: widget.hintText,
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFF294C73),
            ),
            onPressed: () {
              _restorableDatePickerRouteFuture.present();
            },
          ),
        ),
      ),
    );
  }
}
