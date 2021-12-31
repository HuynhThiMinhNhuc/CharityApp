import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:equatable/equatable.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';

part 'editprofile_event.dart';
part 'editprofile_state.dart';

class EditprofileBloc extends Bloc<EditprofileEvent, EditprofileState> {
  UserRepositoryImp _userRepositoryImp = new UserRepositoryImp();

  EditprofileBloc() : super(EditprofileLoading()) {
    on<EditprofileEditEvent>(_onEditprofileEditEvent);
  }

  FutureOr<void> _onEditprofileEditEvent(
      EditprofileEditEvent event, Emitter<EditprofileState> emit) async {

    if (phoneNumberWrong(event.userProfile.phone)) {
      emit(EditprofilePhoneWrongFormatFail());
      emit(EditprofileInit());
    } else
      try {
        await _userRepositoryImp.update(event.userProfile);
        setUserProfile(GetIt.instance.get<Authenticator>().userProfile, event.userProfile);
        emit(EditprofileSucess());
      } catch (e) {
        print("Lỗi update userinfor" + e.toString());
      }
  }

  bool phoneNumberWrong(String phone) {
    bool valid = false;
    if (phone.length != 10 || phone[0] != '0') return true;
    return valid;
  }

  void setUserProfile(UserProfile recive, UserProfile give) {
    recive.email = give.email;
    recive.phone = give.phone;
    recive.birthDayString = give.birthDayString;
    recive.gender = give.gender;
    recive.description = give.description;
    recive.avatarUri = give.avatarUri;
    recive.name = give.name;
    recive.address = give.address;
  }
}
