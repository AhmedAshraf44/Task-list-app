import 'package:flutter/material.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_conditional_builder.dart';
import 'build_button.dart';

class TaskViewBody extends StatelessWidget {
  const TaskViewBody({
    super.key,
    required this.tasks,
  });
  final List<Map<dynamic, dynamic>> tasks;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
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
