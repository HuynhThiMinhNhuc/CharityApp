part of 'verifycode_bloc.dart';

abstract class VerifycodeEvent extends Equatable {
  const VerifycodeEvent();

  @override
  List<Object> get props => [];
}

class VerifycodeVerifyEvent extends VerifycodeEvent {
  final String otp;
  final String email;
  VerifycodeVerifyEvent(this.otp, this.email);
}
class VerifycodeInitEvent extends VerifycodeEvent {
  final String email;
  VerifycodeInitEvent(this.email);
}
