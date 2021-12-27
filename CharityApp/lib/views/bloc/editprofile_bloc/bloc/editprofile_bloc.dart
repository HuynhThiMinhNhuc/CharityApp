import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:equatable/equatable.dart';

part 'editprofile_event.dart';
part 'editprofile_state.dart';

class EditprofileBloc extends Bloc<EditprofileEvent, EditprofileState> {
  UserRepositoryImp _userRepositoryImp = new UserRepositoryImp();

  EditprofileBloc() : super(EditprofileLoading()) {
    on<EditprofileEditEvent>(_onEditprofileEditEvent);
  }

  FutureOr<void> _onEditprofileEditEvent(
      EditprofileEditEvent event, Emitter<EditprofileState> emit) async {
    try {
      emit(EditprofileLoading());
      await _userRepositoryImp.update(event.userProfile);
    } catch (e) {
      print("Lỗi update userinfor" + e.toString());
    }
  }
}
