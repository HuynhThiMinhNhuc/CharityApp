import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/repositories/active_user_repository_imp.dart';
import 'package:equatable/equatable.dart';

part 'activeuser_event.dart';
part 'activeuser_state.dart';

class ActiveuserBloc extends Bloc<ActiveuserEvent, ActiveuserState> {
  ActiveUserRepositoryImp _activeUserRepositoryImp =
      new ActiveUserRepositoryImp();
  ActiveuserBloc() : super(ActiveuserInitialState()) {
    on<ActiveuserLoadEvent>(_onActiveuserLoadEvent);
    on<ActiveuserClickEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  FutureOr<void> _onActiveuserLoadEvent(
      ActiveuserLoadEvent event, Emitter<ActiveuserState> emit) async {
    try {
      emit(ActiveuserLoadingState());
      List<UserOverview> list = await _activeUserRepositoryImp.loadActiveUser();
      if (list.length != 0)
        emit(ActiveuserLoadedState(list));
      else
        emit(ActiveuserLoadFailState());
    } catch (e) {
      print("ActiveuserBloc: Error loading active user" + e.toString());
      emit(ActiveuserLoadFailState());
    }
  }
}
