import 'package:equatable/equatable.dart';
import 'package:taski/src/core/enums/status_button_enum.dart';

class ButtonState extends Equatable {
  const ButtonState({this.statusButton = StatusButtonEnum.disable});
  final StatusButtonEnum statusButton;

  ButtonState copyWith({StatusButtonEnum? statusButton}) {
    return ButtonState(statusButton: statusButton ?? this.statusButton);
  }

  @override
  List<Object?> get props => [statusButton];
}
