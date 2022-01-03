part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}
class ProfileSucessState extends ProfileState {}
class ProfileFailState extends ProfileState {}
class ProfileEmptyFeldState extends ProfileState {}
class ProfileWrongFormatPhoneState extends ProfileState {}
