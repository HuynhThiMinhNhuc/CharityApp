part of 'friend_bloc.dart';

abstract class FriendEvent extends Equatable {
  const FriendEvent();

  @override
  List<Object> get props => [];
}

class FriendLoadEvent extends FriendEvent {
  final String id;
  FriendLoadEvent(this.id);
}

class FriendFindEvent extends FriendEvent {
  final String name;
  FriendFindEvent(this.name);
}
