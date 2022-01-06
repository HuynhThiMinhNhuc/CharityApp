import 'package:equatable/equatable.dart';

abstract class FormState extends Equatable {
  const FormState();
  
  @override
  List<Object> get props => [];
}

class FormFail extends FormState{
  final String errorId;
  final String error;
  const FormFail({required this.error, required this.errorId});

    @override
  List<Object> get props => [error, errorId];
}
class FormSuccess extends FormState {
}
