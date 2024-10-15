import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:task_app/bloc_observer.dart';
import 'package:task_app/feature/task/presentation/view/task_view.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const TaskAPP(),
    ),
  );
}

class TaskAPP extends StatelessWidget {
  const TaskAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const TaskView(),
    );
  }
}
