import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/repositories/form_repository.dart';
import 'package:charityapp/repositories/form_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  IFormRepository formRepository = FormRepositoryImp();

  FormBloc() : super(FormSuccess()) {
    on<RegisterForm>(_onRegisterForm);
    on<UnRegisterForm>(_onUnregisterForm);
    on<ConfirmForm>(_onConfirmForm);
  }

  FutureOr<void> _onRegisterForm(RegisterForm event, Emitter<FormState> emit) {
    try {
      formRepository.register(event.form);
      emit(FormSuccess());
    } catch (e) {
      print("ERROR: " + e.toString());
      emit(FormFail(errorId: event.form.eventId, error: 'Không thể đăng ký thành viên sự kiện này'));
    }
  }

  FutureOr<void> _onUnregisterForm(
      UnRegisterForm event, Emitter<FormState> emit) {
    try {
      formRepository.unRegister(event.eventId, Authenticator.Id);
      emit(FormSuccess());
    } catch (e) {
      emit(FormFail(errorId: event.eventId, error: 'Không thể hủy thao tác này'));
    }
  }

  FutureOr<void> _onConfirmForm(ConfirmForm event, Emitter<FormState> emit) {
    try {
      formRepository.confirm(event.formId, event.isConfirm);
      emit(FormSuccess());
    } catch (e) {
      emit(FormFail(errorId: event.formId, error: 'Form không tồn tại'));
    }
  }
}
