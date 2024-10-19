import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_cubit.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_state.dart';
import 'package:task_app/feature/task/data/model/task_model.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_card_item.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.tasks,
  });
  final List<TaskModel> tasks;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.sizeOf(context).width < 1025 ? 2 : 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
              childAspectRatio: 4.7),
          physics: const BouncingScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) => CustomCardItem(
            tasks: tasks[index],
          ),
        );
      },
    );
  }
}
