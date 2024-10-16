import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_cubit.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_state.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_card_item.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        var cubic = TaskCubit.get(context);
        var tasks = cubic.allTasks;
        if (cubic.isActive == 0) {
          tasks = cubic.allTasks;
        } else if (cubic.isActive == 1) {
          tasks = cubic.notDoneTasks;
        } else {
          tasks = cubic.doneTasks;
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.sizeOf(context).width < 1025 ? 2 : 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
              childAspectRatio: 4.7),
          physics: const BouncingScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) => CustomCardItem(
            tasks: tasks[index],
          ),
        );
      },
    );
  }
}
