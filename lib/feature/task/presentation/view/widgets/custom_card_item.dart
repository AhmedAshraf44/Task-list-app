import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:task_app/core/utils/app_style.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_cubit.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_circle_avater_check.dart';
import '../../../../../constants.dart';

class CustomCardItem extends StatelessWidget {
  const CustomCardItem({
    super.key,
    required this.tasks,
  });
  final Map tasks;
  @override
  Widget build(BuildContext context) {
    var cubit = TaskCubit.get(context);
    return Dismissible(
      key: Key(tasks['id'].toString()),
      onDismissed: (direction) {
        cubit.deletfromDatabase(id: tasks['id']);
        log('delete : ${tasks['id']}');
      },
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 4,
        color: const Color(0xFFFDFDFD),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 18, right: 20, top: 10, bottom: 10),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              tasks['tittle'],
              style: AppStyle.textStyle15,
            ),
            subtitle: Text(
              'Due Date: ${tasks['date']}',
              style: AppStyle.textStyle12,
            ),
            trailing: CustomCircleAvaterCheck(
              onTap: () {
                cubit.updateData(
                    status: cubit.isStatus ? 'done' : 'not done',
                    id: tasks['id']);
                // log('status : ${tasks['status']}');
                // log('isStatus :${cubit.isStatus}');
                // log('id: ${tasks['id']}');
                cubit.changeStatus(cubit.isStatus);
              },
              backgroundColor: tasks['status'] == 'done'
                  ? const Color(0xff4ECB71).withOpacity(0.25)
                  : const Color(0xffF4FBF6),
              iconColor: tasks['status'] == 'done'
                  ? kPrimaryColor
                  : const Color(0xffDAF3E1),
            ),
          ),
        ),
      ),
    );
  }
}
