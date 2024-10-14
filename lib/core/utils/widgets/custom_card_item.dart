import 'package:flutter/material.dart';
import 'package:task_app/core/utils/app_style.dart';

import '../../../constants.dart';

class CustomCardItem extends StatelessWidget {
  const CustomCardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 4,
      color: const Color(0xFFFDFDFD),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 18, right: 20, top: 10, bottom: 10),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: const Text(
            'Build UI Android',
            style: AppStyle.textStyle15,
          ),
          subtitle: const Text(
            'Due Date: Mon. 21/3/2024',
            style: AppStyle.textStyle12,
          ),
          trailing: CircleAvatar(
            backgroundColor: const Color(0xff4ECB71).withOpacity(0.25),
            maxRadius: 15,
            child: const Icon(
              Icons.check,
              color: kPrimaryColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
