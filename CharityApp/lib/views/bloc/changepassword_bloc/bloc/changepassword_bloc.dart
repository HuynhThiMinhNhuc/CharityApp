import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'changepassword_event.dart';
part 'changepassword_state.dart';

class ChangepasswordBloc
    extends Bloc<ChangepasswordEvent, ChangepasswordState> {
  final UserRepositoryImp _userRepositoryImp = new UserRepositoryImp();
  ChangepasswordBloc() : super(ChangepasswordInitial()) {
    on<ChangepasswordChange>(_onChangepasswordChange);
  }
  FutureOr<void> _onChangepasswordChange(
      ChangepasswordChange event, Emitter<ChangepasswordState> emit) async {
    if (!checkCofirmPass(event.confirmpass, event.newpass)) {
      emit(ChangepasswordFailConfirmPass());
      emit(ChangepasswordInitial());
    } else if (!await checkvalidOldpass(event.email, event.oldpass)) {
      emit(ChangepasswordFailOldpass());
      emit(ChangepasswordInitial());
    } else
      try {
        _userRepositoryImp.changepassword(event.newpass);
        emit(ChangepasswordSuccess());
      } catch (e) {}
  }

  bool checkCofirmPass(String confirmpass, String oldpass) {
    return (confirmpass == oldpass);
  }

  Future<bool> checkvalidOldpass(String email, String password) async {
    try {
      User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (user != null)
        return true;
      else
        return false;
    } catch (e) {
      print("Wrong password:" + e.toString());
    }
    return false;
  }
}
