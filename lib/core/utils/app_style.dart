import 'package:flutter/material.dart';
import 'package:task_app/constants.dart';

abstract class AppStyle {
  static const textStyle12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xff000000),
    fontFamily: 'Inter',
  );

  static const textStyle15 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Color(0xff000000),
    fontFamily: 'Inter',
  );

  static const textStyle13 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: kWhiteColor,
    fontFamily: 'Inter',
  );

  static const textStyleMedium12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    fontFamily: 'Inter',
  );

  static const textStyle30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: Color(0xff000000),
    fontFamily: 'Inter',
  );
}
