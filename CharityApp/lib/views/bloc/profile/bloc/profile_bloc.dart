import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/repositories/email_reposity.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepositoryImp userRepositoryImp = new UserRepositoryImp();
  EmailReposity emailReposity = new EmailReposity();
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileSaveEvent>(_onProfileSaveEvent);
  }

  FutureOr<void> _onProfileSaveEvent(
      ProfileSaveEvent event, Emitter<ProfileState> emit) async {
    if (event.userInfor.name == "" ||
        event.userInfor.birthDayString == "" ||
        event.userInfor.phone == "")
      emit(ProfileEmptyFeldState());
    else if (!RigntFormatPhone(event.userInfor.phone))
      emit(ProfileWrongFormatPhoneState());
    else
      try {
        event.userInfor.id = FirebaseAuth.instance.currentUser!.uid;
        await userRepositoryImp.create(event.userInfor);
        await emailReposity.addEmail(event.userInfor.email);
        emit(ProfileSucessState());
      } catch (e) {
        print("Lỗi thêm người dùng");
        emit(ProfileFailState());
      }
    emit(ProfileInitialState());
  }

  bool RigntFormatPhone(String phone) {
    return (phone[0] == '0' && phone.length == 10);
  }
}
