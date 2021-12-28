import 'package:equatable/equatable.dart';

abstract class SinglePostEvent extends Equatable {
  const SinglePostEvent();

  @override
  List<Object> get props => [];
}

class LikeSinglePost extends SinglePostEvent {
  final String postId;
  final bool isLike;
  const LikeSinglePost({required this.postId, required this.isLike});

  @override
  List<Object> get props => [postId];
}

class UnLikeSinglePost extends SinglePostEvent {
  final String postId;
  const UnLikeSinglePost({required this.postId});

  @override
  List<Object> get props => [postId];
}