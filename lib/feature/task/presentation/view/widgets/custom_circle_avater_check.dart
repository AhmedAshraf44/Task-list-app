import 'package:flutter/material.dart';

class CustomCircleAvaterCheck extends StatelessWidget {
  const CustomCircleAvaterCheck(
      {super.key,
      required this.backgroundColor,
      required this.iconColor,
      this.onTap});
  final Color backgroundColor;
  final Color iconColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        maxRadius: 15,
        child: Icon(
          Icons.check,
          color: iconColor,
          size: 20,
        ),
      ),
    );
  }
}
