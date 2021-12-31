import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Pages/profile_page/profile_page.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_even.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class OverViewUserBloc extends Bloc<OverviewUserEvent, OverViewUserState> {
  var userProfile;
  mode modeprofile = mode.My;
  final _userReposibility = new UserRepositoryImp();

  OverViewUserBloc() : super(LoadingOverViewUserState()) {
    on<LoadOverViewUserEvent>(_onLoadPostEvent);
    on<UnFollowEvent>(_onUnFollowEvent);
    on<FollowEvent>(_followEvent);
  }
  Future<void> _onLoadPostEvent(
      LoadOverViewUserEvent event, Emitter<OverViewUserState> emit) async {
    print("onLoadPostEvent");
    try {
      emit(LoadingOverViewUserState());
      userProfile = await _userReposibility.getUserProfile(event.id);
      bool isfriend = await _userReposibility.isFriend(event.id);
      event.id == GetIt.instance.get<Authenticator>().userProfile.id
          ? modeprofile = mode.My
          : isfriend
              ? modeprofile = mode.Friend
              : modeprofile = mode.Stranger;
      emit(LoadedOverViewUserState(userProfile, modeprofile));
    } catch (e) {
      print("Loi loading OverViewUserEvent  " + e.toString());
      emit(LoadFailOverViewUserState());
    }
  }

  Future<void> _followEvent(
      FollowEvent event, Emitter<OverViewUserState> emit) async {
    try {
      await _userReposibility.follow(event.id);
    } catch (e) {
      print("Theo dõi bạn bè:" + e.toString());
    }
  }

  Future<void> _onUnFollowEvent(
      UnFollowEvent event, Emitter<OverViewUserState> emit) async {
    try {
      await _userReposibility.unfollow(event.id);
    } catch (e) {
      print("Bỏ theo dõi bạn bè:" + e.toString());
    }
  }
}
