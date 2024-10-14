import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/utils/app_style.dart';
import 'package:task_app/feature/task/presentation/manger/change_button_cubit/change_button_cubit.dart';
import 'package:task_app/feature/task/presentation/view/widgets/add_task_botton_sheet.dart';
import 'package:task_app/feature/task/presentation/view/widgets/task_view_body.dart';
import '../../../../constants.dart';
import 'widgets/custom_button_item.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeButtonCubit(),
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Good Morning',
              style: AppStyle.textStyle30,
            ),
          ),
        ),
        bottomSheet: Container(
          color: kWhiteColor,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
        ),
        body: const TaskViewBody(),
      ),
    );
  }
}

showBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    isDismissible: false,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    // elevation: 1,
    // shape: BeveledRectangleBorder(
    //   borderRadius: BorderRadius.circular(10),
    // ),
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
