import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task_app/bloc_observer.dart';
import 'package:task_app/feature/task/presentation/view/task_view.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const TaskAPP());
}

class TaskAPP extends StatelessWidget {
  const TaskAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskView(),
    );
  }
}
