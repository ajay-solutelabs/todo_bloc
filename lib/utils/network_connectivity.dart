import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>();

  ConnectivityService () {
    connectivity.onConnectivityChanged.listen((event) {
      connectivityStream.add(event);
    });
  }
}