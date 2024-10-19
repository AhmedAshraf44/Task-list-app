import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:task_app/feature/task/data/model/task_model.dart';
import 'package:task_app/feature/task/presentation/view/widgets/build_task_empty.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_list_view.dart';

class CustomConditionalBuilder extends StatelessWidget {
  const CustomConditionalBuilder({
    super.key,
    required this.tasks,
  });

  final List<TaskModel> tasks;
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => CustomListView(
        tasks: tasks,
      ),
      fallback: (context) => const BuildTaskEmpty(),
    );
  }
}
