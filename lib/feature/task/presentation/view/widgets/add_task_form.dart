import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_app/constants.dart';
import 'package:task_app/core/utils/app_style.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_cubit.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_state.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_text_field.dart';

import 'custom_button_item.dart';

class AddTaskForm extends StatelessWidget {
  const AddTaskForm({super.key});
  static var formKey = GlobalKey<FormState>();
  static TextEditingController tittleController = TextEditingController();
  static TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Color(0xffF24E1E),
              ),
            ),
          ),
          const Text(
            'Create New Task',
            style: AppStyle.textStyle15,
          ),
          const SizedBox(
            height: 14,
          ),
          CustomTextField(
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Title is Required';
              } else {
                return null;
              }
            },
            hint: 'Task title',
            controller: tittleController,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Date is Required';
              } else {
                return null;
              }
            },
            onTap: () async {
              await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025))
                  .then(
                (value) {
                  dateController.text = DateFormat.yMMMEd().format(value!);
                },
              );
            },
            controller: dateController,
            keyboardType: TextInputType.datetime,
            hint: 'Due Date',
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: BlocConsumer<TaskCubit, TaskState>(
              listener: (context, state) {
                if (state is InsertDatabaseState) {
                  Navigator.of(context).pop();
                  dateController.clear();
                  tittleController.clear();
                }
              },
              builder: (context, state) {
                var cubit = TaskCubit.get(context);
                return CustomButtonItem(
                  isLoading: state is InsertLoadingState,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      cubit.insertTaskToDatabase(
                        title: tittleController.text,
                        date: dateController.text,
                      );
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
          // const SizedBox(
          //   height: 20,
          // ),
        ],
      ),
    );
  }
}
