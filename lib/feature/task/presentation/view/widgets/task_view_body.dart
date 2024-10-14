import 'package:flutter/material.dart';
import '../../../../../core/utils/widgets/build_button.dart';
import '../../../../../core/utils/widgets/custom_list_view.dart';

class TaskViewBody extends StatelessWidget {
  const TaskViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BuildButton(),
        CustomListView(),
        //const Spacer(),
        // SizedBox(
        //   width: double.infinity,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 18),
        //     child: CustomButtonItem(
        //       onPressed: () {},
        //       backgroundColor: kPrimaryColor,
        //       style: AppStyle.textStyle15.copyWith(color: kWhiteColor),
        //       title: 'Create Task',
        //       padding: 20,
        //       borderRadius: 10,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
