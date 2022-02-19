part of 'forotpass_bloc.dart';

abstract class ForotpassState extends Equatable {
  const ForotpassState();

  @override
  List<Object> get props => [];
}

class ForotpassInitial extends ForotpassState {}

class SentOtpSuccess extends ForotpassState {}

class SentOtpFail extends ForotpassState {}
