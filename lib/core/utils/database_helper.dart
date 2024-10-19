import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:task_app/constants.dart';

import '../../feature/task/data/model/task_model.dart';

class DatabaseHelper {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool? isConnected;
  bool isConnectedInternet = false;

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

  Future<void> syncDataWithFirestore(
      {required List<TaskModel> allTasks}) async {
    checkInternetConnectivity();
    isConnected = isConnectedInternet;
    log('isConnectedInternet $isConnected');

    if (isConnected!) {
      bool ischeckFireStore = await getTaskToFirestore();
      List<TaskModel> localTasks = allTasks;
      if (ischeckFireStore) {
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
                'status': newStatus,
              });
            } else {
              await firestore
                  .collection(kTasksCollections)
                  .doc(documentId)
                  .update({
                'title': newTitle,
                'date': newDate,
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
}
