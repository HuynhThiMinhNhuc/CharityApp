import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:equatable/equatable.dart';

part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final UserRepositoryImp userRepositoryImp = new UserRepositoryImp();
  final List<UserOverview> friends = [];
  FriendBloc() : super(FriendLoadingPageState()) {
    on<FriendLoadEvent>(_onFriendLoadEvent);
    on<FriendSearchEvent>(_onFriendSearchEvent);
    on<FriendLoadHistoryEvent>(_onFriendLoadHistoryEvent);
    on<FriendUpdateHistoryEvent>(_onFriendUpdateHistoryEvent);
  }

  FutureOr<void> _onFriendLoadEvent(
      FriendLoadEvent event, Emitter<FriendState> emit) async {
    try {
      emit(FriendLoadingPageState());
      final friends = await userRepositoryImp.loadFriends(event.id, 20);
      final totalfriend = friends.length;
      final history = await userRepositoryImp.getHistory(event.id);
      emit(FriendLoadedPageState(friends, totalfriend, history));
    } catch (e) {
      print("Lỗi tải bạn bè thất bại" + e.toString());
      emit(FriendLoadPageFailState());
    }
    emit(FriendInitateState());
  }

  FutureOr<void> _onFriendSearchEvent(
      FriendSearchEvent event, Emitter<FriendState> emit) async {
    try {
      emit(FriendSearchLoadingState());
      List<UserOverview> suggestions =
          await userRepositoryImp.searchUser(event.name.trim());
      emit(FriendSearchWithResultState(suggestions));
    } catch (e) {
      print("Lỗi tìm kiếm thất bại" + e.toString());
      emit(FriendSearchNoResultState());
    }
  }

  Future<FutureOr<void>> _onFriendLoadHistoryEvent(
      FriendLoadHistoryEvent event, Emitter<FriendState> emit) async {
    await userRepositoryImp.getHistory(event.id);
  }

  Future<FutureOr<void>> _onFriendUpdateHistoryEvent(
      FriendUpdateHistoryEvent event, Emitter<FriendState> emit) async {
    await userRepositoryImp.updateHistory(event.id, event.idSearch);
  }
}
