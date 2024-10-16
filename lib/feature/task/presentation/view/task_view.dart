import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/utils/app_style.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_cubit.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_state.dart';
import 'package:task_app/feature/task/presentation/view/widgets/adaptive_layout_widget.dart';
import 'package:task_app/feature/task/presentation/view/widgets/add_task_botton_sheet.dart';
import 'package:task_app/feature/task/presentation/view/widgets/task_app_desktop_layout.dart';
import 'package:task_app/feature/task/presentation/view/widgets/task_app_mobile_layout.dart';
import '../../../../constants.dart';
import 'widgets/custom_button_item.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: MediaQuery.sizeOf(context).width < 800
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Good Morning',
                  style: AppStyle.textStyle30,
                ),
              ),
            )
          : null,
      bottomSheet: MediaQuery.sizeOf(context).width < 800
          ? Container(
              color: kWhiteColor,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: CustomButtonItem(
                  onPressed: () {
                    showBottomSheet(context);
                  },
                  backgroundColor: kPrimaryColor,
                  style: AppStyle.textStyle15.copyWith(color: kWhiteColor),
                  title: 'Create Task',
                  padding: 20,
                  borderRadius: 10,
                ),
              ),
            )
          : null,
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          var cubit = TaskCubit.get(context);
          var tasks = cubit.allTasks;
          if (cubit.isActive == 0) {
            tasks = cubit.allTasks;
            print(tasks);
          } else if (cubit.isActive == 1) {
            tasks = cubit.notDoneTasks;
          } else {
            tasks = cubit.doneTasks;
          }
          return AdaptiveLayoutWidget(
            mobileLayout: (context) => TaskAppMobileLayout(
              tasks: tasks,
            ),
            desktopLayout: (context) => TaskAppDeskTopLayout(
              tasks: tasks,
            ),
          );
        },
      ),
    );
  }
}

showBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    isDismissible: false,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        width: MediaQuery.sizeOf(context).width * 1 - 20,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          color: kWhiteColor,
          boxShadow: [
            // Add elevation as a boxShadow
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(
                  0, 1), // Adjust the offset to control the elevation
            ),
          ],
        ),
        child: const AddTaskBottomSheet(),
      );
    },
  );
}
