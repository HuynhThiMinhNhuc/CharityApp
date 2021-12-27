part of 'activeuser_bloc.dart';

abstract class ActiveuserState extends Equatable {
  const ActiveuserState();

  @override
  List<Object> get props => [];
}

class ActiveuserInitialState extends ActiveuserState {}

class ActiveuserLoadingState extends ActiveuserState {}

class ActiveuserLoadedState extends ActiveuserState {
  List<UserOverview> users = [];
  ActiveuserLoadedState(this.users);
}

class ActiveuserLoadFailState extends ActiveuserState {}
