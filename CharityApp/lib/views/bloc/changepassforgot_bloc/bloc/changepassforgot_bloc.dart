import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/views/bloc/changepassword_bloc/bloc/changepassword_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'changepassforgot_event.dart';
part 'changepassforgot_state.dart';

class ChangepassforgotBloc
    extends Bloc<ChangepassforgotEvent, ChangepassforgotState> {
  final UserRepositoryImp _userRepositoryImp = new UserRepositoryImp();
  ChangepassforgotBloc() : super(ChangepassforgotInitial()) {
    on<ChangepassforgotEvent>(_onChangepassforgotEvent);
  }
  FutureOr<void> _onChangepassforgotEvent(
      ChangepassforgotEvent event, Emitter<ChangepassforgotState> emit) async {
    event = event as ChangepassforgotChange;
    if (event.confirmpass == "" || event.newpass == "") {
      emit(ChangepassforgotEmpty());
      emit(ChangepassforgotInitial());
    } else if (!checkCofirmPass(event.confirmpass, event.newpass)) {
      emit(ChangepassforgotWrongconfirmpass());
      emit(ChangepassforgotInitial());
    } else
      try {
        _userRepositoryImp.changepassword(event.newpass);
        emit(Changepassforgotsuccess());
      } catch (e) {
        print("Lỗi update mật khẩu:" + e.toString());
      }
  }

  bool checkCofirmPass(String confirmpass, String oldpass) {
    return (confirmpass == oldpass);
  }
}
