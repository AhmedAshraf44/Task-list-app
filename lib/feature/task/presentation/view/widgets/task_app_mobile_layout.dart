import 'package:flutter/material.dart';
import 'package:task_app/feature/task/data/model/task_model.dart';
import 'package:task_app/feature/task/presentation/view/widgets/build_button.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_conditional_builder.dart';

class TaskAppMobileLayout extends StatelessWidget {
  const TaskAppMobileLayout({
    super.key,
    required this.tasks,
  });
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BuildButton(),
        CustomConditionalBuilder(
          tasks: tasks,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
