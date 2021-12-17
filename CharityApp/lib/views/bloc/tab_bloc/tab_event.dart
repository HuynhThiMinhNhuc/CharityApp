import 'package:charityapp/core/model/app_tab.dart';
import 'package:equatable/equatable.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object> get props => [];
}

class UpdateTab extends TabEvent {
  final AppTab newActiveTab;
  const UpdateTab({required this.newActiveTab});

  @override
  List<Object> get props => [newActiveTab];
}
