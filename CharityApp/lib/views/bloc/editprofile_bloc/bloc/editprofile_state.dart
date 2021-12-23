part of 'editprofile_bloc.dart';

abstract class EditprofileState extends Equatable {
  const EditprofileState();
  
  @override
  List<Object> get props => [];
}

class EditprofileLoading extends EditprofileState {}
class EditprofileLoaded extends EditprofileState {}
class EditprofileLoadFail extends EditprofileState {}
