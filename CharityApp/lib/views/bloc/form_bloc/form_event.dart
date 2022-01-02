import 'package:charityapp/domain/entities/form_register.dart';
import 'package:equatable/equatable.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class RegisterForm extends FormEvent{
  final FormRegister form;
  const  RegisterForm({required this.form});

    @override
  List<Object> get props => [form];
}
class UnRegisterForm extends FormEvent {
  final String eventId;

  const UnRegisterForm({required this.eventId});

      @override
  List<Object> get props => [eventId];
}

class ConfirmForm extends FormEvent {
  final String formId;
  final bool isConfirm;

  const ConfirmForm({required this.formId, required this.isConfirm});

        @override
  List<Object> get props => [formId, isConfirm];
}