part of 'connectivity_cubit.dart';

@immutable
abstract class ConnectivityState {}

enum ConnectionType {
  Wifi,
  Mobile,
}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityConnectedState extends ConnectivityState {
  final ConnectionType connectionType;

  ConnectivityConnectedState({required this.connectionType});
}

class ConnectivityDisconnected extends ConnectivityState {}

