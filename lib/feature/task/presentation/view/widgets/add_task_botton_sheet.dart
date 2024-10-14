import 'package:flutter/material.dart';
import 'package:task_app/feature/task/presentation/view/widgets/add_task_form.dart';

class AddTaskBottomSheet extends StatelessWidget {
  const AddTaskBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 16,
        left: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: const SingleChildScrollView(
        child: AddTaskForm(),
      ),
    );
  }
}
