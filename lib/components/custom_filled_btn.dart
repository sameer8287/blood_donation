import 'package:blood_donation/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFilledButton extends StatefulWidget {
  final void Function()? onPressed;
  final String buttonText;
  final double width;
  final Color textColor;
  final Color buttonColor;

  const CustomFilledButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.buttonColor = primary,
      this.textColor = whiteColor,
      this.width = 0.45});

  @override
  State<CustomFilledButton> createState() => _CustomFilledButtonState();
}

class _CustomFilledButtonState extends State<CustomFilledButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: widget.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          backgroundColor: widget.buttonColor,
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.buttonText,
          style: TextStyle(

            color: widget.textColor,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
