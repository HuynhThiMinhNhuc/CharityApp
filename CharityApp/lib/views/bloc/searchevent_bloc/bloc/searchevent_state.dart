part of 'searchevent_bloc.dart';

abstract class SearcheventState extends Equatable {
  const SearcheventState({Key? key});

  @override
  List<Object> get props => [];
}

class SearcheventInitial extends SearcheventState {}

class SearcheventTagLoading extends SearcheventState {}

class SearcheventTagLoaded extends SearcheventState {
  final List<TagEvent> listTags;
  SearcheventTagLoaded({Key? key, required this.listTags}) : super(key: key);
}

class SearcheventTagLoadfail extends SearcheventState {}

class SearcheventResult extends SearcheventState {
  final List<EventOverview> listEvent;
  SearcheventResult({Key? key, required this.listEvent}) : super(key: key);
}

class SearcheventNoResult extends SearcheventState {}
class SearcheventEventInitial extends SearcheventState {}

class SearcheventEventLoading extends SearcheventState {}
class SearcheventEventLoadfail extends SearcheventState {}

