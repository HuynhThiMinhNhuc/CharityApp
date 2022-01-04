part of 'friend_bloc.dart';

abstract class FriendState extends Equatable {
  const FriendState();

  @override
  List<Object> get props => [];
}

class FriendInitateState extends FriendState {}
class FriendLoadingPageState extends FriendState {}
class FriendLoadPageFailState extends FriendState {}
class FriendLoadedPageState extends FriendState {
  final List<UserOverview> friends;
  final totalfriend;
  FriendLoadedPageState(this.friends, this.totalfriend);
}

class FriendSearchWithResultState extends FriendState {
  final List<UserOverview> suggestion;
  FriendSearchWithResultState(this.suggestion);
}

class FriendSearchNoResultState extends FriendState {}
class FriendSearchLoadingState extends FriendState {}

