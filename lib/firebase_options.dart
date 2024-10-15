// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA3a-wXvGPFZClWFiy0-Daw-E6eZpnS_MU',
    appId: '1:505032818538:web:8fc76d38869f8a893f2f13',
    messagingSenderId: '505032818538',
    projectId: 'task-list-app-1bd8f',
    authDomain: 'task-list-app-1bd8f.firebaseapp.com',
    storageBucket: 'task-list-app-1bd8f.appspot.com',
    measurementId: 'G-5W0LFMYP09',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD31v024h4yzYawQ_8Jh1mWSQA8k235X8k',
    appId: '1:505032818538:android:c6b587d5ad20a3fb3f2f13',
    messagingSenderId: '505032818538',
    projectId: 'task-list-app-1bd8f',
    storageBucket: 'task-list-app-1bd8f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUBUbW8UC3PKqpIFnYEwSq8JYksOkRZXA',
    appId: '1:505032818538:ios:a438079925df7af03f2f13',
    messagingSenderId: '505032818538',
    projectId: 'task-list-app-1bd8f',
    storageBucket: 'task-list-app-1bd8f.appspot.com',
    iosBundleId: 'com.example.taskApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUBUbW8UC3PKqpIFnYEwSq8JYksOkRZXA',
    appId: '1:505032818538:ios:a438079925df7af03f2f13',
    messagingSenderId: '505032818538',
    projectId: 'task-list-app-1bd8f',
    storageBucket: 'task-list-app-1bd8f.appspot.com',
    iosBundleId: 'com.example.taskApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA3a-wXvGPFZClWFiy0-Daw-E6eZpnS_MU',
    appId: '1:505032818538:web:33205b93ce3502dc3f2f13',
    messagingSenderId: '505032818538',
    projectId: 'task-list-app-1bd8f',
    authDomain: 'task-list-app-1bd8f.firebaseapp.com',
    storageBucket: 'task-list-app-1bd8f.appspot.com',
    measurementId: 'G-VXTF09HD62',
  );
}