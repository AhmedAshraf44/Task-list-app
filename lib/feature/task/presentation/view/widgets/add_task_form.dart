import 'package:flutter/material.dart';
import 'package:task_app/constants.dart';
import 'package:task_app/core/utils/app_style.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_text_field.dart';

import 'custom_button_item.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  String? title, date;
  @override
  Widget build(BuildContext context) {
    return Form(
      //autovalidateMode: autovalidateMode,
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
            hint: 'Task title',
            onSaved: (value) {
              title = value;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
            hint: 'Due Date',
            onSaved: (value) {
              date = value;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          // BlocBuilder<AddNotesCubit, AddNotesStates>(
          //   builder: (context, state) => CustomButton(
          //     isLoading: state is AddNotesLoadingState ? true : false,
          //  onTap: () {
          // if (formKey.currentState!.validate()) {
          //   formKey.currentState!.save();
          //   var currentDate = DateTime.now();
          //   var formetCurrentDate =
          //       DateFormat('dd-MM-yyyy').format(currentDate);
          //   var notes = NotesModel(
          //       title: title!,
          //       subTitle: subTitle!,
          //       date: formetCurrentDate,
          //       color: Colors.blue.value);
          //   BlocProvider.of<AddNotesCubit>(context).getNotes(notes);
          // } else {
          //   autovalidateMode = AutovalidateMode.always;
          //   setState(() {});
          // }
          //  },
          SizedBox(
            width: double.infinity,
            child: CustomButtonItem(
              onPressed: () {},
              backgroundColor: kPrimaryColor,
              style: AppStyle.textStyle15.copyWith(color: kWhiteColor),
              title: 'Save Task',
              padding: 20,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
