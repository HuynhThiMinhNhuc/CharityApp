import 'package:equatable/equatable.dart';

abstract class OverviewUserEvent extends Equatable {
  const OverviewUserEvent();
}

class LoadOverViewUserEvent extends OverviewUserEvent {
  final id;
  LoadOverViewUserEvent(this.id);

  @override
  List<Object> get props => [];
}

class FollowEvent extends OverviewUserEvent {
  final String? id;
  FollowEvent(this.id);

  @override
  List<Object?> get props => [];
}
class UnFollowEvent extends OverviewUserEvent {
  final String? id;
  UnFollowEvent(this.id);

  @override
  List<Object?> get props => [];
}

class AcceptJoinerEvent extends OverviewUserEvent {
  final String? id;
  AcceptJoinerEvent(this.id);

  @override
  List<Object?> get props => [];
}
class DenieJoinerEvent extends OverviewUserEvent {
  final String? id;
  DenieJoinerEvent(this.id);

  @override
  List<Object?> get props => [];
}

class RemoveJoinerEvent extends OverviewUserEvent {
  final String? id;
  RemoveJoinerEvent(this.id);

  @override
  List<Object?> get props => [];
}
