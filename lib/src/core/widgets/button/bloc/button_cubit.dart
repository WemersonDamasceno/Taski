import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/widgets/button/bloc/button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(const ButtonState());

  void changeStatusButton(UIStatusButton statusButton) {
    emit(state.copyWith(statusButton: statusButton));
  }
}
