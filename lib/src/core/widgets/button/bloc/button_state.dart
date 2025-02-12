import 'package:equatable/equatable.dart';
import 'package:nova_design_system/nova_design_system.dart';

class ButtonState extends Equatable {
  const ButtonState({this.statusButton = UIStatusButton.disable});
  final UIStatusButton statusButton;

  ButtonState copyWith({UIStatusButton? statusButton}) {
    return ButtonState(statusButton: statusButton ?? this.statusButton);
  }

  @override
  List<Object?> get props => [statusButton];
}
