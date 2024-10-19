import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_app/constants.dart';
import 'package:task_app/core/utils/app_style.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_cubit.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_state.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_button_item.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditTaskViewBody extends StatelessWidget {
  const EditTaskViewBody(
      {super.key, required this.title, required this.date, required this.id});
  static var formKey = GlobalKey<FormState>();
  final String title, date;
  static String? editTitle;
  static String? editdate;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Task',
              style: AppStyle.textStyle15,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              initialValue: title,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Title is Required';
                } else {
                  return null;
                }
              },
              hint: 'Task title',
              onSaved: (value) {
                editTitle = value;
              },
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              initialValue: date,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Date is Required';
                } else {
                  return null;
                }
              },
              onFieldSubmitted: (value) {
                log(value);
                editdate = value;
              },
              onTap: () async {
                await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025))
                    .then(
                  (value) {
                    editdate = DateFormat.yMMMEd().format(value!);
                    log('$editdate');
                  },
                );
                // if (selectedDate != null) {
                //   editdate = selectedDate;
                // } else {
                //   editdate = date;
                // }
              },
              keyboardType: TextInputType.datetime,
              hint: 'Due Date',
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  var cubit = TaskCubit.get(context);
                  return CustomButtonItem(
                    isLoading: state is InsertLoadingState,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        cubit.updateTaskToDatabase(
                          title: editTitle ?? title,
                          date: editdate ?? date,
                          id: id,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    backgroundColor: kPrimaryColor,
                    style: AppStyle.textStyle15.copyWith(color: kWhiteColor),
                    title: 'Save Task',
                    padding: 20,
                    borderRadius: 10,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
