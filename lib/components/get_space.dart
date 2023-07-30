import 'package:flutter/material.dart';

Widget getVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget getHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
