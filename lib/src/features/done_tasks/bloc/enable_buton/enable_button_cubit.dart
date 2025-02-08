import 'package:flutter_bloc/flutter_bloc.dart';

class EnableDeleteButtonCubit extends Cubit<bool> {
  EnableDeleteButtonCubit() : super(true);

  void changeState(bool state) => emit(state);
}
