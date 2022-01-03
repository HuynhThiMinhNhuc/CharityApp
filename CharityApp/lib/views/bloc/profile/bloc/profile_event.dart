part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileSaveEvent extends ProfileEvent {
  final UserProfile userInfor;
  ProfileSaveEvent(this.userInfor);
}
