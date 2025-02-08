import 'package:equatable/equatable.dart';

class EnableButtonState extends Equatable {
  final bool enable;
  const EnableButtonState({required this.enable});

  @override
  List<Object?> get props => [enable];
}
