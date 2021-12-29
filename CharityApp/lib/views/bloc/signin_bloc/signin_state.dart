part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  const SigninState();
  
  @override
  List<Object> get props => [];
}

class SigninInitState extends SigninState {}
class SigninSussessState extends SigninState {}
class SigninfailEmailState extends SigninState {}
class SigninfailPassState extends SigninState {}
class SigninManyRequestPassState extends SigninState {}


