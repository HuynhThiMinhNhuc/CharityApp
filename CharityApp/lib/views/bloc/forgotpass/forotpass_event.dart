part of 'forotpass_bloc.dart';

abstract class ForotpassEvent extends Equatable {
  const ForotpassEvent({Key? key});

  @override
  List<Object> get props => [];
}

class SentOtp extends ForotpassEvent {
  final String email;
  SentOtp({Key? key, required this.email}) : super(key: key);
}
