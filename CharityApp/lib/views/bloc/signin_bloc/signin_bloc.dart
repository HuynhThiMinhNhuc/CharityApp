import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/repositories/active_user_repository_imp.dart';
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
  final ActiveUserRepositoryImp _activeUserRepositoryImp =
      new ActiveUserRepositoryImp();
  SigninBloc() : super(SigninInitState()) {
    on<SigninLoadEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SigninWithEmailAndPassEvent>(_signinWithEmailandPassEvent);
  }

  Future<void> _signinWithEmailandPassEvent(
      SigninWithEmailAndPassEvent event, Emitter<SigninState> emit) async {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(event.email)) {
      emit(SigninfailEmailState());
    } else
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        await GetIt.instance.get<Authenticator>().login(event.email);
        await _activeUserRepositoryImp
            .addActiveUser(GetIt.instance.get<Authenticator>().userProfile.id);
        emit(SigninSussessState());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'invalid-email') {
          print('No user found for that email.');
          emit(SigninfailEmailState());
        } else if (event.password.isEmpty || e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          emit(SigninfailPassState());
        } else {
          print('Too many request');
          emit(SigninManyRequestPassState());
        }
      }
    emit(SigninInitState());
  }
}
