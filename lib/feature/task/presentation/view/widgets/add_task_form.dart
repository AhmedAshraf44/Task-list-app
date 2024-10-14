import 'package:flutter/material.dart';
import 'package:task_app/core/utils/app_style.dart';

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
        children: [
          const SizedBox(
            height: 32,
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
            height: 32,
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
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.onSaved,
    this.onChanged,
    this.initialValue,
  });
  final String? hint;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Feiled is Required';
        } else {
          return null;
        }
      },
      onSaved: onSaved,
      onChanged: onChanged,
      //  cursorColor: kPrimaryColor,
      initialValue: initialValue,
      decoration: InputDecoration(
        border: buildBorder(),
        enabledBorder: buildBorder(),
        //  focusedBorder: buildBorder(kPrimaryColor),
        hintText: hint,
        hintStyle: AppStyle.textStyle12
            .copyWith(color: const Color(0xff000000).withOpacity(.5)),
      ),
    );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide:
          BorderSide(color: color ?? const Color(0xffD9D9D9).withOpacity(.2)),
    );
  }
}
