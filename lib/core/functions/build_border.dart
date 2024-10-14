import 'package:flutter/material.dart';

OutlineInputBorder buildBorder([color]) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide:
        BorderSide(color: color ?? const Color(0xffD9D9D9).withOpacity(.2)),
  );
}
