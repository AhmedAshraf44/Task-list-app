// import 'dart:developer';

// import 'package:sqflite/sqflite.dart';
// import 'package:task_app/feature/task/presentation/model/task_model.dart';

// class DatabaseHelper {
//   static late Database database;
//   static List<TaskModel> allTasks = [];
//   static List<TaskModel> notDoneTasks = [];
//   static List<TaskModel> doneTasks = [];
//   static createDatabase() {
//     // Create a new database
//     openDatabase(
//       'task.db',
//       version: 1,
//       // Create table in database
//       onCreate: (database, version) {
//         log("database created");
//         database
//             .execute(
//                 'CREATE TABLE tasks (id INTEGER PRIMARY KEY, tittle TEXT, date TEXT,status TEXT)')
//             .then(
//           (value) {
//             log("table created");
//           },
//         ).catchError(
//           (error) {
//             log("Error When Creating Table ${error.toString()}");
//           },
//         );
//       },
//       onOpen: (database) {
//         getFromDatabase(database);
//         log("opened database");
//       },
//     ).then(
//       (value) {
//         database = value;
//         // emit(CreateDatabaseState());
//       },
//     );
//   }

//   static insertToDatabase({
//     required String title,
//     required String date,
//   }) async {
//     // emit(InsertLoadingState());
//     await database.transaction(
//       (txn) async {
//         await txn
//             .rawInsert(
//                 'INSERT INTO tasks(tittle, date,status) VALUES("$title", "$date" ,"not done")')
//             .then((value) {
//           // emit(InsertDatabaseState());
//           log('$value insert succusfuly');
//           getFromDatabase(database);
//         }).catchError(
//           (error) {
//             log('error in insert to database $error');
//           },
//         );
//       },
//     );
//   }

//   static getFromDatabase(database) {
//     // emit(GetDatabaseLoadingState());
//     allTasks = [];
//     notDoneTasks = [];
//     doneTasks = [];
//     database.rawQuery('SELECT * FROM tasks').then(
//       (value) {
//         value.forEach(
//           (element) {
//             // log('element : $element');
//             TaskModel task = TaskModel.fromJson(element);
//             if (task.status == 'all' ||
//                 task.status == 'done' ||
//                 task.status == 'not done') {
//               allTasks.add(task);
//             }
//             if (task.status == 'done') {
//               doneTasks.add(task);
//             } else {
//               notDoneTasks.add(task);
//             }
//           },
//         );
//         // emit(GetDatabaseState());
//       },
//     );
//   }

//   static updateData({
//     required int id,
//     String? status,
//     String? title,
//     String? date,
//   }) {
//     if (status != null) {
//       database.rawUpdate(
//         'UPDATE tasks SET status = ? WHERE id = ?',
//         [status, id],
//       ).then((value) {
//         getFromDatabase(database);
//         // emit(UpdateDatabaseState());
//       });
//     } else if (title != null && date != null) {
//       database.rawUpdate(
//         'UPDATE tasks SET tittle = ?, date = ? WHERE id = ?',
//         [title, date, id],
//       ).then((value) {
//         getFromDatabase(database);
//         // emit(UpdateDatabaseState());
//       });
//     }
//   }

//   static deletfromDatabase({
//     required int id,
//   }) {
//     database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then(
//       (value) {
//         getFromDatabase(database);
//         // emit(DeleteDatabaseState());
//       },
//     );
//   }
// }
