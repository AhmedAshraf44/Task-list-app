import 'package:flutter/material.dart';
import 'build_button.dart';
import 'custom_list_view.dart';

class TaskViewBody extends StatelessWidget {
  const TaskViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BuildButton(),
        CustomListView(),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
