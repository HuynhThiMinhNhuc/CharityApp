part of 'verifycode_bloc.dart';

abstract class VerifycodeState extends Equatable {
  const VerifycodeState();
  
  @override
  List<Object> get props => [];
}

class VerifycodeInitialState extends VerifycodeState {}
class VerifycodeLoadState extends VerifycodeState {}
class VerifycodeSucessState extends VerifycodeState {}
class VerifycodeFailState extends VerifycodeState {}
