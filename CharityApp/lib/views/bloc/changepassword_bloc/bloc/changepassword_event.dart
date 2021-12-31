part of 'changepassword_bloc.dart';

abstract class ChangepasswordEvent extends Equatable {
  const ChangepasswordEvent({Key? key});

  @override
  List<Object> get props => [];
}

class ChangepasswordChange extends ChangepasswordEvent {
  final String newpass;
  final String oldpass;
  final String confirmpass;
  final String email;
  ChangepasswordChange(
      {Key? key,
      required this.confirmpass,
      required this.newpass,
      required this.oldpass, required this.email})
      : super(key: key);
}
