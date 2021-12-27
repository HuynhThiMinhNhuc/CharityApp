import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepositoryImp _userRepositoryImp = new UserRepositoryImp();

  SignupBloc() : super(SignupLoadingState()) {
    on<SignupWithEmailAndPassEvent>(_onSignupWithEmailAndPass);
  }

  FutureOr<void> _onSignupWithEmailAndPass(
      SignupWithEmailAndPassEvent event, Emitter<SignupState> emit) async {
    try {
      emit(SignupLoadingState());
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: event.email, password: event.password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          emit(SignupFailPassweakState());
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          emit(SignupFailMutilAccountState());
        }
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print("Lỗi đăng ký:" + e.toString());
    }
  }
}
