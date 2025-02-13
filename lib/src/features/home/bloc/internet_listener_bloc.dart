import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/usecase/verify_internet_usecase.dart';
import 'package:taski/src/features/home/bloc/internet_listener_event.dart';
import 'package:taski/src/features/home/bloc/internet_listener_state.dart';

class InternetListenerBloc extends Bloc<InternetEvent, InternetState> {
  InternetListenerBloc({required VerifyInternetUsecase usecase})
      : _verifyInternetUsecase = usecase,
        super(
          const InternetState(
            statusConnection: ConnectionStatus.disconnected,
          ),
        ) {
    on<VerifyInternetConnection>(_verifyInternetConnection);
  }

  final VerifyInternetUsecase _verifyInternetUsecase;

  FutureOr<void> _verifyInternetConnection(
    VerifyInternetConnection event,
    Emitter<InternetState> emit,
  ) async {
    await emit.forEach<ConnectionStatus>(
      _verifyInternetUsecase.call(NoParams()),
      onData: (connectionTypeStatus) {
        emit(state.copyWith(stateEnum: StateEnum.initial));
        return state.copyWith(
          stateEnum: StateEnum.success,
          statusConnection: connectionTypeStatus,
        );
      },
      onError: (_, __) => state.copyWith(
        stateEnum: StateEnum.error,
        statusConnection: ConnectionStatus.disconnected,
      ),
    );
  }
}
