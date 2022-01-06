import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
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
  final String formId;
  const FormSuccess({required this.formId});
    @override
  List<Object> get props => [formId];
}
class FormLoadSuccess extends FormState {
  final FormRegister form;
  final UserProfile user;
  const FormLoadSuccess({required this.form, required this.user});

  
    @override
  List<Object> get props => [form];
}
