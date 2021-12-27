part of 'activeuser_bloc.dart';

abstract class ActiveuserEvent extends Equatable {
  const ActiveuserEvent();

  @override
  List<Object> get props => [];
}

class ActiveuserLoadEvent extends ActiveuserEvent{}
class ActiveuserClickEvent extends ActiveuserEvent{}

