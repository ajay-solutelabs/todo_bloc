import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity connectivity;
  StreamSubscription? connectivitySubscription;

  ConnectivityCubit({required this.connectivity}) : super(ConnectivityInitial()) {
    connectivitySubscription = connectivity.onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.wifi){
        emit(ConnectivityConnectedState(connectionType: ConnectionType.Wifi));
      } else if(event == ConnectivityResult.mobile) {
        emit(ConnectivityConnectedState(connectionType: ConnectionType.Mobile));
      } else {
        emit(ConnectivityDisconnected());
      }
    });
  }
  
  void emitInternetConnectedState(ConnectionType connectionType) {
    emit(ConnectivityConnectedState(connectionType: connectionType),);
  }

  @override
  Future<void> close() {
    // TODO: implement close
    connectivitySubscription?.cancel();
    return super.close();
  }
}
