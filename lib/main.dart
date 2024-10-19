import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_app/bloc_observer.dart';
import 'package:task_app/core/utils/database_helper.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_cubit.dart';
import 'package:task_app/feature/task/presentation/view/task_view.dart';
import 'package:task_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // if (kIsWeb) {
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;
  // }
  Bloc.observer = MyBlocObserver();
  runApp(
    const TaskApp(),
  );
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TaskCubit(DatabaseHelper()..checkInternetConnectivity())
            ..createDatabase(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskView(),
      ),
    );
  }
}
