import 'package:flutter/material.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_appbar_desktop.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_grid_view.dart';

class TaskAppDeskTopLayout extends StatelessWidget {
  const TaskAppDeskTopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 60),
      child: Column(
        children: [
          const CustomAppBarDesktop(),
          const SizedBox(
            height: 47,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.sizeOf(context).width < 1025 ? 0 : 211 - 60),
            child: const CustomGridView(),
          )),
        ],
      ),
    );
  }
}
//CustomConditionalBuilder()