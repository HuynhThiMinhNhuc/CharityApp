import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final UserRepositoryImp _userRepositoryImp = new UserRepositoryImp();

  SigninBloc() : super(SigninLoadingState()) {
    on<SigninLoadEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SigninWithEmailAndPassEvent>((event, emit) {
      _signinWithEmailandPassEvent;
    });
  }

  FutureOr<void> _signinWithEmailandPassEvent(
      SigninWithEmailAndPassEvent event, Emitter<SigninState> emit) async {
    try {
      emit(SigninLoadingState());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        GetIt.instance.get<Authenticator>().login(event.email, event.password);
        emit(SigninSussessState());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          emit(SigninfailEmailState());
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          emit(SigninfailPassState());
        }
      }
    } catch (e) {
      print("Lỗi đăng nhập: " + e.toString());
    }
  }
}
