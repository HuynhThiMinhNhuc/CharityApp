
import 'package:equatable/equatable.dart';

abstract class SinglePostState extends Equatable {
  const SinglePostState();

  @override
  List<Object> get props => [];
}

class SinglePostInProccess extends SinglePostState {
  // final Post post;
  const SinglePostInProccess();
  @override
  List<Object> get props => [];
}

class SinglePostUpdated extends SinglePostState {
  // final Post post;
  const SinglePostUpdated();
  @override
  List<Object> get props => [];
}

class SinglePostUpdateFail extends SinglePostState {
  const SinglePostUpdateFail();
  @override
  List<Object> get props => [];
}
