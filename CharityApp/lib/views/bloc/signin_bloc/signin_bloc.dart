import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/repositories/active_user_repository_imp.dart';
import 'package:charityapp/repositories/email_reposity_imp.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final ActiveUserRepositoryImp _activeUserRepositoryImp =
      new ActiveUserRepositoryImp();
  final UserRepositoryImp _userRespositoryImp = new UserRepositoryImp();
  final EmailReposityImp _emailReposity = new EmailReposityImp();

  SigninBloc() : super(SigninInitState()) {
    on<SigninWithEmailAndPassEvent>(_signinWithEmailandPassEvent);
    on<SignInWithGoogle>(_signInWithGoogle);
  }

  Future<void> _signinWithEmailandPassEvent(
      SigninWithEmailAndPassEvent event, Emitter<SigninState> emit) async {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(event.email)) {
      emit(SigninfailEmailState());
      emit(SigninInitState());
    } else try {
        emit(SignInLoadInProccess());
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);

        await GetIt.instance.get<Authenticator>().login(event.email);
        _activeUserRepositoryImp
            .addActiveUser(GetIt.instance.get<Authenticator>().userProfile.id!);

        emit(SigninSuccessState());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'invalid-email') {
          print('No user found for that email.');
          emit(SigninfailEmailState());
          emit(SigninInitState());
        } else if (event.password.isEmpty || e.code == 'wrong-password') {
          print('Wrong password provided for that user.' + e.code);
          emit(SigninfailPassState());
          emit(SigninInitState());
        } else {
          print('Too many request');
          emit(SigninManyRequestPassState());
          emit(SigninInitState());
        }
      }
  }

  Future<FutureOr<void>> _signInWithGoogle(
      SignInWithGoogle event, Emitter<SigninState> emit) async {
    final googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
    GoogleSignInAccount? user;
    final ggUser = await googleSignIn.signIn();
    await GoogleSignIn().disconnect();
    if (ggUser != null) {
      user = ggUser;

      final ggAuth = await ggUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: ggAuth.accessToken, idToken: ggAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);

      final emailAlreadyExist =
          await _emailReposity.emailAlreadyExist(user.email);
      if (!emailAlreadyExist) {
        UserProfile userInfo = new UserProfile(
            name: user.displayName,
            avatarUri: user.photoUrl,
            phone: "",
            email: user.email);
        _userRespositoryImp.create(userInfo);
        _emailReposity.addEmail(userInfo.email);
        await GetIt.instance.get<Authenticator>().login(user.email);
        _activeUserRepositoryImp
            .addActiveUser(GetIt.instance.get<Authenticator>().userProfile.id!);
        emit(SigninSuccessState());
      } else {
        await GetIt.instance.get<Authenticator>().login(user.email);
        _activeUserRepositoryImp
            .addActiveUser(GetIt.instance.get<Authenticator>().userProfile.id!);
        emit(SigninSuccessState());
      }
    }
  }
}
