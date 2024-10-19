import 'package:flutter/material.dart';
import 'package:task_app/constants.dart';
import 'package:task_app/core/utils/app_style.dart';
import 'package:task_app/feature/task/presentation/view/widgets/add_task_botton_sheet.dart';
import 'package:task_app/feature/task/presentation/view/widgets/build_button.dart';

class CustomAppBarDesktop extends StatelessWidget {
  const CustomAppBarDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning',
              style: AppStyle.textStyle30.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            const BuildButton(
              paddinghorizontal: 0,
            ),
          ],
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              isDismissible: false,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Center(
                  child: AspectRatio(
                    aspectRatio: 1 / 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        color: kWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 6,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: const AddTaskBottomSheet(),
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kPrimaryColor,
            ),
            child: const Icon(
              Icons.add,
              color: kWhiteColor,
              size: 50,
            ),
          ),
        ),
      ],
    );
  }
}
