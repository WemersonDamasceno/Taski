import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:taski/src/features/home/bloc/internet_listener_state.dart';

class ConnectivityInfo {
  final connectionChecker = InternetConnectionChecker.instance;

  Stream<ConnectionStatus> onConnectivityChanged() async* {
    await for (final result in connectionChecker.onStatusChange) {
      yield _verifyConnectivity(result);
    }
  }

  ConnectionStatus _verifyConnectivity(
    InternetConnectionStatus status,
  ) {
    if (status == InternetConnectionStatus.disconnected) {
      return ConnectionStatus.disconnected;
    }
    return ConnectionStatus.connected;
  }
}
