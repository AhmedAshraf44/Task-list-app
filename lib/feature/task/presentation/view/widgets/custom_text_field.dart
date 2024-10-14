import 'package:flutter/material.dart';
import 'package:task_app/constants.dart';
import 'package:task_app/core/utils/app_style.dart';

import '../../../../../core/functions/build_border.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.onSaved,
    this.onChanged,
    this.initialValue,
  });
  final String? hint;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Feiled is Required';
        } else {
          return null;
        }
      },
      onSaved: onSaved,
      onChanged: onChanged,
      cursorColor: kPrimaryColor,
      initialValue: initialValue,
      decoration: InputDecoration(
        fillColor: const Color(0xffD9D9D9).withOpacity(.2),
        filled: true,
        disabledBorder: buildBorder(),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(kPrimaryColor),
        hintText: hint,
        hintStyle: AppStyle.textStyle12
            .copyWith(color: const Color(0xff000000).withOpacity(.5)),
      ),
    );
  }
}
