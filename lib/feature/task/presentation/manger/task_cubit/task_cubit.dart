import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_state.dart';
import 'package:task_app/feature/task/data/model/task_model.dart';

import '../../../../../core/utils/database_helper.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this.databaseHelper) : super(InitialState());
  final DatabaseHelper databaseHelper;
  static TaskCubit get(context) => BlocProvider.of(context);

  int isActive = 0;
  bool isStatus = true;
  late Database database;
  List<TaskModel> allTasks = [];
  List<TaskModel> notDoneTasks = [];
  List<TaskModel> doneTasks = [];

  changeButtonColor(int index) {
    isActive = index;
    emit(ChangeButton());
  }

  changeStatus(bool status) {
    isStatus = !status;
    emit(ChangeStatus());
  }

//create and open DB localHost Using (SQLite)
  void createDatabase() {
    openDatabase(
      'task.db',
      version: 1,
      onCreate: (database, version) {
        log("database created");
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, tittle TEXT, date TEXT,status TEXT)')
            .then(
          (value) {
            log("table created");
          },
        ).catchError(
          (error) {
            log("Error When Creating Table ${error.toString()}");
          },
        );
      },
      onOpen: (database) async {
        getTaskFromDatabase(database);
        log("opened database");
      },
    ).then(
      (value) async {
        database = value;
        emit(CreateDatabaseState());
      },
    );
  }

//insert to DB localHost (SQLite)
  insertTaskToDatabase({
    required String title,
    required String date,
  }) async {
    emit(InsertLoadingState());
    await database.transaction((txn) async {
      int insertedId = await txn.rawInsert(
          'INSERT INTO tasks(tittle, date,status) VALUES("$title", "$date" ,"not done")');
      // .then((value) {
      emit(InsertDatabaseState());
      log('insert succusfuly');
      getTaskFromDatabase(database);
      List<Map<String, dynamic>> result =
          await txn.rawQuery('SELECT * FROM tasks WHERE id = $insertedId');
      TaskModel insertedTask = TaskModel.fromJson(result.first);
      databaseHelper.addTaskToFirestore(insertedTask);
    }).catchError(
      (error) {
        log('error in insert to database $error');
      },
    );
    //  },
    // );
  }

//get from DB localHost (SQLite)
  void getTaskFromDatabase(database) async {
    emit(GetDatabaseLoadingState());
    allTasks = [];
    notDoneTasks = [];
    doneTasks = [];
    database.rawQuery('SELECT * FROM tasks').then(
      (value) async {
        value.forEach(
          (element) {
            log('element : $element');
            TaskModel task = TaskModel.fromJson(element);
            if (task.status == 'all' ||
                task.status == 'done' ||
                task.status == 'not done') {
              allTasks.add(task);
            }
            if (task.status == 'done') {
              doneTasks.add(task);
            } else {
              notDoneTasks.add(task);
            }
          },
        );
        await databaseHelper.syncDataWithFirestore(allTasks: allTasks);
        emit(GetDatabaseState());
      },
    );
  }

//delete from DB localHost (SQLite)
  void deletTaskfromDatabase({
    required int id,
  }) async {
    await database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
    getTaskFromDatabase(database);
    await databaseHelper.deleteTaskFromFirestore(id);
    emit(DeleteDatabaseState());
  }

//update DB localHost (SQLite)
  void updateTaskToDatabase({
    required int id,
    String? status,
    String? title,
    String? date,
  }) {
    if (status != null) {
      database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id],
      ).then((value) {
        getTaskFromDatabase(database);
        databaseHelper.updateTaskToFirestore(taskId: id, newStatus: status);
        //synchronizeData();
        emit(UpdateDatabaseState());
      });
    } else if (title != null || date != null) {
      database.rawUpdate(
        'UPDATE tasks SET tittle = ?, date = ? WHERE id = ?',
        [title, date, id],
      ).then((value) {
        getTaskFromDatabase(database);
        databaseHelper.updateTaskToFirestore(
            taskId: id, newTitle: title, newDate: date);
        emit(UpdateDatabaseState());
      });
    }
  }
}
