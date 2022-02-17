part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  const SigninState();
  
  @override
  List<Object> get props => [];
}

class SigninInitState extends SigninState {}
class SignInLoadInProccess extends SigninState{}
class SigninSuccessState extends SigninState {}

class SigninFailState extends SigninState{}
class SigninfailEmailState extends SigninFailState {}
class SigninfailPassState extends SigninFailState {}
class SigninManyRequestPassState extends SigninFailState {}


