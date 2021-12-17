import 'package:equatable/equatable.dart';

abstract class OverviewUserEvent extends Equatable{
  const OverviewUserEvent();
}
class LoadOverViewUserEvent extends OverviewUserEvent{
  LoadOverViewUserEvent();

  @override
  List<Object> get props =>[];
}
