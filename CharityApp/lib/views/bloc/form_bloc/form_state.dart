import 'package:equatable/equatable.dart';

abstract class FormState extends Equatable {
  const FormState();
  
  @override
  List<Object> get props => [];
}

class FormLoadInProccess extends FormState {}
class FormLoadFail extends FormState{}
class FormLoadSuccess extends FormState {
}
