part of 'changepassforgot_bloc.dart';

abstract class ChangepassforgotState extends Equatable {
  const ChangepassforgotState();
  
  @override
  List<Object> get props => [];
}

class ChangepassforgotInitial extends ChangepassforgotState {}
class Changepassforgotsuccess extends ChangepassforgotState {}
class ChangepassforgotWrongconfirmpass extends ChangepassforgotState {}
class ChangepassforgotEmpty extends ChangepassforgotState {}
