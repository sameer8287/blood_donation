
import 'package:blood_donation/components/get_space.dart';
import 'package:blood_donation/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String txt;
  // final String value;
  final Icon icn;
  final VoidCallback ontap;
  const CustomCard(
      {super.key, required this.txt, required this.ontap, required this.icn});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -5,
              blurRadius: 15,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 60,
                  width: 60,
                  decoration:
                      BoxDecoration(color: primary, shape: BoxShape.circle),
                  child: icn),
              getVerticalSpace(10),
              Text(
                  textAlign: TextAlign.center,
                  txt,
                  style: Theme.of(context).textTheme.titleMedium
                  // TextStyle(
                  //   fontSize: 22,
                  //   fontWeight: FontWeight.w400,
                  //   color: Theme.of(context).hintColor,
                  // ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
