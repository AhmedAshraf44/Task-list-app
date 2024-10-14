import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/utils/app_style.dart';
import 'package:task_app/feature/task/presentation/manger/change_button_cubit/change_button_cubit.dart';
import 'package:task_app/feature/task/presentation/view/widgets/add_task_botton_sheet.dart';
import 'package:task_app/feature/task/presentation/view/widgets/task_view_body.dart';

import '../../../../constants.dart';
import '../../../../core/utils/widgets/custom_button_item.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeButtonCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Good Morning',
              style: AppStyle.textStyle30,
            ),
          ),
        ),
        bottomSheet: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: CustomButtonItem(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddTaskBottomSheet(),
                  ),
                );
              },
              backgroundColor: kPrimaryColor,
              style: AppStyle.textStyle15.copyWith(color: kWhiteColor),
              title: 'Create Task',
              padding: 20,
              borderRadius: 10,
            ),
          ),
        ),
        body: const TaskViewBody(),
      ),
    );
  }
}
