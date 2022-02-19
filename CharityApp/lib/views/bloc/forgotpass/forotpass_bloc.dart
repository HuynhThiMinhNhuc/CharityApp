import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'forotpass_event.dart';
part 'forotpass_state.dart';

class ForotpassBloc extends Bloc<ForotpassEvent, ForotpassState> {
  UserRepositoryImp _userRepositoryImp = new UserRepositoryImp();

  ForotpassBloc() : super(ForotpassInitial()) {
    on<SentOtp>(_onSentOtp);
  }
  Future<FutureOr<void>> _onSentOtp(
      SentOtp event, Emitter<ForotpassState> emit) async {
    try {
      await _userRepositoryImp.resetpassword(event.email);
    } catch (e) {
      print("ERROR sent otp reset pass" + e.toString());
    }
  }
}
