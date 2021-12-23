part of 'editprofile_bloc.dart';

abstract class EditprofileEvent extends Equatable {
  const EditprofileEvent();

  @override
  List<Object> get props => [];
}

class EditprofileLoadEvent extends EditprofileEvent {}

class EditprofileEditEvent extends EditprofileEvent {
  final UserProfile userProfile;
  EditprofileEditEvent(this.userProfile);
}
