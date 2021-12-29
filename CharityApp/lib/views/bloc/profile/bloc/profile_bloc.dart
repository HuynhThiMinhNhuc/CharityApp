import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepositoryImp userRepositoryImp = new UserRepositoryImp();
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileSaveEvent>(_onProfileSaveEvent);
  }

  FutureOr<void> _onProfileSaveEvent(
      ProfileSaveEvent event, Emitter<ProfileState> emit) async {
    try {
      await userRepositoryImp.create(event.userInfor, event.email);
      emit(ProfileSucessState());
    } catch (e) {
      print("Lỗi thêm người dùng");
      emit(ProfileFailState());
    }
  }
}
