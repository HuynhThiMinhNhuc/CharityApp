import 'package:charityapp/domain/entities/form_register.dart';
import 'package:equatable/equatable.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class LoadForm extends FormEvent{
  final String userId;
  final String eventId;
  const LoadForm({required this.userId, required this.eventId});

    @override
  List<Object> get props => [userId, eventId];
}

class RegisterForm extends FormEvent{
  final FormRegister form;
  const  RegisterForm({required this.form});

    @override
  List<Object> get props => [form];
}
class UnRegisterForm extends FormEvent {
  final String eventId;
  final String userId;

  const UnRegisterForm({required this.eventId, required this.userId});

      @override
  List<Object> get props => [eventId, userId];
}

class ConfirmForm extends FormEvent {
  final String eventId;
  final String userId;
  final bool isConfirm;

  const ConfirmForm({required this.eventId, required this.userId, required this.isConfirm});

        @override
  List<Object> get props => [eventId, userId, isConfirm];
}