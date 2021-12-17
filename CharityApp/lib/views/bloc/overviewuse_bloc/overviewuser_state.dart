abstract class OverViewUserState{
  const OverViewUserState();
}
class LoadingOverViewUserState extends OverViewUserState {}
class LoadedOverViewUserState extends OverViewUserState{
  var userProfile;
  LoadedOverViewUserState(this.userProfile);
}
class LoadFailOverViewUserState extends OverViewUserState{}

