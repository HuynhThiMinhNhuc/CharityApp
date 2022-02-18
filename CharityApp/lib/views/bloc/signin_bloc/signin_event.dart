part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SigninLoadEvent extends SigninEvent {}

class SigninWithEmailAndPassEvent extends SigninEvent {
  final String email;
  final String password;
  SigninWithEmailAndPassEvent(this.email, this.password);
}

class SignInWithGoogle extends SigninEvent {
  SignInWithGoogle();
}
