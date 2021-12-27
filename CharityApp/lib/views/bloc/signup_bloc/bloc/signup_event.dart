part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupWithEmailAndPassEvent extends SignupEvent {
  final String email;
  final String password;
  SignupWithEmailAndPassEvent(this.email, this.password);
}
