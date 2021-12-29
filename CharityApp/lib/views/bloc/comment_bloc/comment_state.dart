
import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:equatable/equatable.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentsLoadInProccess extends CommentState {}

class CommentsLoadSuccess extends CommentState {
  final List<UserComment> comments;
  CommentsLoadSuccess({required this.comments});

  @override
  List<Object> get props => [comments];
}

class CommentsLoadFailure extends CommentState {}
