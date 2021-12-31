part of 'changepassforgot_bloc.dart';

abstract class ChangepassforgotEvent extends Equatable {
  const ChangepassforgotEvent({Key? key});

  @override
  List<Object> get props => [];
}
class ChangepassforgotChange extends ChangepassforgotEvent {
  final String newpass;
  final String confirmpass;
  ChangepassforgotChange(
      {Key? key,
      required this.confirmpass,
      required this.newpass,})
      : super(key: key);
}
