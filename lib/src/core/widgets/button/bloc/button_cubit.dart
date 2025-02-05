import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/src/core/enums/status_button_enum.dart';
import 'package:taski/src/core/widgets/button/bloc/button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(const ButtonState());

  void changeStatusButton(StatusButtonEnum statusButton) {
    emit(state.copyWith(statusButton: statusButton));
  }
}
