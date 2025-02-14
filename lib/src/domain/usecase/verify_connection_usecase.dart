import 'package:taski/main.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/core/utils/connectivity_info.dart';
import 'package:taski/src/features/home_navigation/bloc/internet_listener_state.dart';

class VerifyConnectionUsecase
    implements UseCaseStream<ConnectionStatus, NoParams> {
  VerifyConnectionUsecase(ConnectivityInfo connectivityInfo)
      : _connectivityInfo = connectivityInfo;
  final ConnectivityInfo _connectivityInfo;

  @override
  Stream<ConnectionStatus> call(NoParams params) {
    if (kIsTestMode) return Stream.value(ConnectionStatus.connected);

    return _connectivityInfo
        .onConnectivityChanged()
        .map((ConnectionStatus event) => event);
  }
}
