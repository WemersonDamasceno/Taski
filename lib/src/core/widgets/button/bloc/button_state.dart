import 'package:equatable/equatable.dart';
import 'package:taski/src/core/enums/status_button_enum.dart';

class ButtonState extends Equatable {
  final StatusButtonEnum statusButton;

  const ButtonState({this.statusButton = StatusButtonEnum.disable});

  ButtonState copyWith({StatusButtonEnum? statusButton}) {
    return ButtonState(statusButton: statusButton ?? this.statusButton);
  }

  @override
  List<Object?> get props => [statusButton];
}
