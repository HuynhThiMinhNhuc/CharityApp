import 'package:charityapp/views/Pages/profile_page/profile_page.dart';

abstract class OverViewUserState {
  const OverViewUserState();
}

class LoadingOverViewUserState extends OverViewUserState {}

class LoadedOverViewUserState extends OverViewUserState {
  var userProfile;
  mode isfriend;
  LoadedOverViewUserState(this.userProfile, this.isfriend);
}

class LoadFailOverViewUserState extends OverViewUserState {}
class FollowOverViewUserState extends OverViewUserState {
  var userProfile;
  mode isfriend;
  FollowOverViewUserState(this.userProfile, this.isfriend);
}
class UnfollowOverViewUserState extends OverViewUserState {
  var userProfile;
  mode isfriend;
  UnfollowOverViewUserState(this.userProfile, this.isfriend);
}
