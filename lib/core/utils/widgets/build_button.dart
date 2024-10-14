import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/utils/app_style.dart';
import 'package:task_app/core/utils/widgets/custom_button_item.dart';

import '../../../constants.dart';
import '../../../feature/task/presentation/manger/change_button_cubit/change_button_cubit.dart';
import '../../../feature/task/presentation/manger/change_button_cubit/change_button_state.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeButtonCubit, ChangeButtonState>(
      builder: (context, state) {
        var cubit = ChangeButtonCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
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
