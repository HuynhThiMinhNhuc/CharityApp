import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/repositories/email_reposity_imp.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepositoryImp _userRepositoryImp = new UserRepositoryImp();
  final EmailReposityImp _emailReposityImp = EmailReposityImp();

  SignupBloc() : super(SignupLoadingState()) {
    on<SignupWithEmailAndPassEvent>(_onSignupWithEmailAndPass);
  }

  FutureOr<void> _onSignupWithEmailAndPass(
      SignupWithEmailAndPassEvent event, Emitter<SignupState> emit) async {
    if (event.password == "" ||
        event.confirmPassword == '' ||
        event.email == "") {
      emit(SignupEmptyFeldmState());
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(event.email)) {
      emit(SignupFailEmailFomatState());
    } else if (event.confirmPassword != event.password || event.password == "")
      emit(SignupIncorrectPassConfirmState());
    else if (await _emailReposityImp.emailAlreadyExist(event.email))
      emit(SignupFailMutilAccountState());
    else
      try {
        emit(SignupInitState());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          User? user = FirebaseAuth.instance.currentUser;

          emit(SignupSussesState());
          if (user != null && !user.emailVerified) {
            await user.sendEmailVerification();
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
            emit(SignupFailPassweakState());
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
            emit(SignupFailMutilAccountState());
          } else
            emit(SignupNoReasonState());
        } catch (e) {
          print(e);
        }
      } catch (e) {
        print("Lỗi đăng ký:" + e.toString());
      }
    emit(SignupInitState());
  }
}
