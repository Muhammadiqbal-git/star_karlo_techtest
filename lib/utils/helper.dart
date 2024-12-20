import 'package:flutter/material.dart';

double getHeight(BuildContext context, num size) {
  return MediaQuery.of(context).size.height * (size / 100);
}

double getWidth(BuildContext context, num size) {
  return MediaQuery.of(context).size.width * (size / 100);
}
