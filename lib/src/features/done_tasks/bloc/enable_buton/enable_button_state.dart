import 'package:equatable/equatable.dart';

class EnableButtonState extends Equatable {
  const EnableButtonState({this.enable = false});
  final bool enable;

  @override
  List<Object?> get props => [enable];
}
