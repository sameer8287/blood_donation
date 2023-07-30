
import 'package:blood_donation/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomDiscriptionBox extends StatefulWidget {
  TextEditingController notes = TextEditingController();
  String? txt;
    CustomDiscriptionBox({
      super.key,
      required this.notes,
      required this.txt
      });

  @override
  State<CustomDiscriptionBox> createState() => _CustomDiscriptionBoxState();
}

class _CustomDiscriptionBoxState extends State<CustomDiscriptionBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
                child: TextFormField(
                  controller: widget.notes,
                  maxLength: 140,
                  maxLines: 3,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      label: RichText(
                        text: TextSpan(
                          text: widget.txt,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              // fontWeight: FontWeight.w600,
                              fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' *',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      hintText: widget.txt,
                      hintStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontStyle: FontStyle.normal),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: txtBorderColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: txtBorderColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: txtBorderColor))),
                ),
              );
  }
}