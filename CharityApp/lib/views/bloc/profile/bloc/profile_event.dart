part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileSaveEvent extends ProfileEvent {
  final UserInfor userInfor;
  final String email;
  ProfileSaveEvent(this.userInfor, this.email);
}
