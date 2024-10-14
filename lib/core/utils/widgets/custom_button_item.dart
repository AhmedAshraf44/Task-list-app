import 'package:flutter/material.dart';

class CustomButtonItem extends StatelessWidget {
  const CustomButtonItem({
    super.key,
    this.onPressed,
    required this.style,
    required this.title,
    required this.backgroundColor,
    this.padding = 0,
    this.borderRadius = 20,
  });
  final void Function()? onPressed;
  final Color backgroundColor;
  final TextStyle style;
  final String title;
  final double padding;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          //padding: EdgeInsets.all(padding),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius))),
      child: Text(
        title,
        style: style,
      ),
    );
  }
}
