import 'package:flutter/material.dart';

import 'package:task_app/constants.dart';
import 'package:task_app/feature/task/presentation/view/widgets/edit_task_view_body.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({
    super.key,
    required this.title,
    required this.date,
    required this.id,
  });
  final String title, date;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: EditTaskViewBody(
          date: date,
          title: title,
          id: id,
        ));
  }
}
