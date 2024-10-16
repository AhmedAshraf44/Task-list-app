import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/utils/app_style.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_button_item.dart';

import '../../../../../constants.dart';
import '../../manger/task_cubit/task_cubit.dart';
import '../../manger/task_cubit/task_state.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({super.key, this.paddinghorizontal = 22});
  final double paddinghorizontal;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddinghorizontal,
          ),
          child: Row(
            children: [
              CustomButtonItem(
                onPressed: () {
                  cubit.changeButtonColor(0);
                },
                title: 'All',
                backgroundColor:
                    cubit.isActive == 0 ? kPrimaryColor : kSecondaryColor,
                style: cubit.isActive == 0
                    ? AppStyle.textStyle13
                    : AppStyle.textStyle12.copyWith(color: kPrimaryColor),
              ),
              const SizedBox(
                width: 3,
              ),
              CustomButtonItem(
                onPressed: () {
                  cubit.changeButtonColor(1);
                },
                title: 'Not Done',
                backgroundColor:
                    cubit.isActive == 1 ? kPrimaryColor : kSecondaryColor,
                style: cubit.isActive == 1
                    ? AppStyle.textStyle13
                    : AppStyle.textStyle12.copyWith(color: kPrimaryColor),
              ),
              const SizedBox(
                width: 3,
              ),
              CustomButtonItem(
                onPressed: () {
                  cubit.changeButtonColor(2);
                },
                title: 'Done',
                backgroundColor:
                    cubit.isActive == 2 ? kPrimaryColor : kSecondaryColor,
                style: cubit.isActive == 2
                    ? AppStyle.textStyle13
                    : AppStyle.textStyle12.copyWith(color: kPrimaryColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
