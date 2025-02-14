import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:taski/src/features/home_navigation/bloc/internet_listener_state.dart';

abstract class ConnectivityInfo {
  Stream<ConnectionStatus> onConnectivityChanged() async* {}
}

class ConnectivityInfoImpl implements ConnectivityInfo {
  final Connectivity _connectivity = Connectivity();

  @override
  Stream<ConnectionStatus> onConnectivityChanged() async* {
    await for (final result in _connectivity.onConnectivityChanged) {
      yield _verifyConnectivity(result);
    }
  }

  ConnectionStatus _verifyConnectivity(
    ConnectivityResult connectivityResult,
  ) {
    if (connectivityResult == ConnectivityResult.none) {
      return ConnectionStatus.disconnected;
    }
    return ConnectionStatus.connected;
  }
}
