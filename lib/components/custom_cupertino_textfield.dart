import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoTextField extends StatefulWidget {
  String hint;
  TextEditingController txtController = TextEditingController();
  CustomCupertinoTextField(
      {super.key, required this.hint, required this.txtController});

  @override
  State<CustomCupertinoTextField> createState() =>
      _CustomCupertinoTextFieldState();
}

class _CustomCupertinoTextFieldState extends State<CustomCupertinoTextField> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholder: widget.hint,
      controller: widget.txtController,
      placeholderStyle: TextStyle(color: Colors.black38),
      style: TextStyle(color: Colors.black54),
      decoration: BoxDecoration(
          color: CupertinoColors.extraLightBackgroundGray,
          border: Border.all(
            color: CupertinoColors.lightBackgroundGray,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
