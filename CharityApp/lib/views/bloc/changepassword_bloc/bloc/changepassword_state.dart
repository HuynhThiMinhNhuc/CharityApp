part of 'changepassword_bloc.dart';

abstract class ChangepasswordState extends Equatable {
  const ChangepasswordState();
  
  @override
  List<Object> get props => [];
}

class ChangepasswordInitial extends ChangepasswordState {}
class ChangepasswordSuccess extends ChangepasswordState {}
class ChangepasswordFailConfirmPass extends ChangepasswordState {}
class ChangepasswordFailOldpass extends ChangepasswordState {}
