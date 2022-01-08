import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:charityapp/repositories/event_repository_imp.dart';
import 'package:charityapp/repositories/tag_event_repository_imp.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

part 'searchevent_event.dart';
part 'searchevent_state.dart';

class SearcheventBloc extends Bloc<SearcheventEvent, SearcheventState> {
  TagEventRepositoryImp _tagEventRepositoryImp = new TagEventRepositoryImp();
  EventRepositoryImp _eventrepositoryImp = new EventRepositoryImp();
  List<TagEvent> tags = [];
  SearcheventBloc() : super(SearcheventInitial()) {
    on<SearcheventLoadTags>(_onSearcheventLoadTags);
    on<SearcheventSearch>(_onSearcheventSearch);
  }
  FutureOr<void> _onSearcheventLoadTags(
      SearcheventLoadTags event, Emitter<SearcheventState> emit) async {
    try {
      emit(SearcheventTagLoading());
      tags = await _tagEventRepositoryImp.loadTags();
      emit(SearcheventTagLoaded(listTags: tags));
    } catch (e) {
      print("Error load tag" + e.toString());
      emit(SearcheventTagLoadfail());
    }
  }

  FutureOr<void> _onSearcheventSearch(
      SearcheventSearch event, Emitter<SearcheventState> emit) async {
    try {
      emit(SearcheventEventLoading());
      List<EventOverview> events = [];
      List<TagEvent> tagsevent = [];
      int i = 0;
      for (var tag in tags) {
        if (event.tags[i]) tagsevent.add(tag);
        ++i;
      }
      events =
          await _eventrepositoryImp.searchevent(event.query, tagsevent);
      if (events.length == 0)
        emit(SearcheventNoResult());
      else
        emit(SearcheventResult(listEvent: events));
    } catch (e) {
      emit(SearcheventEventLoadfail());
      print("Error search event" + e.toString());
    }
  }
}
