import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_app/constants.dart';
import 'package:task_app/core/utils/app_style.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_cubit.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_state.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_button_item.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_text_field.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key, required this.title, required this.date});
  static var formKey = GlobalKey<FormState>();
  static TextEditingController tittleController = TextEditingController();
  static TextEditingController dateController = TextEditingController();
  final String title, date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
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
                // controller: tittleController,
                onSaved: (value) {},
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
                onTap: () {
                  showDatePicker(
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
                // controller: dateController,
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
                        // if (formKey.currentState!.validate()) {
                        //   formKey.currentState!.save();
                        //   cubit.insertToDatabase(
                        //     title: tittleController.text,
                        //     date: dateController.text,
                        //   );
                        // }
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
      ),
    );
  }
}
