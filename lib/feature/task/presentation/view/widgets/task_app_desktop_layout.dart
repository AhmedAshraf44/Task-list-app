import 'package:flutter/material.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_appbar_desktop.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_grid_view.dart';

class TaskAppDeskTopLayout extends StatelessWidget {
  const TaskAppDeskTopLayout({super.key, required this.tasks});
  final List<Map<dynamic, dynamic>> tasks;
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
            child: CustomGridView(
              tasks: tasks,
            ),
          )),
        ],
      ),
    );
  }
}
// class CustomConditionalBuilder extends StatelessWidget {
//   const CustomConditionalBuilder({
//     super.key,
//     required this.tasks,
//   });

//   final List<Map<dynamic, dynamic>> tasks;
//   @override
//   Widget build(BuildContext context) {
//     return ConditionalBuilder(
//       condition: tasks.isNotEmpty,
//       builder: (context) => CustomGridView(
//         tasks: tasks,
//       ),
//       fallback: (context) => const BuildTaskEmpty(),
//     );
//   }
// }
