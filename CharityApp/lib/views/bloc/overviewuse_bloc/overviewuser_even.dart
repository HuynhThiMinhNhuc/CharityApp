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
