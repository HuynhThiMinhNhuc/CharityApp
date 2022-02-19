import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:email_auth/email_auth.dart';
import 'package:equatable/equatable.dart';

part 'verifycode_event.dart';
part 'verifycode_state.dart';

class VerifycodeBloc extends Bloc<VerifycodeEvent, VerifycodeState> {
  EmailAuth emailAuth = new EmailAuth(sessionName: "MeerApp");
  VerifycodeBloc() : super(VerifycodeInitialState()) {
    on<VerifycodeVerifyEvent>(_onVerifycodeVerifyEvent);
    on<VerifycodeInitEvent>(_onVerifycodeInitEvent);
  }

  FutureOr<void> _onVerifycodeVerifyEvent(
      VerifycodeVerifyEvent event, Emitter<VerifycodeState> emit) async {
    // emit(VerifycodeSucessState());
    verify(event.email, event.otp)
        ? emit(VerifycodeSucessState())
        : emit(VerifycodeFailState());
    emit(VerifycodeLoadState());
  }

  FutureOr<void> _onVerifycodeInitEvent(
      VerifycodeInitEvent event, Emitter<VerifycodeState> emit) async {
    emailAuth.config({
      "server": "AIzaSyDiYe59uu2huTpTqe1UNovmCjD3q0ri7Nk",
      "serverKey":
          "AAAAtVWAz5g:APA91bEOSEPO1CjqPqzdx-aG20swL-0wI9cPdN33MEXq9QU4M2efwqCEXUYvzLE9Mwy1Dl4ZbHGErvNUI95X95yLFgEGNCKYT6uhvI_5IAW9baYte0MQihVrBF8CoaK5UZ4nQkxQJaTv"
    });
    if (await sendOtp(event.email) == false) emit(VerifycodeInitialState());
  }

  Future<bool> sendOtp(String email) async {
    bool result = false;
    try {
      result = await emailAuth.sendOtp(recipientMail: email);
    } catch (e) {
      print("Lỗi gửi mã OTP:" + e.toString());
    }
    return result;
  }

  bool verify(String email, String otp) {
    return emailAuth.validateOtp(recipientMail: email, userOtp: otp);
  }
}
