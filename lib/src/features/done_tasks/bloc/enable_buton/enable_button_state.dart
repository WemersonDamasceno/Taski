import 'package:equatable/equatable.dart';

class EnableButtonState extends Equatable {
  final bool enable;
  const EnableButtonState({this.enable = false});

  @override
  List<Object?> get props => [enable];
}
