import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_even.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class OverViewUserBloc extends Bloc<OverviewUserEvent, OverViewUserState>{
  var userProfile ;
  final _userReposibility = new UserRepositoryImp();

  OverViewUserBloc(): super (LoadingOverViewUserState()){
    on<LoadOverViewUserEvent>(_onLoadPostEvent);
  }
  Future<void> _onLoadPostEvent(LoadOverViewUserEvent event, Emitter<OverViewUserState> emit)async {
    print("onLoadPostEvent");

    try{
      emit( LoadingOverViewUserState());
      //userProfile = new UserProfile(name: "Nhuc",description: "Type some thing here...", birthDayString :"17/02/2001");
      userProfile =  await _userReposibility.getUserProfile(GetIt.instance.get<Authenticator>().idCurrentUser);
      emit(LoadedOverViewUserState(userProfile));

    }

     catch (e) {
      print("Loi loading OverViewUserEvent  " + e.toString());
      emit(LoadFailOverViewUserState());

    }
  }


  // Stream<OverViewUserState> mapEventToState(OverviewUserEvent event) async*{
  //   if ( event is LoadOverViewUserEvent)
  //     {
  //       yield* _mapToOverVewUserState();
  //     }
  // }
  // Stream<OverViewUserState> _mapToOverVewUserState() async*{
  //   try{
  //     yield LoadingOverViewUserState();
  //     userProfile =  await _userReposibility.getUserProfile(GetIt.instance.get<Authenticator>().idCurrentUser);
  //     yield LoadedOverViewUserState(userProfile);
  //   }
  //   catch (e){
  //     yield LoadFailOverViewUserState();
  //   }
  //
  // }
}