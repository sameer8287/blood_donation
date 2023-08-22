import 'package:blood_donation/constant/colors.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CustomDateTimePicker extends ConsumerStatefulWidget {
  // DateTime selectedValue;
  String hint;
  final Function(dynamic)? getValue;
  CustomDateTimePicker({super.key, required this.getValue, required this.hint});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends ConsumerState<CustomDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.960,
      height: 50.h,
      child: DateTimeField(
        decoration: InputDecoration(
            label: Text(widget.hint),
            hintText: 'Select Date',
            hintStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: txtBorderColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: txtBorderColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: txtBorderColor))),
        format: DateFormat("yyyy-MM-dd hh:MM:ss"),
        onShowPicker: (context, currentValue) async {
          return await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          ).then((DateTime? date) async {
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );

              final x = DateTimeField.combine(date, time);
              // widget.selectedValue = x;
              // ignore: unrelated_type_equality_checks
              widget.getValue!(x.toString());

              return x;
            } else {
              return currentValue;
            }
          });
        },
      ),
    );
  }
}
