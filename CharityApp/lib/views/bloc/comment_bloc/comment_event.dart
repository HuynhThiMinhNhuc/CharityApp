
import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class LoadComments extends CommentEvent {
  final int startIndex;
  final int endIndex;
  final int postId;
  const LoadComments(
      {required this.postId, required this.startIndex, required this.endIndex});

  @override
  List<Object> get props => [postId, startIndex, endIndex];
}

class AddComment extends CommentEvent {
  final String content;

  const AddComment({required this.content});

  @override
  List<Object> get props => [content];
}
