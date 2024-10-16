import 'package:flutter/material.dart';

class CustomButtonItem extends StatelessWidget {
  const CustomButtonItem({
    super.key,
    this.onPressed,
    required this.style,
    required this.title,
    required this.backgroundColor,
    this.padding = 10,
    this.borderRadius = 20,
    this.isLoading = false,
  });
  final void Function()? onPressed;
  final Color backgroundColor;
  final TextStyle style;
  final String title;
  final double padding;
  final double borderRadius;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          //  padding: EdgeInsets.all(padding),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius))),
      child: isLoading
          ? const SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                  // color: Colors.black,
                  ),
            )
          : Text(
              title,
              style: style,
            ),
    );
  }
}
