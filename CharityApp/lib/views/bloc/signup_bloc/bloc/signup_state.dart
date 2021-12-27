part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();
  
  @override
  List<Object> get props => [];
}

class SignupLoadingState extends SignupState {}
class SignupSussesState extends SignupState {}
class SignupFailPassweakState extends SignupState {}
class SignupFailMutilAccountState extends SignupState {}
