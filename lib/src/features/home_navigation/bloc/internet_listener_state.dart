import 'package:equatable/equatable.dart';
import 'package:taski/src/core/enums/state_enum.dart';

enum ConnectionStatus { connected, disconnected }

class InternetState extends Equatable {
  const InternetState({
    required this.statusConnection,
    this.stateEnum = StateEnum.initial,
  });

  final ConnectionStatus statusConnection;
  final StateEnum stateEnum;

  InternetState copyWith({
    ConnectionStatus? statusConnection,
    StateEnum? stateEnum,
  }) {
    return InternetState(
      statusConnection: statusConnection ?? this.statusConnection,
      stateEnum: stateEnum ?? this.stateEnum,
    );
  }

  @override
  List<Object> get props => [statusConnection, stateEnum];
}
