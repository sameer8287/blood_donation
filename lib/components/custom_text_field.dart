import 'package:blood_donation/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomTextformField extends StatelessWidget {
  TextEditingController cont = TextEditingController();
  String hint;
  String? isEnabled;
  // String label;
  CustomTextformField(
      {super.key, required this.cont, required this.hint, this.isEnabled
      // required this.label
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          hint == 'Phone Number' ? TextInputType.number : TextInputType.text,
      controller: cont,
      enabled: isEnabled == '1' ? false : true,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          label: RichText(
            text: TextSpan(
              text: hint,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  // fontWeight: FontWeight.w600,
                  fontSize: 16),
              children: const <TextSpan>[
                TextSpan(
                    text: ' *',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          hintText: hint,
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
    );
  }
}
