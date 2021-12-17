import 'dart:typed_data';

import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_even.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_state.dart';
import 'package:charityapp/views/bloc/post_bloc/post_event.dart';
import 'package:flutter/services.dart';
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
    final ByteData data =  await NetworkAssetBundle(Uri.parse( "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")).load("");

    try{
      emit( LoadingOverViewUserState());
     // userProfile = new UserProfile(name: "Nhuc", avatar: data.buffer.asUint8List(),description: "Hihihihhihihi");
     // emit(LoadedOverViewUserState(userProfile));
    }
    catch (e){
      emit( LoadFailOverViewUserState());
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