import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/core/utils/connectivity_info.dart';
import 'package:taski/src/features/home/bloc/internet_listener_state.dart';

class VerifyInternetUsecase
    implements UseCaseStream<ConnectionStatus, NoParams> {
  VerifyInternetUsecase(ConnectivityInfo connectivityInfo)
      : _connectivityInfo = connectivityInfo;
  final ConnectivityInfo _connectivityInfo;

  @override
  Stream<ConnectionStatus> call(NoParams params) {
    return _connectivityInfo.onConnectivityChanged().map((event) => event);
  }
}
