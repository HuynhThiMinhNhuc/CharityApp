part of 'friend_bloc.dart';

abstract class FriendState extends Equatable {
  const FriendState();

  @override
  List<Object> get props => [];
}

class FriendLoadingState extends FriendState {}

class FriendLoadedState extends FriendState {
  final List<UserOverview> friends;
  final totalfriend;
  FriendLoadedState(this.friends, this.totalfriend);
}

class FriendSearchState extends FriendState {
  final List<UserOverview> suggestion;
  FriendSearchState(this.suggestion);
}

class FriendLoadFailState extends FriendState {}
