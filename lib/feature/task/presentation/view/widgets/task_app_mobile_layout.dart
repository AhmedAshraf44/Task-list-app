import 'package:flutter/material.dart';
import 'package:task_app/feature/task/presentation/model/task_model.dart';
import 'package:task_app/feature/task/presentation/view/widgets/task_view_body.dart';

class TaskAppMobileLayout extends StatelessWidget {
  const TaskAppMobileLayout({
    super.key,
    required this.tasks,
  });
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return TaskViewBody(
      tasks: tasks,
    );
  }
}
