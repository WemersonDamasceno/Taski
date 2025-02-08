import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/src/features/done_tasks/bloc/enable_buton/enable_button_state.dart';

class EnableDeleteButtonCubit extends Cubit<EnableButtonState> {
  EnableDeleteButtonCubit() : super(const EnableButtonState());

  void changeState(bool state) => emit(EnableButtonState(enable: state));
}
