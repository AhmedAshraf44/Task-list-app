// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:task_app/constants.dart';
// import 'package:task_app/core/functions/check_internet_connectivity.dart';
// import 'package:task_app/feature/task/presentation/model/task_model.dart';

// class FireBaseService {
//   // add tasks in firestore
//   //---adding to first once;

//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   bool? isConnected;

//   Future<void> syncDataWithFirestore(
//       {required List<TaskModel> allTasks}) async {
//     isConnected = await checkInternetConnectivity();
//     log('isConnectedInternet $isConnected');
//     if (isConnected!) {
//       bool ischeckFireStore = await getTaskToFirestore();
//       if (ischeckFireStore) {
//         List<TaskModel> localTasks = allTasks;
//         localTasks.forEach((task) {
//           addTaskToFirestore(task);
//           log('$task');
//         });
//       }
//     }
//   }

// //get Data To Firestore
//   Future<bool> getTaskToFirestore() async {
//     final snapshot = await firestore.collection(kTasksCollections).get();
//     if (snapshot.size == 0) {
//       log('snapshot.size : ${snapshot.size}');
//       log('true :');
//       return true;
//     } else {
//       log('snapshot.size : ${snapshot.size}');
//       log('false :');
//       return false;
//     }
//   }

// //add Tak TO Firestore
//   Future<void> addTaskToFirestore(TaskModel task) async {
//     checkInternetConnectivity();
//     try {
//       isConnected = await checkInternetConnectivity();
//       log('isConnectedInternet $isConnected');
//       if (isConnected!) {
//         await firestore.collection(kTasksCollections).add({
//           'title': task.title,
//           'date': task.date,
//           'status': task.status,
//           'id': task.id,
//         });
//         log('Task added to Firestore successfully');
//       }
//     } catch (e) {
//       log('Error adding task to Firestore: $e');
//     }
//   }

// //delete Task from Firestore
//   Future<void> deleteTaskFromFirestore(int taskId) async {
//     checkInternetConnectivity();
//     try {
//       isConnected = await checkInternetConnectivity();
//       log('isConnectedInternet $isConnected');
//       if (isConnected!) {
//         QuerySnapshot querySnapshot = await firestore
//             .collection(kTasksCollections)
//             .where('id', isEqualTo: taskId)
//             .get();

//         if (querySnapshot.docs.isNotEmpty) {
//           String documentId = querySnapshot.docs.first.id;
//           log(documentId);
//           DocumentReference documentReference =
//               firestore.collection(kTasksCollections).doc(documentId);
//           await documentReference.delete();
//           log('Task deleted from Firestore successfully');
//         }
//       }
//     } catch (e) {
//       print('Error deleting task from Firestore: $e');
//     }
//   }

// //upate Task to Firestore
//   Future<void> updateTaskToFirestore(
//       {required int taskId,
//       String? newTitle,
//       String? newDate,
//       String? newStatus}) async {
//     checkInternetConnectivity();

//     try {
//       isConnected = await checkInternetConnectivity();
//       log('isConnectedInternet $isConnected');

//       if (isConnected!) {
//         QuerySnapshot querySnapshot = await firestore
//             .collection(kTasksCollections)
//             .where('id', isEqualTo: taskId)
//             .get();
//         log('$querySnapshot');
//         log('${querySnapshot.docs}');
//         log('-----------${querySnapshot.docs.first}');
//         if (querySnapshot.docs.isNotEmpty) {
//           for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//             String documentId = doc.id;
//             log(documentId);
//             if (newDate == null) {
//               await firestore
//                   .collection(kTasksCollections)
//                   .doc(documentId)
//                   .update({
//                 'status': newStatus, // The new value you want to set
//               });
//             } else {
//               await firestore
//                   .collection(kTasksCollections)
//                   .doc(documentId)
//                   .update({
//                 'title': newTitle,
//                 'date': newDate, // The new value you want to set
//               });
//             }
//             log('Value updated in Firestore successfully');
//           }
//         } else {
//           print('No document matching the condition found');
//         }
//       }
//     } catch (e) {
//       print('Error updating data in Firestore: $e');
//     }
//   }
// }
