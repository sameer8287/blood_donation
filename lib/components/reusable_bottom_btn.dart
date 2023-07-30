
import 'package:blood_donation/constant/colors.dart';
import 'package:flutter/material.dart';

class ReusableBottomButtons extends StatelessWidget {
  final Icon icn;
  final String txt;
  final VoidCallback ontap;

  const ReusableBottomButtons({
    super.key,
    required this.txt,
    required this.icn,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return txt == 'Save'
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: ontap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icn,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Text(
                      txt,
                      style: const TextStyle(color: whiteColor),
                    ),
                  ],
                )),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.4,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primary),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: ontap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icn,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Text(
                      txt,
                      style: const TextStyle(color: primary),
                    ),
                  ],
                )),
          );
  }
}
