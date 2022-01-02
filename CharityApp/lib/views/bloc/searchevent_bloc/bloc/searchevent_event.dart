part of 'searchevent_bloc.dart';

abstract class SearcheventEvent extends Equatable {
  const SearcheventEvent({Key? key});

  @override
  List<Object> get props => [];
}

class SearcheventLoadTags extends SearcheventEvent {}

class SearcheventSearch extends SearcheventEvent {
  final String query;
  final List<bool> tags;
  SearcheventSearch({Key? key, required this.query,required this.tags}) : super(key: key);
}
