import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:equatable/equatable.dart';

part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final UserRepositoryImp userRepositoryImp = new UserRepositoryImp();
  final List<UserOverview> friends = [];
  FriendBloc() : super(FriendLoadingState()) {
    on<FriendLoadEvent>(_onFriendLoadEvent);
    on<FriendSearchEvent>(_onFriendSearchEvent);
  }

  FutureOr<void> _onFriendLoadEvent(
      FriendLoadEvent event, Emitter<FriendState> emit) async {
    try {
      emit(FriendLoadingState());
      final friends = await userRepositoryImp.loadFriends(event.id, 20);
      final totalfriend = await userRepositoryImp.loadNumberFriends(event.id);
      emit(FriendLoadedState(friends, totalfriend));
    } catch (e) {
      print("Lỗi tải bạn bè thất bại");
      emit(FriendLoadFailState());
    }
  }

  FutureOr<void> _onFriendSearchEvent(
      FriendSearchEvent event, Emitter<FriendState> emit) async {
    try {
      emit(FriendLoadingState());
      List<UserOverview> suggestions =
          await userRepositoryImp.searchUser(event.name);
      emit(FriendSearchState(suggestions));
    } catch (e) {
      print("Lỗi tìm kiếm thất bại" + e.toString());
      emit(FriendLoadFailState());
    }
  }
}
