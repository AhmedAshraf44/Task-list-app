import 'package:flutter/material.dart';
import 'package:task_app/feature/task/data/model/task_model.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_card_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.tasks,
  });
  final List<TaskModel> tasks;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 17),
            child: CustomCardItem(
              tasks: tasks[index],
            ),
          ),
        ),
      ),
    );
  }
}
