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

class FriendSearchEvent extends FriendEvent {
  final String name;
  FriendSearchEvent(this.name);
}

class FriendLoadHistoryEvent extends FriendEvent {
  final String id;
  FriendLoadHistoryEvent(this.id);
}

class FriendUpdateHistoryEvent extends FriendEvent {
  final String id;
  final String idSearch;
  FriendUpdateHistoryEvent(this.id, this.idSearch);
}
