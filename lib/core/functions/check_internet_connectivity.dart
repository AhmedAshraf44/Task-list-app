// import 'package:connectivity_plus/connectivity_plus.dart';

// Future<bool> checkInternetConnectivity() async {
//   bool isConnectedInternet = false;

//   final List<ConnectivityResult> connectivityResult =
//       await (Connectivity().checkConnectivity());
//   if (connectivityResult.contains(ConnectivityResult.mobile)) {
//     print('mobile');
//     isConnectedInternet = true;
//   } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
//     print('wifi');
//     isConnectedInternet = true;
//   } else if (connectivityResult.contains(ConnectivityResult.none)) {
//     print('no internet');
//     isConnectedInternet = false;
//   } else {
//     print('no internet');
//     isConnectedInternet = false;
//   }
//   return isConnectedInternet;
// }
