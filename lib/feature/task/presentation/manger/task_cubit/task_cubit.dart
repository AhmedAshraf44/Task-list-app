import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_app/constants.dart';
import 'package:task_app/feature/task/presentation/manger/task_cubit/task_state.dart';
import 'package:task_app/feature/task/presentation/model/task_model.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(InitialState());

  static TaskCubit get(context) => BlocProvider.of(context);

  int isActive = 0;
  bool isStatus = true;
  late Database database;
  List<TaskModel> allTasks = [];
  List<TaskModel> notDoneTasks = [];
  List<TaskModel> doneTasks = [];
  bool isConnectedInternet = false;

  changeButtonColor(int index) {
    isActive = index;
    emit(ChangeButton());
  }

  changeStatus(bool status) {
    isStatus = !status;
    emit(ChangeStatus());
  }

  void checkInternetConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      print('mobile');
      isConnectedInternet = true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      print('wifi');
      isConnectedInternet = true;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      print('no internet');
      isConnectedInternet = false;
    } else {
      print('no internet');
      isConnectedInternet = false;
    }
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
      addTaskToFirestore(insertedTask);
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
        await syncDataWithFirestore();
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
    await deleteTaskFromFirestore(id);
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
        updateTaskToFirestore(taskId: id, newStatus: status);
        //synchronizeData();
        emit(UpdateDatabaseState());
      });
    } else if (title != null || date != null) {
      database.rawUpdate(
        'UPDATE tasks SET tittle = ?, date = ? WHERE id = ?',
        [title, date, id],
      ).then((value) {
        getTaskFromDatabase(database);
        updateTaskToFirestore(taskId: id, newTitle: title, newDate: date);
        emit(UpdateDatabaseState());
      });
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool? isConnected;

  Future<void> syncDataWithFirestore(
      // {required List<TaskModel> allTasks}
      ) async {
    checkInternetConnectivity();
    isConnected = isConnectedInternet;
    log('isConnectedInternet $isConnected');

    if (isConnected!) {
      bool ischeckFireStore = await getTaskToFirestore();
      List<TaskModel> localTasks = allTasks;
      if (ischeckFireStore) {
        // localTasks = allTasks;
        localTasks.forEach((task) {
          addTaskToFirestore(task);
          log('$task');
        });
      } else {
        List<TaskModel> firestoreData = [];
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(kTasksCollections)
            .get();

        firestoreData = querySnapshot.docs.map((doc) {
          return TaskModel(
            id: doc['id'],
            title: doc['title'],
            date: doc['date'],
            status: doc['status'],
          );
        }).toList();
        for (TaskModel localTask in localTasks) {
          bool found = false;

          for (TaskModel firestoreTask in firestoreData) {
            if (localTask.id == firestoreTask.id) {
              found = true;
              break;
            }
          }

          if (!found) {
            await addTaskToFirestore(localTask);
          }
        }
        if (firestoreData.length > localTasks.length) {
          for (TaskModel firestoreTask in firestoreData) {
            bool existsLocally =
                localTasks.any((localData) => localData.id == firestoreTask.id);
            if (!existsLocally) {
              await deleteTaskFromFirestore(firestoreTask.id!);
            }
          }
        }
        print('Data synchronization complete.');
      }
    }
  }

//get Data To Firestore
  Future<bool> getTaskToFirestore() async {
    final snapshot = await firestore.collection(kTasksCollections).get();
    if (snapshot.size == 0) {
      log('snapshot.size : ${snapshot.size}');
      log('true :');
      return true;
    } else {
      log('snapshot.size : ${snapshot.size}');
      log('false :');
      return false;
    }
  }

//add Tak TO Firestore
  Future<void> addTaskToFirestore(TaskModel task) async {
    checkInternetConnectivity();
    try {
      isConnected = isConnectedInternet;
      log('isConnectedInternet $isConnected');
      if (isConnected!) {
        await firestore.collection(kTasksCollections).add({
          'title': task.title,
          'date': task.date,
          'status': task.status,
          'id': task.id,
        });
        log('Task added to Firestore successfully');
      }
    } catch (e) {
      log('Error adding task to Firestore: $e');
    }
  }

//delete Task from Firestore
  Future<void> deleteTaskFromFirestore(int taskId) async {
    checkInternetConnectivity();
    try {
      isConnected = isConnectedInternet;
      log('isConnectedInternet $isConnected');
      if (isConnected!) {
        QuerySnapshot querySnapshot = await firestore
            .collection(kTasksCollections)
            .where('id', isEqualTo: taskId)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          String documentId = querySnapshot.docs.first.id;
          log(documentId);
          DocumentReference documentReference =
              firestore.collection(kTasksCollections).doc(documentId);
          await documentReference.delete();
          log('Task deleted from Firestore successfully');
        }
      }
    } catch (e) {
      print('Error deleting task from Firestore: $e');
    }
  }

//upate Task to Firestore
  Future<void> updateTaskToFirestore(
      {required int taskId,
      String? newTitle,
      String? newDate,
      String? newStatus}) async {
    checkInternetConnectivity();

    try {
      isConnected = isConnectedInternet;
      log('isConnectedInternet $isConnected');

      if (isConnected!) {
        QuerySnapshot querySnapshot = await firestore
            .collection(kTasksCollections)
            .where('id', isEqualTo: taskId)
            .get();
        log('$querySnapshot');
        log('${querySnapshot.docs}');
        log('-----------${querySnapshot.docs.first}');
        if (querySnapshot.docs.isNotEmpty) {
          for (QueryDocumentSnapshot doc in querySnapshot.docs) {
            String documentId = doc.id;
            log(documentId);
            if (newDate == null) {
              await firestore
                  .collection(kTasksCollections)
                  .doc(documentId)
                  .update({
                'status': newStatus, // The new value you want to set
              });
            } else {
              await firestore
                  .collection(kTasksCollections)
                  .doc(documentId)
                  .update({
                'title': newTitle,
                'date': newDate, // The new value you want to set
              });
            }
            log('Value updated in Firestore successfully');
          }
        } else {
          print('No document matching the condition found');
        }
      }
    } catch (e) {
      print('Error updating data in Firestore: $e');
    }
  }

//   Future<void> synchronizeData() async {
//     // Step 1: Retrieve data from local database

// }
}
