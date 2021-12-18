abstract class OverViewUserState{
  const OverViewUserState();
}
class LoadingOverViewUserState extends OverViewUserState {}
class LoadedOverViewUserState extends OverViewUserState{
  var userProfile;
  LoadedOverViewUserState(this.userProfile);
}
class LoadFailOverViewUserState extends OverViewUserState{}

class MyProfileState extends OverViewUserState{
  var id;
      MyProfileState(this.id);
}
class FriendProfileState extends OverViewUserState{
  var id;
  FriendProfileState(this.id);
}
class StrangerProfileState extends OverViewUserState{
  var id;
  StrangerProfileState(this.id);
}

